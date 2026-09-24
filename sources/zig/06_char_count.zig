// task 06 char_count — expected output: 10000000
// build: zig build-exe -O ReleaseFast 06_char_count.zig -femit-bin=prog    run: ./prog
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

const block = "abcdefghij";
const text_len: usize = 100_000_000;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
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
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
