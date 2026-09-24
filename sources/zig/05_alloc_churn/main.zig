// task 05 alloc_churn — expected output: 1274991808
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().
// The 64-byte buffers come from std.heap.smp_allocator, the 0.16 small-object general-purpose
// allocator, not page_allocator: page_allocator would make every iteration a page mapping.

const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = std.heap.smp_allocator;

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
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
