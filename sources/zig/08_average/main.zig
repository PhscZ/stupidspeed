// task 08 average — expected output: 0.498046875
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var total: f64 = 0.0;
    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        const reading = @as(f64, @floatFromInt(i % 256)) / 256.0;
        total += reading;
    }

    const average = total / 100_000_000.0;

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d:.9}\n", .{average});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
