// task 06 char_count — expected output: 10000000
// build: zig build-exe 06_char_count.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: output goes through std.Io.File.stdout() because Zig 0.16 removed std.posix.write.

const std = @import("std");

const block = "abcdefghij";
const text_len: usize = 100_000_000;

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

    // The hundred megabyte text is built once, before the scan.
    const text = try allocator.alloc(u8, text_len);
    defer allocator.free(text);

    var filled: usize = 0;
    while (filled < text_len) : (filled += block.len) {
        @memcpy(text[filled..][0..block.len], block);
    }

    var count: u64 = 0;
    var index: usize = 0;
    while (index < text.len) : (index += 1) {
        const ch = text[index];
        if (ch == 'a') {
            continue;
        } else if (ch == 'e') {
            continue;
        } else if (ch == 'h') {
            count += 1;
        } else {
            continue;
        }
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{count});
        try ssReport(io);
try std.Io.File.stdout().writeStreamingAll(io, line);
}
