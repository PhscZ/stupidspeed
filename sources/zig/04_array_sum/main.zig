// task 04 array_sum — expected output: 499999500000
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

const count: usize = 1_000_000;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = std.heap.page_allocator;

    const array = try allocator.alloc(i64, count);
    defer allocator.free(array);

    var i: usize = 0;
    while (i < count) : (i += 1) {
        array[i] = @intCast(i);
    }

    var total: i64 = 0;
    i = 0;
    while (i < count) : (i += 1) {
        total += array[i];
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{total});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
