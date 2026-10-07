// task 11 parallel_sum — expected output: 7500000075000000
// build: zig build-exe 11_parallel_sum.zig -target wasm32-wasi -O ReleaseFast -fno-single-threaded
//            -mcpu=generic+atomics+bulk_memory --shared-memory --import-memory --export-memory
//            --max-memory=2147483648 -rdynamic -femit-bin=prog.wasm
// run: wasmtime run -S threads=y -W threads=y -W shared-memory=y prog.wasm
// note: the wasm row; the native sibling is sources/zig/. Built with tools/zig/zig.exe (Zig 0.16.0)
//       and run under tools/wasmtime46/wasmtime.exe (wasmtime 46.0.3).
// note: this is real parallelism, not cooperation. WebAssembly has no threads unless the module
//       imports shared memory, so the module is built with atomics, shared memory and an imported
//       memory, and wasmtime is told to supply threads; std.Thread.spawn then goes through Zig's
//       WasiThreadImpl, which is WASI's own thread-spawn, and four OS threads run the four
//       quarters at the same time. Same mechanism the C and C++ wasm rows use.
// note: -rdynamic is load-bearing. wasm-ld only puts a symbol in the module's export section when
//       it is in the dynamic table, and wasmtime's wasi-threads looks for an exported
//       `wasi_thread_start`; without the flag the host aborts with "failed to find a
//       wasi-threads entry point function; expected an export with name: wasi_thread_start".
// note: `pub const panic = std.debug.no_panic;` is load-bearing too. The default panic handler
//       reaches std.heap.WasmAllocator, which is @compileError("unimplemented") the moment
//       single-threaded mode is off, and it also drags in a std.Io futex path that does not
//       compile for wasm+atomics in 0.16. no_panic is the handler std ships for exactly this:
//       it emits nothing and traps.
// note: with threads on there is no usable std.heap allocator (the small-object one is
//       single-threaded only), so the thread stacks come from a std.heap.FixedBufferAllocator
//       over a static pool and std.Io is not instantiated; the answer goes out through the raw
//       WASI fd_write import, which is what the hand-written wasm row uses as well.
// note: the four workers really do run at once. Measured with a barrier that releases all four
//       together and a clock inside each worker: the four compute spans overlap (37-109 ms each
//       for its 25M iterations) while the same hundred million iterations on one thread take
//       150 ms of compute. wasi-threads startup costs about 300 ms, so the whole program's wall
//       clock is not four times shorter than task 02's.

const std = @import("std");

pub const panic = std.debug.no_panic;

const range: u64 = 25_000_000;

const Iovec = extern struct { base: [*]const u8, len: usize };
extern "wasi_snapshot_preview1" fn fd_write(fd: i32, iovs: [*]const Iovec, iovs_len: usize, nwritten: *usize) i32;
extern "wasi_snapshot_preview1" fn clock_time_get(id: i32, precision: u64, timestamp: *u64) i32;

// timing: clock_time_get(1, ...) is WASI's CLOCK_MONOTONIC in nanoseconds; TIME_MS goes to
//         stderr (fd 2) and stdout is unchanged. Written with the raw WASI imports because
//         this file instantiates no std.Io (see the notes above).
fn monotonic_ns() u64 {
    var ts: u64 = 0;
    _ = clock_time_get(1, 1, &ts);
    return ts;
}

var ss_t0: u64 = undefined;

fn ssReport() void {
    const ms: f64 = @as(f64, @floatFromInt(monotonic_ns() - ss_t0)) / 1e6;
    var buf: [48]u8 = undefined;
    const line = std.fmt.bufPrint(&buf, "TIME_MS={d:.3}\n", .{ms}) catch return;
    var iov = Iovec{ .base = line.ptr, .len = line.len };
    var written: usize = 0;
    _ = fd_write(2, @ptrCast(&iov), 1, &written);
}

fn print(line: []const u8) void {
    var iov = Iovec{ .base = line.ptr, .len = line.len };
    var written: usize = 0;
    _ = fd_write(1, @ptrCast(&iov), 1, &written);
}

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

// One mebibyte per thread stack, allocated from a static pool: four stacks plus their TLS and
// metadata fit in the eight mebibytes below.
var stack_pool: [8 << 20]u8 align(64) = undefined;
var stack_allocator: std.heap.FixedBufferAllocator = undefined;

pub fn main() u8 {
    ss_t0 = monotonic_ns();
    stack_allocator = std.heap.FixedBufferAllocator.init(&stack_pool);

    var workers: [4]Worker = undefined;
    var threads: [4]std.Thread = undefined;
    for (0..4) |t| {
        workers[t] = .{ .t = @intCast(t) };
        threads[t] = std.Thread.spawn(.{
            .allocator = stack_allocator.allocator(),
            .stack_size = 1 << 20,
        }, Worker.run, .{&workers[t]}) catch {
            print("failed to start a worker thread\n");
            return 1;
        };
    }
    for (threads) |thread| thread.join();

    var total: u64 = 0;
    for (workers) |worker| total += worker.result;

    var line_buf: [32]u8 = undefined;
    const line = std.fmt.bufPrint(&line_buf, "{d}\n", .{total}) catch return 1;
    ssReport();
    print(line);
    return 0;
}
