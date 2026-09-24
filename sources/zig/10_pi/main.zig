// task 10 pi — expected output: 44889
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().
// Gibbons' unbounded spigot needs a signed r (it goes negative), so the big integers below are
// sign-magnitude base 10^9 limbs. Every multiplication is by a small integer and both divisions have
// a small quotient, which is what the estimate-and-correct division relies on.

const std = @import("std");

const base: u64 = 1_000_000_000;
const limb_capacity: usize = 24_000; // 10000 digits peak at 484097 bits, which is 16193 limbs
const digits_wanted: usize = 10_000;

const Big = struct {
    limbs: []u64,
    len: usize = 1,
    negative: bool = false,

    fn create(allocator: std.mem.Allocator) !Big {
        return .{ .limbs = try allocator.alloc(u64, limb_capacity) };
    }

    fn destroy(self: *Big, allocator: std.mem.Allocator) void {
        allocator.free(self.limbs);
    }

    fn setSmall(self: *Big, value: u64) void {
        self.limbs[0] = value;
        self.len = 1;
        self.negative = false;
    }

    fn copyFrom(self: *Big, other: *const Big) void {
        @memcpy(self.limbs[0..other.len], other.limbs[0..other.len]);
        self.len = other.len;
        self.negative = other.negative;
    }

    fn trim(self: *Big) void {
        while (self.len > 1 and self.limbs[self.len - 1] == 0) self.len -= 1;
        if (self.len == 1 and self.limbs[0] == 0) self.negative = false;
    }
};

fn cmpMagnitude(a: *const Big, b: *const Big) i8 {
    if (a.len != b.len) return if (a.len < b.len) -1 else 1;
    var i: usize = a.len;
    while (i > 0) {
        i -= 1;
        if (a.limbs[i] != b.limbs[i]) return if (a.limbs[i] < b.limbs[i]) -1 else 1;
    }
    return 0;
}

fn cmpSigned(a: *const Big, b: *const Big) i8 {
    if (a.negative != b.negative) return if (a.negative) -1 else 1;
    const magnitude = cmpMagnitude(a, b);
    return if (a.negative) -magnitude else magnitude;
}

fn addMagnitude(dst: *Big, a: *const Big, b: *const Big) void {
    const longest = @max(a.len, b.len);
    var carry: u64 = 0;
    var i: usize = 0;
    while (i < longest) : (i += 1) {
        const left: u64 = if (i < a.len) a.limbs[i] else 0;
        const right: u64 = if (i < b.len) b.limbs[i] else 0;
        const sum = left + right + carry;
        if (sum >= base) {
            dst.limbs[i] = sum - base;
            carry = 1;
        } else {
            dst.limbs[i] = sum;
            carry = 0;
        }
    }
    dst.len = longest;
    if (carry != 0) {
        dst.limbs[longest] = carry;
        dst.len = longest + 1;
    }
    dst.negative = false;
    dst.trim();
}

fn subMagnitude(dst: *Big, a: *const Big, b: *const Big) void {
    var borrow: u64 = 0;
    var i: usize = 0;
    while (i < a.len) : (i += 1) {
        const right: u64 = if (i < b.len) b.limbs[i] else 0;
        const subtrahend = right + borrow;
        if (a.limbs[i] >= subtrahend) {
            dst.limbs[i] = a.limbs[i] - subtrahend;
            borrow = 0;
        } else {
            dst.limbs[i] = a.limbs[i] + base - subtrahend;
            borrow = 1;
        }
    }
    dst.len = a.len;
    dst.negative = false;
    dst.trim();
}

fn addSigned(dst: *Big, a: *const Big, b: *const Big) void {
    if (a.negative == b.negative) {
        addMagnitude(dst, a, b);
        dst.negative = a.negative;
        dst.trim();
    } else if (cmpMagnitude(a, b) >= 0) {
        subMagnitude(dst, a, b);
        dst.negative = a.negative;
        dst.trim();
    } else {
        subMagnitude(dst, b, a);
        dst.negative = b.negative;
        dst.trim();
    }
}

fn subSigned(dst: *Big, a: *const Big, b: *const Big) void {
    var flipped = b.*;
    if (b.len > 1 or b.limbs[0] != 0) flipped.negative = !b.negative;
    addSigned(dst, a, &flipped);
}

