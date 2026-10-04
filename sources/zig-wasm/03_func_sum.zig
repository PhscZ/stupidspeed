// task 03 func_sum — expected output: 100000000
// build: zig build-exe 03_func_sum.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: output goes through std.Io.File.stdout() because Zig 0.16 removed std.posix.write.

const std = @import("std");

noinline fn add_one(n: u64) u64 {
    return n + 1;
}

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

    var value: u64 = 0;
    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        value = add_one(value);
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{value});
        try ssReport(io);
try std.Io.File.stdout().writeStreamingAll(io, line);
}
