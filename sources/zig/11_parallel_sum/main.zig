// task 11 parallel_sum — expected output: 7500000075000000
// build: zig build-exe -O ReleaseFast main.zig    run: ./main
// deviation: Zig 0.16 removed std.posix.write, so the line goes out through std.Io.File.stdout().

const std = @import("std");

const range: u64 = 25_000_000;

const Worker = struct {
    t: u64,
    result: u64 = 0,

    fn run(self: *Worker) void {
        var acc: u64 = 0;
        var i: u64 = self.t * range;
        const end: u64 = (self.t + 1) * range;
        while (i < end) : (i += 1) {
            switch (i % 4) {
                0 => acc += 1,
                1 => acc += i,
                2 => acc += 2 * i,
                3 => acc += 3 * i,
                else => unreachable,
            }
        }
        self.result = acc;
    }
};

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var workers: [4]Worker = undefined;
    var threads: [4]std.Thread = undefined;
    for (0..4) |t| {
        workers[t] = .{ .t = @intCast(t) };
        threads[t] = try std.Thread.spawn(.{}, Worker.run, .{&workers[t]});
    }
    for (threads) |thread| thread.join();

    var total: u64 = 0;
    for (workers) |worker| total += worker.result;

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{total});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
