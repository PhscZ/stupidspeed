// task 15 file_write — expected output: 104857600
// build: zig build-exe -O ReleaseFast 15_file_write.zig -femit-bin=prog    run: ./prog
// deviation: Zig 0.16 removed std.posix.write and moved std.fs onto std.Io, so the line goes out
// through std.Io.File.stdout() and the file is created with std.Io.Dir.cwd().createFile(io, ..).

const std = @import("std");

const buffer_size: usize = 1 << 20;
const passes: usize = 100;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = std.heap.page_allocator;

    const buffer = try allocator.alloc(u8, buffer_size);
    defer allocator.free(buffer);

    var i: usize = 0;
    while (i < buffer_size) : (i += 1) {
        buffer[i] = @intCast(i % 256);
    }

    const file = try std.Io.Dir.cwd().createFile(io, "out.bin", .{});
    var written: u64 = 0;
    var pass: usize = 0;
    while (pass < passes) : (pass += 1) {
        try file.writeStreamingAll(io, buffer);
        written += buffer.len;
    }
    try file.sync(io);
    file.close(io);

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{written});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
