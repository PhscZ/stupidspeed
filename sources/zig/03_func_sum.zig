// task 03 func_sum — expected output: 100000000
// build: zig build-exe -O ReleaseFast 03_func_sum.zig -femit-bin=prog    run: ./prog
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

noinline fn add_one(n: u64) u64 {
    return n + 1;
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var value: u64 = 0;
    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        value = add_one(value);
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{value});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
