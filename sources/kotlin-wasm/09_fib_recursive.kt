// task 09 fib_recursive — expected output: 102334155
// build: tools/kotlin/kotlinc/bin/kotlinc-wasm.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-wasm-wasi.klib \
//          -Xwasm-target=wasm-wasi -ir-output-dir klib-wasm -ir-output-name prog 09_fib_recursive.kt
//        tools/kotlin/kotlinc/bin/kotlinc-wasm.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-wasm-wasi.klib \
//          -Xwasm-target=wasm-wasi -Xir-produce-js -Xinclude=<taskdir>/klib-wasm/prog.klib -ir-output-dir <taskdir> -ir-output-name prog
// run: tools/wasmtime46/wasmtime.exe run -W gc=y -W function-references=y -W exceptions=y prog.wasm
// note: the Kotlin/Wasm row, the `wasm-wasi` target of Kotlin 2.4.20 (kotlinc-wasm). The module is
//       plain wasip1 with WasmGC types, so it runs on the wasmtime CLI: `wasmtime46` needs the gc,
//       function-references and exceptions proposals switched on by hand (wasmtime 49 has them on by
//       default), and the V8 column of this row is the same module under node.
// note: the body is the jvm file's (sources/kotlin/09_fib_recursive.kt) with the two clock lines in the wasm
//       form -- kotlin.time.TimeSource.Monotonic instead of System.nanoTime(), and stderr through
//       the wasi_snapshot_preview1 fd_write import instead of System.err, because the wasm-wasi
//       stdlib has no stderr accessor. Tasks 11, 14 and 15 are absent: the stdlib has no thread
//       primitive and no file API.
import kotlin.time.TimeSource
import kotlin.wasm.ExperimentalWasmInterop
import kotlin.wasm.WasmImport
import kotlin.wasm.unsafe.UnsafeWasmMemoryApi
import kotlin.wasm.unsafe.withScopedMemoryAllocator

/** wasi_snapshot_preview1's fd_write, the only way to reach stderr from wasm-wasi. */
@OptIn(ExperimentalWasmInterop::class)
@WasmImport("wasi_snapshot_preview1", "fd_write")
private external fun wasiFdWrite(fd: Int, iovs: Int, iovsLen: Int, nwritten: Int): Int

/** TIME_MS goes to fd 2 -- stderr -- as the contract requires. */
@OptIn(ExperimentalWasmInterop::class, UnsafeWasmMemoryApi::class)
private fun writeErr(message: String) {
    withScopedMemoryAllocator { allocator ->
        val data = message.encodeToByteArray()
        val text = allocator.allocate(data.size + 1)
        var p = text
        for (b in data) {
            p.storeByte(b)
            p += 1
        }
        p.storeByte(0x0A)
        val iov = allocator.allocate(8)
        (iov + 0).storeInt(text.address.toInt())
        (iov + 4).storeInt(data.size + 1)
        val nwritten = allocator.allocate(4)
        wasiFdWrite(2, iov.address.toInt(), 1, nwritten.address.toInt())
    }
}

private fun fib(n: Long): Long {
    if (n < 2L) return n
    return fib(n - 1L) + fib(n - 2L)
}

fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    val result = fib(40L)
    writeErr("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0)
    println(result)
}
