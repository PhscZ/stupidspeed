// task 09 fib_recursive — expected output: 102334155
// build: zig build-exe -O ReleaseFast 09_fib_recursive.zig -femit-bin=prog    run: ./prog
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

fn fib(n: u64) u64 {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    const value = fib(40);

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{value});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
