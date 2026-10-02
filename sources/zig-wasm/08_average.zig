// task 08 average — expected output: 0.498046875
// build: zig build-exe 08_average.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: output goes through std.Io.File.stdout() because Zig 0.16 removed std.posix.write.

const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var total: f64 = 0.0;
    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        const reading = @as(f64, @floatFromInt(i % 256)) / 256.0;
        total += reading;
    }

    const average = total / 100_000_000.0;

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d:.9}\n", .{average});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
