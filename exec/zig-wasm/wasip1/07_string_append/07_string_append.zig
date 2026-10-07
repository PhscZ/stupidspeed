// task 07 string_append — expected output: 250000
// build: zig build-exe 07_string_append.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: output goes through std.Io.File.stdout() because Zig 0.16 removed std.posix.write.
// note: a Zig slice is immutable, so text = text ++ "x" means exactly what is written out below:
//       allocate a buffer one byte longer, copy the old text into it, append 'x', free the old one.

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
    const allocator = std.heap.page_allocator;

    var text: []const u8 = &.{};
    var i: usize = 0;
    while (i < 250_000) : (i += 1) {
        const next = try allocator.alloc(u8, text.len + 1);
        @memcpy(next[0..text.len], text);
        next[text.len] = 'x';
        if (text.len != 0) allocator.free(text);
        text = next;
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{text.len});
        try ssReport(io);
try std.Io.File.stdout().writeStreamingAll(io, line);

    allocator.free(text);
}
