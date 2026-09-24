// task 02 switch_case — expected output: 7500000075000000
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var acc: u64 = 0;
    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        switch (i % 4) {
            0 => acc += 1,
            1 => acc += i,
            2 => acc += 2 * i,
            3 => acc += 3 * i,
            else => unreachable,
        }
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{acc});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
