// task 14 file_read — expected output: 2389704704
// build: zig build-exe 14_file_read.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm    run: wasmtime run --dir=. prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3), in the directory holding
//       data.bin.
// note: --dir=. is load-bearing: the module is sandboxed and only sees the host directories that
//       are preopened, so without it the open of data.bin fails with access denied.
// note: Zig 0.16 removed std.posix.write and moved std.fs onto std.Io, so output goes through
//       std.Io.File.stdout() and the file is opened with std.Io.Dir.cwd().openFile(io, ..).

const std = @import("std");

const chunk_size: usize = 1 << 20;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = std.heap.page_allocator;

    const chunk = try allocator.alloc(u8, chunk_size);
    defer allocator.free(chunk);

    const file = try std.Io.Dir.cwd().openFile(io, "data.bin", .{});
    defer file.close(io);

    var total: u64 = 0;
    while (true) {
        var buffers = [_][]u8{chunk};
        const got = file.readStreaming(io, &buffers) catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        if (got == 0) break;
        for (chunk[0..got]) |byte| {
            total += byte;
        }
    }

    var line_buf: [32]u8 = undefined;
    const line = try std.fmt.bufPrint(&line_buf, "{d}\n", .{total % 4294967296});
    try std.Io.File.stdout().writeStreamingAll(io, line);
}