fn mulSmall(dst: *Big, src: *const Big, m: u64) void {
    if (m == 0 or (src.len == 1 and src.limbs[0] == 0)) {
        dst.setSmall(0);
        return;
    }
    var carry: u64 = 0;
    var i: usize = 0;
    while (i < src.len) : (i += 1) {
        const product = src.limbs[i] * m + carry;
        dst.limbs[i] = product % base;
        carry = product / base;
    }
    if (carry != 0) {
        dst.limbs[src.len] = carry;
        dst.len = src.len + 1;
    } else {
        dst.len = src.len;
    }
    dst.negative = src.negative;
    dst.trim();
}

fn compareProduct(scratch: *Big, factor: *const Big, m: u64, target: *const Big) i8 {
    mulSmall(scratch, factor, m);
    return cmpMagnitude(scratch, target);
}

// numerator / denominator, where the quotient is known to fit in one limb: the leading limbs give an
// estimate and the two correction loops make it exact.
fn divQuotient(scratch: *Big, numerator: *const Big, denominator: *const Big) u64 {
    if (cmpMagnitude(numerator, denominator) < 0) return 0;
    var estimate: u64 = undefined;
    if (numerator.len == denominator.len) {
        estimate = numerator.limbs[numerator.len - 1] / denominator.limbs[denominator.len - 1];
    } else {
        const leading = numerator.limbs[numerator.len - 1] * base + numerator.limbs[numerator.len - 2];
        estimate = leading / denominator.limbs[denominator.len - 1];
    }
    if (estimate == 0) estimate = 1;
    while (compareProduct(scratch, denominator, estimate, numerator) > 0) estimate -= 1;
    while (compareProduct(scratch, denominator, estimate + 1, numerator) <= 0) estimate += 1;
    return estimate;
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = std.heap.page_allocator;

    var q = try Big.create(allocator);
    defer q.destroy(allocator);
    var r = try Big.create(allocator);
    defer r.destroy(allocator);
    var t = try Big.create(allocator);
    defer t.destroy(allocator);
    var scratch_a = try Big.create(allocator);
    defer scratch_a.destroy(allocator);
    var scratch_b = try Big.create(allocator);
    defer scratch_b.destroy(allocator);
    var scratch_c = try Big.create(allocator);
    defer scratch_c.destroy(allocator);
    var scratch_d = try Big.create(allocator);
    defer scratch_d.destroy(allocator);

    q.setSmall(1);
    r.setSmall(0);
    t.setSmall(1);
    var k: u64 = 1;
    var n: u64 = 3;
    var l: u64 = 3;

    var emitted: u64 = 0;
    var digit_sum: u64 = 0;
    while (emitted < digits_wanted) {
        // 4*q + r - t < n*t decides whether n is the next digit.
        mulSmall(&scratch_a, &q, 4);
        addSigned(&scratch_a, &scratch_a, &r);
        subSigned(&scratch_a, &scratch_a, &t);
        mulSmall(&scratch_b, &t, n);
        if (cmpSigned(&scratch_a, &scratch_b) < 0) {
            digit_sum += n;
            emitted += 1;
            // q, r, t, k, n, l = 10*q, 10*(r - n*t), t, k, (10*(3*q + r))/t - 10*n, l
            subSigned(&scratch_c, &r, &scratch_b);
            mulSmall(&scratch_c, &scratch_c, 10);
            mulSmall(&scratch_d, &q, 3);
            addSigned(&scratch_d, &scratch_d, &r);
            mulSmall(&scratch_d, &scratch_d, 10);
            const quotient = divQuotient(&scratch_a, &scratch_d, &t);
            n = quotient - 10 * n;
            mulSmall(&q, &q, 10);
            r.copyFrom(&scratch_c);
        } else {
            // q, r, t, k, n, l = q*k, (2*q + r)*l, t*l, k + 1, (q*(7*k + 2) + r*l)/(t*l), l + 2
            mulSmall(&scratch_c, &q, 2);
            addSigned(&scratch_c, &scratch_c, &r);
            mulSmall(&scratch_c, &scratch_c, l);
            mulSmall(&scratch_b, &t, l);
            mulSmall(&scratch_d, &q, 7 * k + 2);
            mulSmall(&scratch_a, &r, l);
            addSigned(&scratch_d, &scratch_d, &scratch_a);
            const quotient = divQuotient(&scratch_a, &scratch_d, &scratch_b);
            mulSmall(&q, &q, k);
            t.copyFrom(&scratch_b);
            r.copyFrom(&scratch_c);
            n = quotient;
            k += 1;
            l += 2;
        }
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{digit_sum});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
