// task 12 matrix_add — expected output: 999000000
// build: zig build-exe 12_matrix_add.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: output goes through std.Io.File.stdout() because Zig 0.16 removed std.posix.write.

const std = @import("std");

const n: usize = 1000;

// timing: std.Io.Clock.awake is Zig's monotonic clock (CLOCK_MONOTONIC on Linux); TIME_MS
//         goes to stderr and stdout is unchanged.
var ss_t0: std.Io.Clock.Timestamp = undefined;
fn ssReport(io: std.Io) !void {
    const ms = @as(f64, @floatFromInt(ss_t0.untilNow(io).raw.toNanoseconds())) / 1e6;
    var buf: [48]u8 = undefined;
    const s = try std.fmt.bufPrint(&buf, "TIME_MS={d:.3}\n", .{ms});
    try std.Io.File.stderr().writeStreamingAll(io, s);
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    ss_t0 = std.Io.Clock.Timestamp.now(io, .awake);
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
        try ssReport(io);
try std.Io.File.stdout().writeStreamingAll(io, line);
}
