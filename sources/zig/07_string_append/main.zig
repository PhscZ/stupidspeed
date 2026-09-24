// task 07 string_append — expected output: 1000000
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().
// A Zig slice is immutable, so text = text ++ "x" means exactly what is written out below:
// allocate a buffer one byte longer, copy the old text into it, append 'x', free the old one.

const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = std.heap.page_allocator;

    var text: []const u8 = &.{};
    var i: usize = 0;
    while (i < 1_000_000) : (i += 1) {
        const next = try allocator.alloc(u8, text.len + 1);
        @memcpy(next[0..text.len], text);
        next[text.len] = 'x';
        if (text.len != 0) allocator.free(text);
        text = next;
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{text.len});
    try std.Io.File.stdout().writeStreamingAll(io, line);

    allocator.free(text);
}
