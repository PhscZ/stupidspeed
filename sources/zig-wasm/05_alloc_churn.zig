// task 05 alloc_churn — expected output: 1274991808
// build: zig build-exe 05_alloc_churn.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: output goes through std.Io.File.stdout() because Zig 0.16 removed std.posix.write.
// note: the native row uses std.heap.smp_allocator, the 0.16 small-object allocator. That one
//       asserts !single_threaded at comptime, so on wasm32-wasi the allocator here is
//       std.heap.page_allocator, which on wasm is Zig's BrkAllocator: a size-class free list over
//       the wasm heap, i.e. the same small-object allocation the native row measures. The 64-byte
//       buffers therefore come out of reused slots instead of a page mapping per iteration.

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

    var slots = [_]?[]u8{null} ** 256;
    var total: u64 = 0;

    var i: usize = 0;
    while (i < 10_000_000) : (i += 1) {
        const buf = try allocator.alloc(u8, 64);
        buf[0] = @intCast(i % 256);
        total += buf[0];

        const slot = i % 256;
        if (slots[slot]) |replaced| allocator.free(replaced);
        slots[slot] = buf;
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{total});
        try ssReport(io);
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
