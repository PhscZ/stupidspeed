// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var a: u64 = 0;
    var b: u64 = 0;
    var c: u64 = 0;
    var d: u64 = 0;

    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        if (i % 3 == 0) {
            a += 1;
        } else if (i % 5 == 0) {
            b += 1;
        } else if (i % 7 == 0) {
            c += 1;
        } else {
            d += 1;
        }
    }

    var line_buf: [64]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d} {d} {d} {d}\n", .{ a, b, c, d });
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
