// task 15 file_write — expected output: 419430400
// build: zig build-exe -O ReleaseFast 15_file_write.zig -femit-bin=prog    run: ./prog
// deviation: Zig 0.16 removed std.posix.write and moved std.fs onto std.Io, so the line goes out
// through std.Io.File.stdout() and the file is created with std.Io.Dir.cwd().createFile(io, ..).

const std = @import("std");

const buffer_size: usize = 1 << 20;
const repeats_per_pass: usize = 50;
const passes: usize = 8;

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
    const allocator = std.heap.page_allocator;

    const buffer = try allocator.alloc(u8, buffer_size);
    defer allocator.free(buffer);

    var i: usize = 0;
    while (i < buffer_size) : (i += 1) {
        buffer[i] = @intCast(i % 256);
    }

    var written: u64 = 0;
    var pass: usize = 0;
    while (pass < passes) : (pass += 1) {
        // createFile truncates, so every pass rewrites out.bin from offset 0.
        const file = try std.Io.Dir.cwd().createFile(io, "out.bin", .{});
        var rep: usize = 0;
        while (rep < repeats_per_pass) : (rep += 1) {
            try file.writeStreamingAll(io, buffer);
            written += buffer.len;
        }
        try file.sync(io);
        file.close(io);
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{written});
        try ssReport(io);
try std.Io.File.stdout().writeStreamingAll(io, line);
}
