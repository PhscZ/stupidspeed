// task 12 matrix_add — expected output: 999000000
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

const n: usize = 1000;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = std.heap.page_allocator;

    const a = try allocator.alloc(i64, n * n);
    defer allocator.free(a);
    const b = try allocator.alloc(i64, n * n);
    defer allocator.free(b);
    const c = try allocator.alloc(i64, n * n);
    defer allocator.free(c);

    var i: usize = 0;
    while (i < n) : (i += 1) {
        var j: usize = 0;
        while (j < n) : (j += 1) {
            a[i * n + j] = @as(i64, @intCast(i)) + @as(i64, @intCast(j));
        }
    }

    i = 0;
    while (i < n) : (i += 1) {
        var j: usize = 0;
        while (j < n) : (j += 1) {
            b[i * n + j] = @as(i64, @intCast(i)) - @as(i64, @intCast(j));
        }
    }

    i = 0;
    while (i < n) : (i += 1) {
        var j: usize = 0;
        while (j < n) : (j += 1) {
            c[i * n + j] = a[i * n + j] + b[i * n + j];
        }
    }

    var total: i64 = 0;
    var index: usize = 0;
    while (index < n * n) : (index += 1) {
        total += c[index];
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{total});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
