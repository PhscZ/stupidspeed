// task 08 average — expected output: 0.498046875
// build: zig build-exe -O ReleaseFast 08_average.zig -femit-bin=prog    run: ./prog
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

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

    var total: f64 = 0.0;
    var i: u64 = 0;
    while (i < 100_000_000) : (i += 1) {
        const reading = @as(f64, @floatFromInt(i % 256)) / 256.0;
        total += reading;
    }

    const average = total / 100_000_000.0;

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d:.9}\n", .{average});
        try ssReport(io);
try std.Io.File.stdout().writeStreamingAll(io, line);
}
