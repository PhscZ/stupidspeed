// task 02 switch_case — expected output: 7500000075000000
// build: zig build-exe 02_switch_case.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: output goes through std.Io.File.stdout() because Zig 0.16 removed std.posix.write.

const std = @import("std");

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

    var acc: u64 = 0;
    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        switch (i % 4) {
            0 => acc += 1,
            1 => acc += i,
            2 => acc += 2 * i,
            3 => acc += 3 * i,
            else => unreachable,
        }
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{acc});
        try ssReport(io);
try std.Io.File.stdout().writeStreamingAll(io, line);
}
