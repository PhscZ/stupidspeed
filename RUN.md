# Run requirements

What has to be installed to execute the built programs, and what the machine has to look
like for the numbers to mean anything. For compilers, see `BUILD.md`.

## Host

| | Requirement | Why |
|---|---|---|
| OS | x86-64, Linux, macOS or Windows | Every row is reachable on Windows and on Linux; macOS loses `msvc` and `dolphin smalltalk`. The `assembly` and `masm` rows are Windows x64 only, because both are freestanding PE programs built against `kernel32.dll`. `tcc`, `clang`, `flang` and `luajit` all need a little care on Windows but no WSL. |
| CPU | 4 physical cores | Task 11 runs four threads. Every other task is pinned to one core, so more cores do not help them. |
| RAM | 8 GB minimum, 16 GB comfortable | The tasks themselves are small: the largest allocation is task 06's 100 MB text, and task 12's three 1000x1000 arrays are 24 MB together. The 16 GB is for the JVM, GraalVM and Julia toolchains. `native-image` alone wants 2–4 GB to build. |
| Disk | 32 GB free | 100 MiB of fixtures, plus the toolchains themselves: `BUILD.md` measured 23 GB for all 78 installed and run, and the fourteen rows before the newest four add about 6.5 GB — Octave's tree alone is 2.6 GiB, Eiffel's 1.28 GB, Beef's 845 MB and the Scala Native row's 833 MB — and the four newest add about 1.3 GB, mostly Dyalog's 855 MB interpreter tree, so budget about 31 GB for all 96. The six original WebAssembly rows add about **1.7 GB**: the wasi-sdk tree is 1.5 GiB, unpacked from a 591 MiB tarball that has to sit beside it while it extracts, the AssemblyScript package is 102 MiB and the wasmtime zip 44 MiB, and the hand-written row installs nothing at all. The four rows after those add about **1.3 GB**, almost all of it TinyGo's bundled LLVM tree: the GraalVM JDK and the Go SDK were already counted, and Cython is 15 MB. The three interpreted WebAssembly rows add about **0.14 GB** on top of that — the single-file `ruby.wasm` is 99 MB, CPython's module and stdlib tree are 39 MB, and the Lua build reuses the wasi-sdk tree already counted — so the nine come to about 1.85 GB. The fourteen rows added last come to about **5.5 GB**, dominated by Lean 4's toolchain at 3.1 GB (its Windows zip is 811 MB compressed) and Pony's bundled LLVM at 475 MB, with Factor at 219 MB, Pharo's image at 163 MB, Boo's built solution at 62 MB and everything else under 50 MB; Zig's wasm row adds nothing, because it reuses the native `zig` tree, and SQLite reuses the MSYS2 tree already counted. GDC is 556 MB unpacked, because the only Windows GDC in existence is a 2015 crosstool-NG build that carries its own binutils and a statically linked phobos. The newest batch swaps the two hardware-description rows for OpenJ9 (388 MB) and MASM (nothing extra, since `ml64.exe` and `link.exe` come from the MSVC tree), and adds Unicon (84 MB unpacked), plus the four newest rows at about 4.4 GB — GHC's bindist is 4.1 GB of that on its own, with gforth, Lobster and Mercury making up the rest. The budget is therefore about **44 GB for all 142**. The batch before the newest adds about 1 GB — QB64-PE 814 MB (it carries a whole C++ toolchain), babashka 73 MB, Jython 49 MB, DuckDB 36 MB, flat assembler 3 MB and QuickJS 2 MB. The newest six add almost nothing: **Euphoria is 52 MB** extracted, and the other four — `erlc`, `ocamlc`, `julia --compile=min` and `R_ENABLE_JIT=0` — reuse the tree their base row already installs. The MSYS2 tree that `valac` needs is 2.2 GB of the base total on its own, with another 2–3 GB of scratch while reassembling MSVC and Swift. |
| Filesystem | `tmpfs` or RAM disk preferred for the file tasks | Reading 50 MiB from a spinning disk measures the disk. Anything run under WSL2 measures the WSL disk layer instead. Where the fixture lives must be recorded in the results. |

## Runtimes

Languages compiled to a static native binary need nothing. The rest need the following.

| Language | Toolchain | Runtime needed | Notes |
|---|---|---|---|
| C | gcc, clang, msvc, tcc | glibc + libpthread, MSVC runtime | MSVC build needs the UCRT |
| C++ | g++, clang++ | libstdc++ or libc++ | |
| C++ | msvc | MSVC runtime | |
| Rust | rustc | none | links libstdc statically by default |
| Zig | zig | none | static by default |
| Go | gc | none | static without cgo |
| Go | tinygo | none | standalone executable; TinyGo's runtime is linked in. It has no fsync on Windows, so task 15 flushes by closing. |
| D | dmd, ldc2 | libphobos | or build with `-static` |
| Swift | swiftc | Swift runtime libraries | unless statically linked |
| Fortran | gfortran | libgfortran | |
| Fortran | flang | Fortran runtime | |
| Ada | gnat | libgnat | |
| Pascal | fpc | none | static by default |
| Nim | nim | none | static by default |
| Odin | odin | none | |
| Assembly | x86-64 nasm | none | freestanding PE, `kernel32.dll` only |
| Assembly | x86-64 masm | none | freestanding PE, `kernel32.dll` only |
| Assembly | x86-64 fasm | none | freestanding PE, `kernel32.dll` only |
| Dolphin Smalltalk | Dolphin 8 | MSVC x86 runtime (`vcruntime140.dll` + `msvcp140.dll`) | the VM is 32-bit, so it needs the x86 runtime, not the x64 one |
| Groovy | groovy | JRE 17 or newer | the distribution ships its own `groovy.bat` launcher |
| Tcl | tclsh | none | task 11 also needs the `Thread` extension, see `BUILD.md` |
| Java | openjdk | JRE 17 or newer | |
| Java | openj9 | the Semeru JDK's own JRE (`tools/openj9/`) | Eclipse OpenJ9 21; the same class files as `openjdk`, no JVM flags, and `java.lang.Thread` maps to OS threads so task 11 is a real four-thread pass |
| Java | graalvm jit | the GraalVM JDK itself, 21 or newer | no JVM flags needed: GraalVM's `java` has `UseJVMCICompiler` on by default, so it compiles the bytecode with the Graal compiler instead of HotSpot's C2 |
| Java | loom | JRE 21 or newer | the same class files as `openjdk`; only task 11 differs, and it uses `Thread.ofVirtual()`, which is final since 21 |
| Java | graalvm native-image | none | standalone binary |
| Kotlin | jvm | JRE + kotlin-stdlib | |
| Kotlin | native | none | |
| C# | coreclr | .NET 8 runtime | |
| C# | nativeaot | none | |
| C# | mono | Mono runtime | |
| F# | dotnet | .NET 8 runtime | |
| VB.NET | dotnet | .NET 8 runtime | same SDK and runtime as C# and F# |
| Scala | jvm | JRE + scala library | |
| Dart | aot | none | |
| Dart | jit | Dart VM | |
| JavaScript | node, bun, deno | the runtime itself | `node <task>.js` and `bun <task>.js` need nothing; the sources are CommonJS, which Deno 2 only accepts with **`--unstable-detect-cjs`**. Deno also denies the filesystem by default, so task 11 (its `worker_threads` re-read the script file) and task 14 need `--allow-read` and task 15 needs `--allow-write`; without them it stops with `Requires read access to …`. |
| JavaScript | spidermonkey | the shell binary is the whole runtime | `js.exe <task>.js`. Real OS threads via `evalInWorker`, which runs its argument on a separate thread; cross-thread data needs a `SharedArrayBuffer` that the main thread has registered with `setSharedArrayBuffer()` first, with `Atomics` for the join — without that registration the worker's `getSharedArrayBuffer()` throws `RangeError`. Task 10 is a built-in-bignum cell: BigInt is native. `os.file.readFile(name, "binary")` gives the bytes as an ArrayBuffer, and `os.file` has no chunked read or append, so tasks 14 and 15 read and write the whole 50 MiB in one call. |
| JavaScript | quickjs | none | the binary is the whole runtime. Needs `--std` for the `std`/`os` modules, which is also what gives stderr. No threads. |
| PHP | zend | PHP + opcache | task 11 needs the `parallel` PECL extension, which stock PHP does not ship and which requires a ZTS build. |
| PHP | zend + jit | PHP + opcache | JIT needs `opcache.enable_cli=1`. The stock Windows zip ships no `php.ini`, so JIT is off until you write one and set `opcache.jit_buffer_size`. Same `parallel` requirement as the row above for task 11. |
| Python | cpython, pypy, graalpy | the interpreter | |
| Python | jython | the JRE (`openj9`'s JDK) plus the standalone jar | Jython 2.7.4 is Python 2 — `print` is a statement and `xrange` is the loop form. `long` is arbitrary precision and `java.lang.Thread` is real threads. |
| Python | cython | the interpreter's `python3xx.dll` | the built `.exe` is **not** standalone: it imports the CPython DLL, so the matching CPython installation has to be beside it or on `PATH`. That DLL is the interpreter the program embeds, not a runtime for the compiled code — the loops are native. |
| Python | nuitka | none | standalone binary |
| Ruby | cruby + yjit | Ruby | **the stock Windows build has no YJIT**: `ruby --yjit` warns "Ruby was built without YJIT support". The `cruby + yjit` row needs a Ruby built with rustc present. |
| Ruby | jruby | JRE + JRuby | needs Java 25 |
| Lua | puc-lua, luajit | the interpreter | task 11 also needs the Lanes extension, see below. A Windows Lua distribution that ships `luarocks.exe` (the 5.4.6 build used here) installs it with one command, `luarocks install lanes`, given a MinGW `gcc` on `PATH`; the rock lands outside the interpreter tree, so `LUA_PATH`/`LUA_CPATH` must point at it or `require("lanes")` fails with `module 'lanes' not found`. |
| Luau | luau, lute | the interpreter, and Lute for tasks 11, 14 and 15 | the plain Luau CLI has no file I/O and no process API at all — no `io`, no `os.execute`, no `package` — so those three tasks need Lute, the Luau team's own runtime. |
| Pony | ponyc | none | a static binary. **0.65.0 specifically**: 0.66.0 raised the Windows floor to 11 / Server 2022, see `BUILD.md`. |
| Lean 4 | lean | none | the compiled binary is standalone; the `leanc` linker driver links against the toolchain's own tree at build time only. |
| Common Lisp | ecl | none | the `.fas` is loaded by `ecl.exe` itself, so the interpreter tree is the runtime. |
| Boo | booc | .NET 10 runtime | the emitted assembly needs `Boo.Lang.dll` and a `prog.runtimeconfig.json` beside it, or it fails before `Main`. |
| IronPython | ipy | .NET 8 runtime | drive `tools/ironpython/net8.0/ipy.dll` through `dotnet`; the zip contains no `ipy.exe`. |
| Gleam | gleam | Erlang/OTP | the generated `.beam` runs on the same OTP tree the `erlang` and `elixir` rows install, so this row adds no runtime. |
| Pharo | Pharo 13 | the image | `--quit --no-source` keeps the run from saving the image or compiling the script into it. |
| Arc | Anarki on Racket | Racket 9.3 | the host's own boot is about 30 s and sits inside every measured run. |
| Factor | factor | none — the distribution carries its own image | `factor.exe <task>.factor` from `sources/factor/`. |
| SQLite | sqlite3 | none | the CLI is the whole toolchain. |
| DuckDB | duckdb | none | the CLI is the whole toolchain. Needs `-no-init` on Windows (`-init /dev/null` fails) and `.binary on` to stop CRLF translation of the stderr timing line. `VARINT` exists but only `+`/`-` are exact on it, so task 10 hand-rolls limbs. |
| Unicon | unicon | none — the produced `.exe` is self-contained (the runtime is appended to the icode, so nothing from `tools/unicon` is needed at run time; verified with a clean `PATH`) | `tools/unicon/bin` must be on `PATH` to compile. The build is `unicon -s <task>.icn`, which writes `<task>.exe`; task 03 also names `03_func_sum_add_one.icn` on the same line. Both the compiler and the executables it produces read their own appended image through `argv[0]`, so invoke them with a **Windows-style backslash path** — `C:\…\prog.exe` runs, `C:/…/prog.exe` dies with `can't read interpreter file header`. Tasks 14 and 15 open their files in **untranslated** mode (`"u"` / `"wu"`): the default buffered mode is a text stream that stops at the `0x1A` at offset 26 of `data.bin` and reads 26 bytes instead of 50 MiB. **Unicon 13.3 is required for task 11**; 13.2 is built without concurrent threads. |
| Haskell | ghc | none — the RTS is linked into the executable | `ghc -O2 -threaded -o prog <task>.hs`, then `prog`. Task 11 is run as `prog +RTS -N4 -RTS`, which gives the runtime four capabilities; the other tasks need no RTS flag. Task 07 appends to a `ByteString`, not a `String` — a `String` is a linked list of characters and 250000 quadratic appends to one does not finish in any useful time, where `ByteString` does the same whole-accumulator copy at memcpy speed. Task 15 flushes and closes: Haskell's standard library exposes no fsync, so this row is in the flush-and-close group. |
| Lobster | lobster | none — the interpreter is the whole toolchain | No build step: `tools/lobster/bin/lobster.exe <task>.lobster`, run from `sources/lobster/` so that `data.bin`/`out.bin` resolve. Task 03 has no no-inline annotation, so `add_one` is passed as a `fn` value through a parameter with an explicit function type, which forces an indirect call rather than an inlined one. Task 07 appends in place because Lobster's `+=` grows a uniquely-referenced string, so the cell is linear rather than quadratic — the deviation the Raku, Erlang and Elixir rows already record. Task 11 uses Lobster's own worker threads. |
| Forth | gforth | none — the interpreter tree is the runtime | No build step: `gforth <task>.fs`. Needs `GFORTHPATH=<gforth dir>;.` so that the image `gforth.fi` and the working directory's `data.bin` are both findable. Task 14 reads the fixture in binary and prints the byte sum mod 2^32, as the C row does. Task 15 flushes and closes: gforth has no fsync, so this row is in the flush-and-close group. Task 11 cannot use threads on Windows — `cilk.fs` requires `unix/pthread.fs`, which is Unix-only — so the four workers are four child processes started with `start /b`, each writing its partial to a temp file that the parent polls for and sums; measured, four workers take about the same wall time as one where running them in sequence would take four times as long. Note for anyone editing this row: `exit` inside a `DO`/`LOOP` does not unwind the loop frame in this gforth build, so early returns need `unloop exit`. |
| Euphoria | eui | none — the interpreter is the whole toolchain | `EUDIR` must be set to the install root. No reachable stderr, so `TIME_MS` goes to `time.txt`; the clock is `QueryPerformanceCounter` via FFI. `std/task.e` segfaults, so task 11 is four child processes. |
| Mercury | mmc | none — the compiled executable is standalone | `mercury_compile --make <module> --grade hlc.gc.pregen` (with `tools/mercury/bin` on `PATH` and `MERCURY_STDLIB_DIR` set) produces `<module>.exe`, named after the module rather than the file, and the measured run is that executable. Task 10 uses Mercury's own `integer` module, which is arbitrary precision, so it is a built-in-bignum cell. **Task 11 needs a different grade**: the default `hlc.gc.pregen` has no parallelism, so that one cell is compiled `hlc.par.gc`, Mercury's own parallel grade, with `thread.spawn` workers and `thread.mvar` for the join. |
| D | gdc | none | the 2015 Windows GDC links phobos statically, so the executable is standalone; it is just very large (13 MB) because of it. |
| Perl | perl | Perl | |
| R | gnu-r | R | task 11 uses the bundled `parallel` package, PSOCK mode |
| R | gnu-r (no JIT) | R | Set **`R_ENABLE_JIT=0`** and run `Rscript <task>.R` — same fifteen files as the `gnu-r` row. The env var is required rather than `compiler::enableJIT(0)`, because the latter does not reach task 11's PSOCK workers. About 4.4x slower: task 01 is 362 s. |
| Julia | julia | Julia | about 1 GB with the standard library. Task 11 must run as `julia -t4 <task>.jl`, or `Threads.@threads` stays on one thread. |
| Julia | julia (interpreted) | Julia | `julia --compile=min -O0 <task>.jl`, and **`-t4` for task 11** (without it the four `Threads.@threads` workers share one thread and the cell is a correct-answer-no-speedup). Same fifteen files as the `julia` row. Interpreter, not JIT: the worst cells are 942 s (task 13) and 954 s (task 14) against ~20 ms compiled. |
| GDScript | godot --headless | Godot binary | roughly a second of startup on its own |
| PowerShell | powershell, pwsh | .NET runtime | **not a shell in the usual sense.** See below. |
| Crystal | crystal | none | static by default; needs the MSVC toolchain to link |
| Objective-C | clang | `libobjc-4.6.dll` + `gnustep-base-1_31.dll` + UCRT | the GNUstep runtime ships with the MSYS2 `ucrt64` packages |
| Modula-2 | adw | none | static by default; the `time.txt` fallback carries `TIME_MS`, because ADW exposes no stderr handle. The clock is ISO `SysClock.GetClock` — local time of day, whole seconds plus `SysClock.fractions` — so a cell under a second is read in whole seconds. |
| Modula-3 | cm3 | **three DLLs must sit beside the exe** — `m3.dll`, `m3core.dll`, and `arithmetic.dll` for task 10 | the produced `AMD64_NT\prog.exe` imports the cm3 runtime, so without them it exits `53` (`STATUS_DLL_NOT_FOUND`) before `main` with no diagnostic. `time.txt` carries `TIME_MS`, because Modula-3's `IO` has no stderr stream; the clock is `Time.Now` (seconds since the epoch as a `REAL`). |
| COBOL | gnucobol | `libcob-4.dll` + UCRT | from MSYS2 `ucrt64` |
| BASIC | freebasic | none | static by default |
| BASIC | qb64 | none — the built .exe is static | QB64-PE compiles through C++, so each build takes a few seconds. `PRINT` pads numbers; the rows use `LTRIM$(STR$(x))`. No threads. |
| V | v | none | static by default; needs a C compiler to build |
| ATS | ats | none | static by default; needs a C compiler to build |
| C3 | c3c | none | static by default; needs the MSVC SDK to link |
| Vala | valac | `libglib-2.0-0.dll` (and `libgobject-2.0-0.dll` for task 10) for the tasks that call GLib | from MSYS2 `ucrt64`; the tasks that call no GLib function link nothing extra and run with a bare system `PATH`. Static linking fails, so the DLLs have to be reachable. |
| Oberon-07 | akron | none | static by default; the compiler's `Compiler.exe` is a standalone Windows binary |
| Component Pascal | gpcp | .NET 8 runtime | the compiler produces a .NET assembly, not a native binary, and every executable needs `RTS.dll` beside it — plus `RealStr.dll` for task 08 and `GPFiles.dll` + `GPBinFiles.dll` for tasks 14 and 15. Those DLLs are **not** found on `PATH`. |
| Algol 68 | a68g | Cygwin runtime (`cygwin1.dll`) | compiler-interpreter, so the "build" and the "run" are the same command; task 06 needs `--heap 1900000000` (a CHAR is 16 bytes here), and the parallel clause needs the Cygwin build, see `BUILD.md` |
| ActionScript | AIR | none — the runtime is bundled | `adt -target cmdline` puts a captive AIR runtime beside the executable, so the bundle is self-contained and needs no separate install. The bundle is a directory, not a single file: `prog.exe`, `prog.swf`, `Adobe AIR\`, `META-INF\` and `mimetype` all have to stay together. Two things about it are unusual and are covered below: it prints a startup banner, and it has no working-directory API. |
| Clojure | clojure.main | a JRE (17 or newer; Clojure supports 8 through 25) plus the three runtime jars | No build step and no installer. The three jars are the whole toolchain; `clojure.main` compiles the source as it runs. Set `JAVA_HOME` per row rather than relying on whatever `java` is first on `PATH`. |
| Clojure | babashka | none | a GraalVM native binary with no JVM. Single-threaded (`future` serialises), so task 11 is four child processes. |
| Racket | racket (CS) | none — the installation tree is the runtime | Relocatable, but it has to move as a unit: the DLL and `collects` paths are embedded in the executables relative to the executable's own location. `Racket.exe` is the console program; task 11 uses `racket/place`, which is in `base` and therefore present even in Minimal Racket. |
| OCaml | ocamlopt | none — native static binary | The MSYS2 UCRT64 build needs the UCRT64 DLLs on `PATH` at run time, and building needs `OCAMLLIB` set to the Windows form of the stdlib path plus the `flexdll` package; see `BUILD.md`. |
| OCaml | ocamlc (bytecode) | the MSYS2 UCRT64 OCaml runtime (`ocamlrun.exe` and `dllunixbyt.dll` must be reachable) | `ocamlc -I +unix unix.cma -o prog.exe _<task>.ml` then `./prog.exe`, both inside the MSYS2 shell. Same fifteen files as the native row. |
| Raku | rakudo (MoarVM) | the extracted Rakudo tree | No build step. The MSI installs per-machine by default, so extract it with `msiexec /a` for a no-admin row. |
| Erlang | OTP (escript) | the extracted OTP tree | No build step. `escript` compiles the script on each run. Run with `-smp enable` so all schedulers are live. |
| Erlang | erlc (compiled) | the same extracted OTP tree | Two steps: `erlc <task>.erl` writes `<task>.beam`, then `erl -noshell -s <task> main -s init stop`. Module form, so the per-run compile the escript row pays is gone. Task 11 is a real four-worker parallel pass. |
| Elixir | elixir (BEAM) | Erlang's tree plus Elixir's | No build step. Elixir needs Erlang on `PATH` first; `elixir` then compiles the script each run. |
| VBScript | cscript | none — `cscript.exe` ships with Windows | The runtime is a Windows component rather than something you install, which is also why the row is on borrowed time: see the platform table below. |
| Common Lisp | sbcl | none — the dumped executable embeds the core | The build dumps a standalone `prog.exe` with `save-lisp-and-die`, so nothing has to be on `PATH` at run time. Task 11 uses `sb-thread`, which is a required part of the Windows build. |
| C, C++, Rust, Go, AssemblyScript, WebAssembly, Ruby, Lua, Python, Zig (the ten wasm rows that run on 46) | wasmtime 46.0.3 | the `wasmtime.exe` from the release zip under `tools/wasmtime46/` | `wasmtime run prog.wasm`. Tasks 14 and 15 add `--dir=.` from a directory holding `data.bin`; Go's two cells need `--dir=<host>::/` instead, because Go opens its preopens by the WASI name and expects `/`. Task 11 adds `-S threads=y -W threads=y -W shared-memory=y` and **needs 46**, because `wasi-threads` was deleted in 47. Startup is part of every cell: measured, a no-op module costs 44 ms against 30 ms for a native executable and 31 ms for `wasmtime-min`. |
| TinyGo (wasip1) | 0.42 | `prog.wasm`, built by TinyGo | `wasmtime prog.wasm`, the same runtime and version as the other wasm rows. No feature flags: the module is plain wasip1 and runs on 46 and 49 alike. Its task 11 is a correct-answer-no-speedup cell, because Go's `wasip1` port has no thread support and the four goroutines are multiplexed onto the single wasm thread. The build needs `wasm-opt.exe` beside `tinygo.exe`, which the release zip does not ship. |
| Lua (`wasmtime 46.0.3` or newer) | 5.4.8 | `lua.wasm`, built once with the wasi-sdk tree (see `BUILD.md`) | `wasmtime -W exceptions=y --dir . lua.wasm <task>.lua`. The `-W exceptions=y` is mandatory: Lua's `pcall`/`error` path lowers onto the exception-handling proposal, and wasmtime's `exceptions` feature is off by default, so without it the module fails to compile with `legacy_exceptions feature required for try instruction`. `--dir .` is needed on **every** cell, not just 14 and 15, because the script itself is read through the preopen. |
| Python (`wasmtime 46.0.3`, the `-threads` module) | 3.12.2 | `python.wasm` plus its `lib/python3.12` tree, built once with the wasi-sdk (see `BUILD.md`) | `wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py`, run from the directory holding both the module and `lib/`. **46 is mandatory here**: the module is built for `wasm32-wasip1-threads`, so 49 refuses the `-S threads` flag outright and the module's `threading.Thread` needs it. The stdlib tree has to sit beside the module, or the interpreter stops with `Could not find platform independent libraries <prefix>`. |
| Ruby (`wasmtime 46.0.3` or newer) | 2.10.1 (CRuby 4.1.0) | the single-file `ruby.wasm` from ruby/ruby.wasm, 99 MB | `wasmtime --dir . ruby.wasm <task>.rb`. No feature flags: the module is plain wasip1 and runs on 46 and 49 alike. `--dir .` is needed on every cell, because the script itself is read through the preopen. |
| Scala | native | none | Standalone `.exe`. The link is static, so not even llvm-mingw's `libc++.dll` is needed; without `--native-linking=-static` the executable dies with `STATUS_DLL_NOT_FOUND` when llvm-mingw's `bin` is off the DLL search path. |
| Beef | BeefBuild | none — static native binary | A Release build links the Beef runtime statically. The executable imports only `kernel32.dll`, `msvcrt.dll`, `user32.dll`, `SHELL32.dll`, `ole32.dll`, `gdi32.dll`, `version.dll` and `comdlg32.dll`; no Beef DLL has to be present. Process start-up is about 110–190 ms, which is a third of the row's slowest cell. |
| Haxe | hxcpp | none — native static binary | `-D no_shared_libs` links gcc, libstdc++ and libwinpthread statically; `objdump -p` on the produced executable lists only `KERNEL32.dll`, `USER32.dll`, `WS2_32.dll` and the `api-ms-win-crt-*` UCRT imports. Without that define hxcpp copies `libgcc_s_seh-1.dll`, `libstdc++-6.dll` and `libwinpthread-1.dll` beside the executable. |
| Haxe | hashlink | `libhl.dll` must sit beside `hl.exe` (the extracted tree provides both) | Two steps: `haxe -cp sources/hashlink -main <module> -hl <out>.hl`, then `hl <out>.hl`. The module name must equal the file name and start uppercase, so the files are `T01_branches.hx` etc. **`Int` is 32-bit on this target**, so every accumulator that can exceed 2^31 is a `Float` (exact below 2^53) or a `haxe.Int64`. **There is no thread API**: `sys.thread` does not resolve, and the bundled `hl.uv` bindings expose no thread creation, so task 11's four workers are four child `hl` processes — each writes its partial to a file, the parent waits on `exitCode()` and sums the files, the same shape the VBScript, COBOL, Octave and gforth rows use. Task 10 hand-rolls base-1e9 limbs in `haxe.Int64`. |
| Eiffel | eiffelstudio (`ec -finalize`) | none | The finalized executable links the Eiffel run-time into itself statically; the fifteen `prog.exe` files are self-contained and need no MinGW DLL. |
| Seed7 | s7c | none | The compiled executable is self-contained and needs nothing from the Seed7 tree at run time. Only the compile needs `gcc` on `PATH`. |
| Scheme | chez | none — the installed Chez tree is the runtime (`bin/ta6nt/scheme.exe` plus `boot/ta6nt/scheme.boot`) | No build step. The tree is relocatable but must move as a unit: on Windows the boot files are found at `<exe>\..\..\boot\<machine type>` and in the executable's own directory. It must be the **threaded** build (`ta6nt`) — a non-threaded build has no `fork-thread` and task 11 cannot run. `--optimize-level 3 --script <task>.ss` is the run line; the boot-file load and the on-the-fly compile are part of every measured run. |
| Prolog (SWI) | swipl | the extracted SWI-Prolog tree (`tools/swipl/bin/swipl.exe`) | No build step. The tree is relocatable — it finds its home from the executable's own path, with `SWI_HOME_DIR` or `--home` as an override. Run from `sources/swipl/`, because task 03 loads `03_func_sum_add_one.pl` relative to the source file and task 14 reads `data.bin` from the working directory. |
| Octave | octave-cli | the extracted Octave tree | No build step. `octave-cli.exe -qf <task>.m`, run from `sources/octave/`. No threads in core and `fork` is not implemented on native Windows, so task 11 starts four `octave-cli` child processes; Octave exposes no `fsync`, so task 15 flushes and closes. Task 03 loads `add_one.m` from the working directory. |
| J | jconsole | the extracted `j9.7` tree | No build step. The profile loads the standard library, which is what provides `exit`, `stdout`, `echo` and `LF`; run `jconsole.exe <task>.ijs` and end the script with `exit 0`, or jconsole drops into its interactive prompt. `-jprofile` breaks this and must not be used. `j.dll` needs the VC++ x64 runtime. |
| Janet | janet | none — the extracted install tree is the runtime | No build step; `janet` compiles the script each run. The binary needs the MSVC runtime (`vcruntime140.dll`); the release also ships a static Cosmopolitan `janet.com` as a fallback. Task 11 uses the core `ev/` threads, so nothing extra is installed. |
| Ring | ring | none — the extracted tree is the runtime | No build step; the tree has to stay intact, because `load` resolves `ring/bin` and `ring/bin/load` relative to the executable rather than to the working directory. Task 11 also needs `bin\ring_threads.dll` beside `ring.exe`, which the light release does not ship; see `BUILD.md`. |
| JScript | cscript | none — `cscript.exe` ships with Windows | Windows Script Host's Active Scripting JScript engine, which is not the `JavaScript` row's node/bun/deno. The `.js` extension is mapped to it; `//E:JScript` is passed explicitly. On Windows 11 24H2 and later the engine is JScript9Legacy, which reports 11.0.16384, rather than classic JScript 5.8. Task 03 needs `03_func_sum_add_one.js` beside it; tasks 14 and 15 need the working directory to hold `data.bin` and to be writable for `out.bin`. |
| AutoHotkey | v2 | none — the extracted ZIP is the runtime (Windows-only) | No build step. `AutoHotkey64.exe /ErrorStdOut <task>.ahk`; the interpreter prints nothing on start-up, so the row's stdout is exactly the one expected line. Task 11 needs no extra install: the four workers are four child processes. |
| Standard ML | Poly/ML | `PolyLib.dll` must be beside the executable | No build step at run time: the `.obj` the compiler exports contains the whole heap image, and the stub's `WinMain` loads it. Without `PolyLib.dll` next to the `.exe` the program dies before `main` with `STATUS_DLL_NOT_FOUND` and prints nothing. An exported program has no banner and no prompt — the top-level loop never starts — so the row's stdout is exactly the one expected line. Start-up floor about 65 ms. Tasks 14 and 15 run from `sources/standardml/` so that `data.bin`/`out.bin` resolve; task 14 reads in 65536-byte chunks. |
| Terra | terra | none, but the interpreter needs `VCINSTALLDIR` set and `INCLUDE` pointing at a C sysroot | No build step: `terra.exe <task>.t` compiles and JITs on every run, so that compile is inside the measured number, and an empty program still costs 36-50 ms. **`VCINSTALLDIR` must be non-nil or the interpreter aborts before opening the file** with `Can't find windows SDK version 8.1 or 10!` — it is a switch, the path is never read. `INCLUDE` is needed only by task 11, which includes `windows.h`; on this host it points at `tools/llvm-mingw/include`. Nothing is linked, so no MSVC and no Windows SDK are required. Task 15 syncs through `_commit`, so this row is not in the flush-and-close group. Tasks 14 and 15 run from `sources/terra/` so that `data.bin`/`out.bin` resolve. |
| Dyalog APL | dyalog | the extracted interpreter tree | No build step: `dyascript.exe -script <task>.dyalog`, run from `sources/dyalog/`. **`dyascript.exe` is the console build**; `dyalog.exe`, `dyalogrt.exe` and `dyaedit.exe` are GUI-subsystem programs whose output never reaches a console. `-script` is mandatory — without it the interpreter starts a Session instead of running the file. `⎕IO←0` and `⎕PP←17` are required in every source: the default `⎕PP` of 10 prints task 02's total as `7.500000075E15`, which is `WRONG`. Runs unregistered, with nothing on stdout or stderr at start-up; the `UNREGISTERED` banner is interactive-mode-only and goes to stderr. Start-up floor about 0.2-0.25 s. Task 03 loads `AddOne.dyalog` with `2 ⎕FIX`; tasks 14 and 15 use the working directory for `data.bin`/`out.bin`. |
| Nelua | nelua | none — native static binary | The compiled executable is self-contained and needs nothing at run time; only the compile needs the toolchain tree and a C compiler. `nelua.bat` has to be invoked through `cmd.exe`, and the build must run from `sources/nelua/` because `require` resolves against the working directory. Task 03's helper is a second module with `<noinline>`. Task 15 syncs through `_commit`, so this row is not in the flush-and-close group either. Tasks 14 and 15 run from `sources/nelua/` so that `data.bin`/`out.bin` resolve. |

### JVM versions are not interchangeable

Nine rows need a JVM, and they disagree about which one:

- `jruby` needs **Java 25**; on Java 24 and older it dies with `UnsupportedClassVersionError`.
- `kotlin/native` needs a JDK for its launcher. The 1.9-era launcher mis-parsed JDK 24's version string and failed with a batch syntax error; the current 2.4.20 prebuilt drives JDK 25.0.2 fine, so the constraint is a launcher-version question rather than a JDK ceiling. The first build downloads its LLVM and libffi dependencies (about 1.4 GB) into `%USERPROFILE%\.konan`.
- `scala` needs anything modern. Oracle's `java8path` shim, if it is ahead of the real JDK on `PATH`, makes `scalac` fail on class file version 61.0.
- `graalvm native-image` is its own JDK 25.
- `java/graalvm jit` needs **GraalVM's own JDK**, not any JDK: a plain OpenJDK has no Graal compiler in it, so running the class files under HotSpot would silently be the `openjdk` row again. GraalVM 25 is the JDK the `native-image`, `graalpy` and `jruby` rows already need.
- `java/loom` needs **JDK 21 or newer** for `Thread.ofVirtual()`. On JDK 17 it does not compile; on 19 and 20 it compiles only with `--enable-preview` and `--release 19 --enable-preview` at run time.

- `java/openj9` needs **IBM Semeru's JDK**, not any JDK: OpenJ9 is a different VM from HotSpot, and running the same class files under HotSpot would silently be the `openjdk` row again. It ships its own `javac`, so the row is self-contained.

Set `JAVA_HOME` per row rather than relying on whatever `java` resolves to. On a machine with
several JDKs installed, the default `PATH` order is usually the wrong one for at least two of
these rows. The `openjdk` and `loom` rows are the exception that proves the rule: they are
interchangeable apart from task 11, and the `loom` row's other fourteen cells are the `openjdk`
row's cells, so a difference there is a difference in the JDK rather than in the row. `openj9`
is the opposite case — the same fifteen files and the same `javac` invocation, a different VM
executing them, so every one of its cells is a VM comparison.

## PowerShell is a real language

`powershell` is not a shell in the POSIX sense. It is a full language with typed data and
real concurrency, and it can do far more of these tasks than a POSIX shell could. Every
claim below was measured, not assumed.

| Task | Needs | PowerShell 5.1 |
|---|---|---|
| 05 `alloc_churn` | allocation and GC | yes, the .NET GC |
| 08 `average` | floating point | yes, `[double]` |
| 10 `pi` | big integers | yes, `System.Numerics.BigInteger` |
| 11 `parallel_sum` | threads | yes, runspace pools |

### Task 11, measured

Four workers of 25000000 iterations each, 100000000 total:

| | Result | Time | Speedup vs serial |
|---|---|---|---|
| PowerShell, runspace pool | `7500000075000000` | **75.9 s** | 3.48x |
| (serial, for reference) | `7500000075000000` | ~264 s | 1x |

It prints the same number as the single-threaded task 02, which is the point of the task.

How it does it: `[runspacefactory]::CreateRunspacePool(1, 4)`, backed by real .NET thread
pool threads. `Start-Job` is the wrong choice here because it spawns a process per job,
and `ForEach-Object -Parallel` does not exist before PowerShell 7.

It should be listed beside C# and F#, not beside a POSIX shell.

## Task 11: which languages can actually do it

Task 11 is the only task whose mechanism differs per language, and the only one that is not
portable at all: the Assembly rows can only do it on Windows. This is what each language
actually has, verified by running the task or by reading the official documentation.

### Real OS threads, no problem

C, C++, Rust, Zig, Go, D, Swift, Ada, Pascal, Java (three rows: `openjdk` uses
`java.lang.Thread`, `openj9` uses the same call on OpenJ9, which maps it to an OS thread, and
`loom` uses `Thread.ofVirtual()`, and the virtual threads are just as
parallel — an in-process probe of the identical loop measured **2.92x** for four virtual threads
and **2.92x** for four platform threads on a 20-core host), Kotlin (both rows), C#, F#, VB.NET,
Scala (both rows), Nim, Odin, Julia (`-t4`), Fortran (OpenMP, needs `-fopenmp`), Perl (ithreads),
PHP (`parallel`, needs a ZTS build), PowerShell (runspace pools), Crystal (`Fiber::ExecutionContext::Parallel`),
Objective-C (`NSThread`), Modula-2 (Win32 `Threads` module), Modula-3 (`Thread.Fork`), BASIC (`THREADCREATE`),
Groovy (`java.lang.Thread`), Clojure (`java.lang.Thread` interop, not `future`), Common Lisp (`sb-thread:make-thread` on real Win32 threads), OCaml (`Domain.spawn`/`Domain.join`, OCaml 5 only), Erlang and Elixir (`spawn` onto a BEAM scheduler, one per core, no global lock), Raku (`start`, which MoarVM runs through `uv_thread_create`), Vala (`GLib.Thread`), Component Pascal (the .NET `Threading` module,
via `REGISTER` on a bound method with the foreign `Th.ThreadStart` delegate), C3 (`std::thread`),
Beef (`System.Threading.Thread`; `CreateThread`, `ResumeThread` and `SetThreadPriority` are in the
executable's import table), Haxe (`sys.thread.Thread.create`, which hxcpp implements as
`CreateThread`), Eiffel (EiffelThread's `THREAD` mapped onto Win32 threads, with the project's
concurrency capability set to `thread`), Scheme (`fork-thread`/`thread-join` on a threaded
`ta6nt` build, directly on the Windows API), Prolog (SWI) (`library(thread)`: `thread_create/3` +
`thread_join/2`, partials returned through `thread_send_message/2` because the goal is copied),
J (`0 T. ''` plus `u t. n y` tasks, futex-based threadpools with no GIL; measured 1.7x rather than
4x, because J's explicit verbs run about 1.8x slower inside a worker thread than on the master
thread), Ring (the distribution's own Threads extension, a TinyCThread binding over Win32 threads
with no GIL — the light release does not ship it, see below),
Oberon-07 (raw `CreateThread` + `WaitForSingleObject` declared as foreign procedures, no thread
module in its library),
Assembly (raw `CreateThread` + `WaitForSingleObject`, no libc and no C runtime),
Standard ML (Poly/ML's `Thread.Thread.fork`, whose Windows arm is literally `CreateThread` in
`libpolyml/processes.cpp`; measured **3.30x** on four workers, with `Thread.Mutex` +
`Thread.ConditionVar` for the join — note the nesting, the functions live in `Thread.Thread`,
not `Thread`),
Terra (`CreateThread` through `terralib.includec("windows.h")`; measured **3.72x** with four
distinct thread ids and a process CPU/wall ratio of 4.75),
Nelua (`require 'C.threads'`, the standard library's C11 binding over `CreateThread`, with the
GC's `nogc` pragma because a collected allocator shared across raw threads is not safe; measured
**3.5x**),
Unicon (the `thread` keyword, which since version 12 creates a concurrent co-expression that the
runtime implements on POSIX threads; `wait(t)` joins but returns the thread rather than a value,
so each worker publishes its partial sum into a list marked with `mutex()`, which the language
locks implicitly. Measured **2.43x** on four workers — 18.84 s against 45.73 s for the identical
four chunks run serially. **13.3 only**: the 13.2 Windows release is built without concurrent
threads, `unicon -features` omits the feature there, and `thread` fails at run time with
`function not supported`).

**Six more rows added later are in this group too.** Pony (`Worker` actors scheduled by the
runtime's thread pool — an in-process probe reading `runtime_info.Scheduler.scheduler_index()`
reports the four workers on schedulers 1, 2, 0 and 3 at `--ponymaxthreads=4 --ponynoscale`, and
all four on scheduler 0 at `--ponymaxthreads=1`), Boo (`System.Threading.Thread` on CoreCLR),
Lean 4 (`IO.asTask`, which hands the action to Lean's task pool — the compiled program holds 12
OS threads while four workers run; measured 2992 ms on one worker against 1876 ms on four on a
busy 8-core box), Arc (Racket's `(thread thunk #:pool 'own)`, the one Racket route that is not
green), IronPython (a real .NET `System.Threading.Thread`, with no GIL in the CPython sense —
measured 12.1 s on one thread against 6.8 s on four, a real 1.8x limited by interpreter
bookkeeping rather than by a lock), and Gleam (BEAM schedulers, one per core, no global lock —
the same disposition as the Erlang and Elixir rows).

**The six WebAssembly rows that pass** are one mechanism, and it is a third kind: C, C++, Rust,
AssemblyScript, the hand-written WAT row and Zig all reach the host's thread API through
`wasi-threads` — the module imports `wasi::thread-spawn`, exports `wasi_thread_start`, and the
runtime creates the OS thread, hands it the module's shared memory, and calls the export on it.
The four quarters are real OS threads on real cores; the hand-written row measured **2.66x** on
four workers (0.142 s against task 02's 0.379 s, both 100000000 iterations). It is neither a
language facility nor a foreign declaration of the OS's own calls, so it sits between the two
kinds already described. It is also the only task-11 mechanism in the matrix that depends on the
runtime's **version**: `wasi-threads` was deleted in wasmtime 47, so every one of these cells
needs wasmtime 46.0.3 or older and cannot be run on a current runtime at all. Go is the exception
among the seven and is described under the no-speedup group below, because Go's wasip1 port has no
thread support: goroutines there are multiplexed onto the single wasm thread, so its cell is
correct and serial.

The last two are the same kind of row: a language with no thread facility that gets real threads
anyway by declaring the operating system's own calls, which is legitimate under the task's
wording and is recorded per row in `BUILD.md`. Oberon-07's start routine has to be declared with
the Windows calling convention, so the procedure *and* the procedure type both carry it.

### Passes, but not faster than its own task 02

| Language | What it has | Measured |
|---|---|---|
| Algol 68 | a real parallel clause, `PAR (unit, unit, unit, unit)`, four pthreads | `7500000075000000`, in the same ~2.5 minutes as task 02 — a correct-answer-no-speedup cell |
| Dyalog APL | `f&Y`, the language's own spawn operator, with `⎕TSYNC` as the join. `⎕TID` is 0 on the master and `1 2 3 4` in the four workers, and `⎕TNUMS` reports `0 4 3 2 1`, so four threads really are created. | `7500000075000000`, **0.99 CPU per wall second** (124.05 s CPU in 125.24 s wall, measured with `GetProcessTimes` over all threads), and four 5 M-iteration workers take 4.12x the time of one — exactly serial. The threaded form is *slower* than the identical serial work (86.2 s against 73.8 s), because the spawn and `⎕TSYNC` bookkeeping is pure overhead. |
| Go (tinygo) | TinyGo's default `tasks` scheduler: the goroutines are cooperative and every one of them runs on the single OS thread. `-scheduler=cores` and `-scheduler=threads` cannot be substituted on this host — they do not build for Windows/amd64 at all, the first stopping on `undefined: calleeSavedRegs` and the second on `undefined: threadID`, because neither has a Windows implementation in `internal/task`. | `7500000075000000`, and the work is serial: an in-process probe of the identical loop measured **0.89x** (43.6 ms on four goroutines against 39.0 ms serially), and the row's own task 11 (432 ms) is slower than its task 02 (283 ms). |
| TinyGo (wasip1) | Go's `wasip1` port has no thread support, so the four goroutines are multiplexed onto the single wasm thread by TinyGo's asyncify scheduler. The same disposition as CPython and CRuby. | `7500000075000000`, serial |
| Pharo | `Process`/`Semaphore`, which are **green**: the VM multiplexes the whole image onto one OS thread, so four forked workers interleave and never run at once. There is no OS-thread class in the image. Every production Smalltalk is in this position, the same one the Dolphin row records. | `7500000075000000`, **3037 ms** as four forked Processes against the serial task 02's **2714 ms** — the `fork`/`Semaphore` machinery is if anything slower than the plain loop, so the cell is correct-answer-no-speedup |
| Factor | four `future`s from `concurrency.futures`, which is `threads`' own co-operative green-thread scheduler, not OS threads | `7500000075000000`, **~8.3 s** as four futures against **~5.0 s** for the same four chunks run sequentially — the extra scheduling and per-thread data-stack machinery costs more than the parallelism saves |

Algol 68's parallel clause is not a broken feature and not a mis-written program: the
implementation copies a whole stack on every unit switch, and its own source says the clause
"has been included for educational purposes; this implementation is not the most efficient
one" (`rts-parallel.c`). Four pthreads really are created, the units really do overlap, and
the four-way answer is right; the bookkeeping simply costs more than the parallelism saves.
Treat the cell like CPython's and CRuby's.

Dyalog is in this group for the same reason seen from the other side: the threads are real and
`⎕TID` proves there are four of them, but the interpreter switches between them at statement
boundaries inside one execution engine, so APL code in a defined function is serialised. A probe
that spawns a background `:While 1` counter and then runs a 2 000 000-iteration loop on the
master **starved the master for its whole timeout**, which is the same fact from the other
direction. This is not the J row's position: J's `T.`/`t.` threads measure 1.7x, Dyalog's `&`
gives none.

### Works, but not with shared-memory threads

| Language | What it has | Measured |
|---|---|---|
| JavaScript | `worker_threads`, one thread each with its own heap | `7500000075000000` |
| Dart | isolates, each with its own memory, message passing only | documented |
| R | `PSOCK` cluster: separate R processes | `7500000075000000` (timing not measured, see below) |
| Lua | needs the Lanes C extension (or llthreads2) | `7500000075000000`, **3.56x on 4 threads** |
| Python | threads exist but the GIL serializes them | correct, **0.97x** — use `multiprocessing` for 2.3x |
| Python (wasip1) | the same `threading.Thread` source, running inside wasmtime; CPython's GIL is still there | correct, and the work is serial for the same reason the `cpython` row's is |
| Python (cython) | the same `threading.Thread` source, compiled; Cython runs it under the same GIL | correct, and measured serial: an in-process probe of the identical loop gave **1.03x** on four threads, against CPython's 0.97x. Cython does not release the GIL from a pure-mode module |
| Ruby (CRuby) | threads exist but the GVL serializes them | correct, no speedup |
| Ruby (ruby.wasm) | no threads at all: CRuby's WASI build is configured `THREAD_MODEL=none`, so `Thread.new` raises `initialize() function is unimplemented on this machine`, and `Ractor.new` is stubbed the same way. The four workers are **Fibers**, the language's own cooperative concurrency. | `7500000075000000`, and the work is serial: measured, the fiber version takes 20.7 s against the native serial task 02's 19.8-27.0 s |
| Lua (lua.wasm) | no threads: the native rows use the Lanes C extension, which is a pthreads binding with no wasm build. The four workers are **coroutines**, the language's own cooperative concurrency. | `7500000075000000`, and the work is serial: measured, the coroutine version takes 2.3 s against task 02's 2.6 s |
| ActionScript | AIR `Worker`: separate AVM2 instances, no shared memory, results via shared properties | `7500000075000000`, **2.91x on 4 workers** |
| VBScript | four `WScript.Shell.Exec` child processes, one per quarter, partials read back from each child's stdout | `7500000075000000`, **3.41x on 4 processes** |
| Racket | `(thread thunk #:pool 'own #:keep 'results)`: each thread gets its own OS thread with the heap shared, and `thread-wait` returns the result. Plain `thread` is green and `future` serialises at blocking operations, so neither is used. | `7500000075000000`, real multicore work |
| Janet | `ev/spawn-thread`/`ev/thread` + `ev/thread-chan`: one OS thread per worker, each with its own heap, partials sent back over a threaded channel (the isolates shape Dart and JavaScript use) | `7500000075000000`, **4.9x on 4 threads** |
| Octave | four `octave-cli` child processes of the same file, one per quarter, started with `popen` and joined by reading each child's stdout; the worker index travels in the environment | `7500000075000000`, **3.13x on 4 processes** |
| Seed7 | four `startPipe` child processes of the same executable, one per quarter, partials read back from each child's stdout with `getln(childStdOut(p))` and joined with `waitFor` | `7500000075000000`, real parallelism across four cores |
| JScript | four `WScript.Shell.Exec` child processes, one per quarter, partials read back from each child's stdout | `7500000075000000`, real parallelism on four cores, but not a clean 4x over task 02 — see below |
| AutoHotkey | four `WScript.Shell.Exec` child processes of the same script, one per quarter, each printing its partial sum to stdout; the parent reads each child's `StdOut`, which blocks until that child exits and is therefore the join | `7500000075000000`, real parallelism across four cores; see the note below |
| Luau | four child processes, one per quarter, launched with Lute's `@lute/process.run` and read back through their stdout. The plain Luau CLI cannot do this at all: it exposes no `io`, no `os.execute` and no `package`, so the row's tasks 11, 14 and 15 need **Lute**, the Luau team's own runtime, while tasks 01–13 run under `luau.exe` | `7500000075000000`, real parallelism: four concurrent children measured 1.46 s wall against 3.42 s sequential |
| SQLite | four child processes of `sqlite3.exe`, one per quarter, started from a generated batch file with `start /b`, each writing its partial to a file and renaming it into place as the join signal. SQL has no threads to start and no way to declare one — `PRAGMA threads=N` parallelises only SQLite's own sort and index building, never arbitrary user computation | `7500000075000000`, real parallelism across four cores |

### The rows that need explaining

**Lua.** Stock Lua has no threads, only coroutines, which are cooperative and
single-threaded. But `lanes` is a mature C extension that wraps real OS threads, and it
works: Lua 5.4.6 with Lanes 3.17.2 produced `7500000075000000` and ran **3.56x faster on four
threads**. So Lua is not `SKIPPED`, but it needs `luarocks install lanes` first. The
alternatives are `lua-llthreads2` and `LuaThread`, both also C extensions.

**R.** R has no threads for R code at all. `parallel::mclapply` forks processes and is
**Unix only** — on Windows it fails with `'mc.cores' > 1 is not supported on Windows`, and
`makeCluster(type="FORK")` fails with `fork clusters are not supported on Windows`. What
does work everywhere is `makeCluster(type="PSOCK")`, which starts separate R processes and
communicates over sockets. That produces the right answer. The `0.07 s against 0.15 s` figure
this file used to quote for it is not consistent with the current task: 100000000 interpreter
iterations of a `switch` cannot finish in 0.15 s when CPython needs 10 to 15 s and PowerShell
264 s for the same work, so treat the R timing as unmeasured until it is re-run.
Note that PSOCK workers start with an empty environment, so constants must be pushed out
with `clusterExport` or they fail with `object 'N' not found`.

Threading in R exists only inside C-level packages, such as OpenMP in `data.table` or TBB
in `RcppParallel`. Plain R code never runs on two threads.

**Assembly.** A freestanding PE program has no libc, so there is no `pthread_create` to call
and no thread library to link, and no C runtime to start one for it either. The task is still
four threads: `11_parallel_sum.asm` calls `CreateThread` four times, each worker on its own
stack, and joins them with `WaitForSingleObject`. Each worker is task 02's jump-table switch
over a fixed range of 25000000 iterations, so the four together print the same number as task
02. It passes, and it is Windows x64 only. Both assembler rows do this the same way — the
`nasm` row and the `masm` row differ in assembler and syntax, not in mechanism.

**COBOL.** GnuCOBOL has no threads, so the four workers are four forked processes:
`11_parallel_sum.cob` calls `CBL_GC_FORK` — GnuCOBOL's own process facility, the COBOL
equivalent of the R row's forked workers — and each child writes its quarter's partial sum to
its own file, which the parent adds up after `CBL_GC_WAITPID` returns for all four. It passes
on Linux. GnuCOBOL documents `CBL_GC_FORK` as unavailable on Windows outside Cygwin, where it
returns -1 with a warning; the program then computes the four quarters in-process, so Windows
still prints the right answer on one core. That is the same fallback the Fortran and Julia
rows take without their thread flag.

**Dolphin Smalltalk.** The VM has `Process`, `ProcessorScheduler` and `Semaphore`, and they
are real, but they are green: the whole image is multiplexed onto one OS thread. Task 11
therefore prints `7500000075000000` with no speedup over task 02, the same cell CPython and
CRuby get. Every production Smalltalk is in this position — Squeak, Pharo, Cuis, VisualWorks
and GNU Smalltalk all schedule green — so the caveat is a property of Smalltalk, not of
Dolphin.

**Tcl.** The core has no threads, so task 11 uses the `Thread` package, the language's own
threading extension, which is the same exception Lua's Lanes gets. Each thread contains its
own Tcl interpreter and the work is sent to it as a script, so the four workers share no
mutable state. The dispatch uses `thread::send -async`, which hands the script over and
returns at once so all four workers start together; each one then sends its partial back to
the main thread, which waits on a counter with `vwait`. A plain `thread::send` would be
synchronous and would wait for worker *t* to finish before starting worker *t+1*, leaving the
four quarters serialised on one core. Measured at a quarter scale, the async form runs the
same work in 0.87 s against 2.7 s for the serial one, a 3.1x speedup on four threads.

**Ring.** The core language has no thread keyword, but the distribution's own Threads
extension (`load "threads.ring"`, a TinyCThread binding over Win32 threads) creates real OS
threads, and the VM has no GIL: `ring_vm_createthreadstate` gives each worker its own VM state
that **shares the global scope**, so each worker writes its quarter's partial into its own slot
of a global list and the parent sums the four after `thrd_join`. The partials cannot come back
through `thrd_join` itself, whose result is a C `int`, and a quarter of this task is about
1.9e15. Measured: 8.1–10.4 s wall with about 3.3 cores busy, against 20.2–22.4 s wall for the
same four quarters run one after another in the same function — a real 2.2x on four threads.
The extension is not in the light release; `BUILD.md` records the six files and the one `gcc`
line that build it.

**Pony.** Two things about this row are load-bearing. The first is the version: ponyc **0.65.0**,
not the current release. Pony 0.66.0 reworked how it does networking on Windows and the release
notes now give the minimum as Windows 11 / Server 2022 (build 20348), because the new networking
layer uses an OS readiness API introduced in that build. This machine is Windows 10 19045, and
0.65.0 predates the change, so it is the last release that runs here — the same class of
constraint as `poly/ml`'s 5.9.1 and `wasmtime`'s 46.0.3. The second is task 03. Pony has no
no-inline marker, and ponyc compiles every package into a single LLVM module, so a plain
`fun add_one` is inlined and the hundred-million-iteration loop is constant-folded away
completely: `ponyc --pass=ir` shows the loop replaced by the constant `100000000`, and the
program then takes 0.07 s doing no work. The row calls through a trait-typed receiver instead,
and the IR dump shows a real loop whose body loads the method pointer out of the object and makes
an indirect call every iteration — 0.5 s against 0.07 s on an idle host. That is a documented
deviation from "put the function in its own file", and it is the only way to keep the call in
Pony.

**ECL.** This row exists because conda-forge is the only prebuilt Windows route to ECL.
`ecl.common-lisp.dev` publishes source tarballs and nothing else, and neither MSYS2 nor Cygwin
carries an `ecl` package, so a package manager that does not normally ship compilers is what
supplies this one. ECL compiles to C and shells out to a C compiler to build the `.fas`, which
means the row has to point it at the hand-extracted MSVC tree with `c::*cc*`/`c::*ld*` plus
`INCLUDE` and `LIB`; without that it falls back to the interpreter and the numbers are not
comparable with SBCL's. Its thread support is the `mp` package, which is present in this build
and is what task 11 uses.

**GDC.** There is no current GDC on Windows, and the reason is worth recording because it
looks like there should be. Cygwin *does* package `gcc-gdc`, and installing it gives you a
working `gdc.exe` and its `d21` backend — but **no D runtime whatsoever**: no `object.d`, no
phobos, no druntime. The first compile dies with `cannot find source code for runtime library
file 'object.d'`, and there is no companion package to install, because Cygwin's `gcc` series
ships `gcc-core`, `gcc-g++`, `gcc-fortran`, `gcc-gdc` and `gcc-objc` with no D runtime among
them. MSYS2 packages no `gdc` at all, and WinLibs — the standalone Windows GCC whose own front
page advertises C, C++, Objective-C, Fortran *and* D — ships no `gdc` binary in any of its
archives.

The row therefore runs on **GDC 4.9.2 with D 2.066.1**, built in April 2015, which is the last
native-Windows GDC that has ever been published. It comes from gdcproject.org's own binary
archive; the newer-looking directories beside it (`6.3.0`, `5.4.0`, `5.2.0`) hold Linux-hosted
cross-compilers, not Windows binaries, so there is nothing to upgrade to. Building one was
tried and abandoned: a GCC bootstrap with `--enable-languages=d,c` needs GMP, MPFR and MPC
development files (only the first two are Cygwin packages), and on this host it compiled **one
object per minute** at `-j4`, which puts the remaining thousand objects and libphobos at over
twenty hours. The obvious shortcut does not exist either — GCC's libphobos cannot be configured
standalone against the system `gdc`, because `core.stdc.*` needs the D front end that the GCC
tree itself builds, and the standalone configure dies on `undefined identifier 'fpos_t'`.

Two consequences are recorded in `BUILD.md`. Fourteen of the fifteen tasks compile unmodified;
**task 03 does not**, because `pragma(inline, false)` only arrived in D 2.070, so the shared
source carries a `version(GNU)` branch that keeps the call real by going through a reference of
abstract base type instead — all three D toolchains still build one file. And task 11 is
genuinely parallel here: `core.thread` gives real OS threads, measured at **198 ms for task 02
against 123 ms** for the same work on four threads.

**Luau.** The plain Luau CLI cannot run three of the fifteen tasks, and not for an interesting
reason: it exposes **no file I/O and no process API at all**. Dumping `_G` shows no `io`, no
`os.execute`, no `package`, no `dofile` and no `loadfile`, and its `os` is exactly
`{clock, date, difftime, time}`. Its only file access is `require()` of Luau source. So
`data.bin`, `out.bin` and the four child processes of task 11 are unreachable under `luau.exe`,
not merely awkward. The row runs tasks 01–13 under `luau.exe` and tasks 11, 14 and 15 under
**Lute**, the Luau team's own runtime, which supplies `@lute/fs` and `@lute/process.run` and a
scheduler on which `process.run` yields — four concurrent children measured 1.46 s wall against
3.42 s sequential. Leaving the standard library is allowed here for the same reason Lua's Lanes
is: the rules say task 11 may use the language's own threading extension when the standard
library has none, and Lute is Luau's own runtime rather than a third-party bolt-on.

**SQLite.** The first row in this matrix that is not a programming language in the usual sense.
It is here because it has all four things the tasks need — loops (recursive CTEs), 64-bit
integers, floating point and file I/O — and because a language that only has set operations is
an interesting point in the matrix. Every loop in the row is `WITH RECURSIVE c(x) AS (SELECT 0
UNION ALL SELECT x+1 FROM c WHERE x < N)`, which is SQL's own way to count and is not unrolled
or memoised; the four-way decision of tasks 01 and 02 becomes conditional aggregates over that
counter table, which is the same single pass the scalar version makes because the branches are
disjoint. Task 11 is four child processes, because `PRAGMA threads=N` parallelises only SQLite's
own sort and index building and never arbitrary user computation.

**Zig (wasm).** The wasm row is the native `sources/zig/` row's sibling, and Zig reaches
`wasi-threads` the same way C and C++ do — but with a flag the C rows do not need. `-rdynamic` is
load-bearing: wasm-ld only exports symbols listed in the dynamic table, and without it the module
instantiates and then dies with `failed to find a wasi-threads entry point function; expected an
export with name: wasi_thread_start`. `-fno-single-threaded` is also required, because Zig's
default for wasm is single-threaded and `std.Thread.spawn` does not exist without it. The
verification is a barrier test rather than a timing: all four workers spin on an atomic counter
until all four have arrived, which cannot complete under cooperative scheduling, and the four
spans then overlap.

**Arc.** Arc here is Anarki, Arc 3.2 plus its `lib/` tree, hosted on Racket. That matters for
task 11: Racket's plain `thread` is green and `future` silently serialises as soon as its body
blocks, so the row uses `(thread thunk #:pool 'own #:keep 'results)`, the one Racket route that
runs the thunk on its own OS thread with the heap shared. That needs Racket 8.18 or later, and
this is 9.3. The host's own boot is about 30 s on this machine and is inside every measured run,
which is a real cost for the short tasks.

**Terra.** The mechanism is ordinary — four `CreateThread` workers through
`terralib.includec("windows.h")`, joined with `WaitForSingleObject`, measured at 3.72x with four
distinct thread ids and a process CPU/wall ratio of 4.75 — but the *cell* needs a note because
of what it costs. Terra is the only row whose task 11 includes a C header, and parsing
`windows.h` with the bundled clang takes **1.3-1.7 s**, which dominates the cell's ~1.3 s total:
the threaded work itself is about 13 ms. So this cell measures a header parse plus the
parallelism, not the parallelism alone, and it is the only task in that row that pays the cost.
That is also why the row needs no MSVC and no Windows SDK — nothing is ever linked, and the one
header is read by Terra's own clang. The same `INCLUDE` that makes this task work is what
`VCINSTALLDIR` gates: without a non-nil `VCINSTALLDIR` the interpreter aborts before it opens
any file at all.

### Cannot do it

**GDScript.** Godot has a `Thread` class and it works, but it is awkward to use for this
shape of problem and Godot's headless startup is about a second, which swamps the task.
Treat it as a very slow pass rather than a skip.

**No row is in this group.** Every language here has a task 11 source, so no cell is `SKIPPED`
for want of a concurrency facility. Three rows were expected to land here and none of them did:
Oberon-07 and Component Pascal each have a route to real threads. Four other rows genuinely
could not do it and are no longer in the benchmark at all — AWK, Squirrel, Oberon-2 and BCPL.
The group stays documented because it is where a language with no concurrency at all would
land. Simula was removed for a different reason, recorded in `README.md`: it has no wall-clock
facility, so it cannot report its own elapsed time.

### What this means for the wording

Task 11 says "start 4 threads". Under that wording:

- Pass: assembly (`CreateThread`), Oberon-07 (`CreateThread`), and everything in the
  threads list above.
- Pass, but with processes rather than threads: R, COBOL on Linux (`CBL_GC_FORK`), VBScript
  (`WScript.Shell.Exec` children), Octave (four `octave-cli` children via `popen`), Seed7
  (four `startPipe` children), JScript and AutoHotkey (both four `WScript.Shell.Exec` children
  of the same script), and JavaScript if you count worker threads as not being threads.
  ActionScript belongs here too:
  AIR `Worker`s run on real OS threads but are separate AVM2 instances with no shared memory,
  so they are isolates rather than threads in the same sense Dart's are.
- Pass, with the GIL/GVL caveat recorded: CPython, CRuby and Dolphin Smalltalk, whose `Process`
  objects are green and multiplexed onto one OS thread. `Cython` belongs here too:
  its task 11 is the `cpython` row's `threading.Thread` source compiled unchanged, and
  pure-mode Cython does not release the GIL, so the four workers serialise exactly as CPython's
  do. `Go (tinygo)` belongs
  here too: TinyGo's `tasks` scheduler is cooperative, so its four goroutines run one after
  another on a single OS thread, and the same is true of the `Ruby (ruby.wasm)` and
  `Lua (lua.wasm)` rows, whose task 11 is Fibers and coroutines because their wasip1 builds
  have no threads at all. The `Python (wasip1)` row is in this group too, and it is the only
  one that really does start four OS threads: CPython's `-threads` WASI build supports
  `threading.Thread` and wasmtime's `wasi-threads` creates them, but the GIL serialises the
  work exactly as it does in the native row, so the answer is right and the speedup is not
  real. `jruby` and Groovy are
  unaffected and use real JVM threads. Algol 68 belongs in this group for a different reason —
  its four pthreads are real and overlap, but the implementation's stack copying costs more
  than the parallelism returns, so it is a correct-answer-no-speedup cell too.
  Dyalog APL is here for the third: `&` creates four threads that `⎕TID` can name, but the
  interpreter serialises them inside one execution engine, measured at 0.99 CPU per wall second.
- Pass, but only with an extra install or flag: Lua (Lanes), Tcl (the `Thread` package),
  Ring (the Threads extension, which the light release omits),
  PHP (`parallel` on a ZTS build), Julia (`-t4`), Fortran (`-fopenmp`), Algol 68 Genie (a
  source build with `--enable-parallel`). Without the flag Julia and Fortran still print the
  right answer, because their loops fall back to serial; without it a68g refuses to parse `PAR`
  at all.
- Pass, but only with the toolchain's own environment set: Terra, whose interpreter refuses to
  start without a non-nil `VCINSTALLDIR` and whose task 11 needs `INCLUDE` pointing at a C
  sysroot for `windows.h`. Standard ML and Nelua need no flag, but both need a build step that
  is not a single command (Poly/ML's exported object plus a `gcc` link; Nelua's repository
  interpreter built once with `mingw32-make`).

If the task instead says "4 concurrent workers", everything above passes and the comparison
becomes "does this language use more than one core", which is the more useful question. That
wording also lets R and Lua participate, and it keeps the informative result that CPython and
CRuby print the right answer with no speedup.

## ActionScript's quirks

Six of these are properties of the AIR runtime rather than of the programs, and each is
handled the same way by every task in the row. They are worth reading before writing any
AIR program: most of them fail silently.

**A fixed startup banner precedes the program's output.** Every AIR process writes a
2354-byte ASCII-art banner to stdout before the program's first line — the HARMAN logo and
`A SAMSUNG COMPANY`, hardcoded in `Adobe AIR.dll`. It is unconditional: it is not a splash
screen, the descriptor has no option for it (it is absent from the 51.4 descriptor schema),
and there is no environment variable or command-line flag that suppresses it. The packaged
`-target cmdline` executable prints it exactly as the `adl` development runner does. The
offset is deterministic, so the runner should skip the first 2354 bytes of stdout and compare
what follows; the program's own output is then one line, the same as every other row. This is
the one row where the expected line is not at the start of stdout, which is why the harness
has to know the offset rather than just trimming whitespace. If a run ever needs the raw
stream, the banner is the first 2354 bytes and the answer is everything after it.

**There is no working-directory API.** AIR deliberately hides the process working directory:
`flash.filesystem.File` has no accessor for it, and constructing a relative `File` (as in
`new File("data.bin")`) throws rather than resolving against it — it does not fall back to
the current directory. Task 14 therefore reads `data.bin` from `File.applicationDirectory`,
the bundle the executable lives in, so the runner has to **build the bundle with `data.bin`
present** (the `adt` line passes it as an extra file) rather than dropping the fixture into
the working directory as every other row expects. Task 15 cannot write there at all — see
below — so it writes to the application storage directory instead. The bytes read and written,
and both answers, are identical to every other row's; only where the files sit differs.

**No fsync.** `FileStream` has no commit call, so task 15's deviation is flush and close,
the same one Tcl, D, Julia, Nim, Dart, Pascal, COBOL, Dolphin, Haxe, Eiffel, Seed7, Scheme,
Prolog (SWI), Octave, J, Janet, Ring and JScript note.

**No filesystem work in the constructor.** AIR has not finished setting up the filesystem and
security context while the application class's constructor is running, so a synchronous
`new FileStream()` there does not throw anything catchable — it kills the process with exit
code 1 and **no output at all**, not even the banner. Tasks 11, 14 and 15 therefore do their
file work from a `setTimeout(..., 0)` callback, one event-loop turn later, which works. This
is worth knowing before writing any other AIR program: it is silent, and it looks like a
broken toolchain rather than a runtime ordering rule.

**The bundle is read-only, so task 15 writes somewhere else.** AIR refuses to write anywhere
inside `File.applicationDirectory`; the attempt throws `SecurityError: fileWriteResource`.
Reading the bundle is allowed — that is how task 14 and task 11's worker SWF are read — but
task 15's `out.bin` goes to `File.applicationStorageDirectory` instead, AIR's own writable
per-application data directory, which is
`%APPDATA%\stupidspeed.actionscript\Local Store\out.bin` on Windows. That is a fixed,
documented path rather than the working directory, and it is the one place this row's file
task differs from every other row's. The bytes written and the answer are identical.

**Worker results come back through shared properties, not a `MessageChannel`.** The
documented hand-back — `worker.createMessageChannel(Worker.current)`, pass the channel with
`setSharedProperty`, call `send()` from inside the worker — does not work here: the channel
arrives in the worker intact, but `send()` throws `Error #3738` no matter when it is called,
from the constructor or from a deferred callback. This is a known soft spot in the runtime
rather than a mistake in the program. `setSharedProperty`/`getSharedProperty` is the other
documented channel between workers and it works reliably in both directions, so each worker
publishes its partial under `rN` and the main thread polls for the four. The four ranges are
still computed concurrently on four real AVM2 threads; only the hand-back differs.

**The interpreter heap is small, so task 10 allocates nothing after start-up.** A first
version of task 10 returned a fresh big-integer object from every operation, which meant a
new 16000-limb vector (about 128 KB) per operation for 20000-odd spigot iterations; that
churns hundreds of megabytes and the run dies with `out of memory`. The row instead
allocates its six limb vectors once at full size and writes every result in place, so the
spigot's 20000 iterations allocate nothing. The C row's own big integers are written the same
way, so the two are comparable.

## Fixtures

Task 14 and task 15 use two files with the same 50 MiB shape: 14 reads `data.bin`, 15
writes `out.bin`.

- `data.bin` — 52428800 bytes, the bytes 0 through 255 repeating. 204800 repetitions.
  **Committed at the repository root**, so every language reads the same bytes and no
  generation step is needed. `sha256 624bbe3f61588f97cfaad1af50360bb8c5fc94774d3c15dbf471dcd42b9bea8e`,
  and its byte sum mod 2^32 is task 14's expected `2389704704`.
- `out.bin` — written by task 15, 52428800 bytes. Overwritten on every run, so it needs
  50 MiB of free space and a writable working directory. One row cannot use the working
  directory: ActionScript's AIR runtime refuses to write inside its own application bundle
  and has no working-directory API at all, so its task 15 writes to the runtime's
  per-application data directory, `%APPDATA%\stupidspeed.actionscript\Local Store\out.bin`.
  See the ActionScript notes above.

Put both in a RAM disk when you can. On a real disk, task 14 will be measuring the disk
rather than the language, which is a different and less interesting result.

## Measurement tooling

| Need | Linux | Windows |
|---|---|---|
| Wall clock | your runner, `clock_gettime(CLOCK_MONOTONIC)` | `QueryPerformanceCounter` |
| Peak memory | `/usr/bin/time -v`, or `getrusage(RUSAGE_CHILDREN)` | `GetProcessMemoryInfo`, `PeakWorkingSetSize` |
| Pin to one core | `taskset -c 3` | `start /affinity 8` |

Two things that will corrupt the results if you get them wrong:

- **Send stdout to a file or `/dev/null`, never a terminal.** Writing a line to a console
  can cost more than the entire benchmark. Measured on the development machine: the same
  program took 16 ms to `/dev/null` and 40 ms through a pipe. That is 2.5× of pure noise
  from where the byte went.
- **Run one benchmark at a time.** Two programs on the same core measure contention, and
  task 11 will steal cores from anything running beside it.

## Method

Per cell: one warmup run, then five timed runs, and the median is reported alongside the
minimum, maximum and standard deviation.

Peak process startup on the development machine is around **20 ms** and varies by 10 ms run
to run. That is why the loop counts are in the hundreds of millions: at a million iterations
a trivial loop would be smaller than the noise in starting the process. Task 07 is the one
exception, and its count is small because its loop is quadratic rather than flat.

### The self-timing contract

Every task program times its own work and reports that number, so a cell's cost is separated
from the cost of starting the runtime around it. The contract is fixed, because a row that
brackets a different region is not comparable with the others.

**What is bracketed.** The timer starts at the **entry of `main`** — the first statement the
program's own body executes — and stops **immediately before the final output statement**. So
the measured region contains all of the task's own work, including any setup, allocation and
file I/O, and excludes only the process or VM start-up that happens before the program's first
line runs.

**How it is reported.** One line on **stderr**, in this exact form:

```
TIME_MS=<milliseconds>
```

`<milliseconds>` is a decimal number and may have a fractional part, e.g. `TIME_MS=1234.567`.
Nothing else may be written to stderr. The task's own answer still goes to **stdout** exactly
as before, and the expected-output check is unchanged — it compares stdout only.

**Why stderr.** stdout carries the answer and is compared against the expected value, so a
second line there would break every cell. stderr is not compared, so the timing can travel on
it without disturbing the check.

**Fallback.** A language that cannot write to stderr writes the same line to a file called
`time.txt` in the working directory instead. That is the whole exception; the format and the
bracketed region are identical. The affected rows say so in `BUILD.md`.

**Two consequences worth stating.** First, these numbers are **not** comparable with any
figure recorded before this contract existed, because those included start-up; the harness
still records end-to-end wall clock beside them for exactly that reason. Second, a language
whose clock is coarser than the work it is timing cannot satisfy the contract — its row says
so, and its cells are read with that in mind.

### Rows that cannot report exactly

Four things break the contract in a way a reader has to know about. Each is recorded in the
row's own `timing:` comment as well.

- **Coarse clocks.** `vbscript` (16 ms — `Timer()` counts centiseconds), `cobol`
  (`ACCEPT ... FROM TIME` is `hhmmsscc`, so 10 ms), `modula2` (ISO `SysClock.GetClock`: whole
  seconds plus `SysClock.fractions`) and `modula3` (`Time.Now`: whole seconds as a REAL) cannot
  resolve better than the work they bracket. A cell under 16 ms in the VBScript row is not a
  measurement, and the Modula-2 row is read in whole seconds. `freebasic` reads the same
  seconds-since-midnight value as VBScript but as a Double, and `oberon07` declares
  `GetSystemTimePreciseAsFileTime` from `kernel32.dll` itself, so neither is in this group.
- **No stderr and no file I/O.** `luau` has neither: plain `luau.exe` exposes no standard error
  stream and no file API, so the `time.txt` fallback only lands under `lute run <file>`, where
  Lute's `@lute/fs` supplies the write. Under `luau.exe` the `require` fails, the guarded write
  is skipped and the program still runs — but tasks 01 to 13 produce no timing line at all, so
  the harness has to time those cells end to end.
- **A runtime notice on stderr.** `wasmtime 46` prints
  `WARNING: the -Sthreads flag will be a hard error in Wasmtime 47.0.0 ...` on stderr for every
  threads-using module — task 11 of the eleven WebAssembly rows. It is the runtime talking, not
  the program; the timing line is still the only program output on that stream.
- **A host banner on stderr.** `arc` prints `initializing arc.. (may take a minute)` as the
  first stderr line of every run, before the program's `TIME_MS=` line. It is the Racket host
  booting the Anarki image, not the program, and it is unconditional — about 45–130 s of the
  measured wall time is that boot. A harness reading stderr for `arc` has to take the last
  line rather than the only one, the way it takes the last 2354 bytes of stdout for
  `actionscript`.
- **Absent toolchains.** The J row (`j9.7`), `octave`, `swipl` and `sqlite` are not
  installed on the machine the rows were instrumented on, so their timing code was written by
  inspection and their cells stay unverified until the toolchain is present. The same applies to
  `ring`, `seed7` and `swift`, whose own `timing:` comments say so.
  `ats`, `basic`, `beef`, `cobol`, `dolphin`, `dyalog`, `eiffel`, `babashka`, `boo`, `groovy`,
  `modula2`, `modula3` and `qb64` were absent when the rows were instrumented but have since been
  installed here and verified end to end (15/15 each), so their cells are no longer
  inspection-only. ADW and CM3 both installed portably — an Inno Setup unpack and a prebuilt zip —
  with no admin rights.

## Expected cost

Every task runs six times, in 141 toolchains.

- Fast compiled languages: under a second per run, so about **1.5 hours** for the matrix.
- The 100-million-iteration tasks take 10 to 15 seconds in CPython.
- `powershell` costs about 2.64 us per iteration, so its 100-million-iteration loops take
  around 264 seconds each. Its call-heavy and per-character tasks are far slower: 03 and 09
  are 100 and 331 million interpreted calls, and 06 and 14 walk 100 million items one at a
  time. Task 11 was measured at the full 100000000 iterations and prints the right answer;
  see the section above.
- The new rows are mostly slow, and they hold the slowest cells in the matrix:
  - **Component Pascal** task 10 is a .NET assembly running the same bounds-checked spigot; at
    10000 digits it took about 5 minutes a run, so about **3 s** at 1000.
  - **Racket** task 07 is the quadratic append: Racket strings are
    immutable and `string-append` allocates and copies the whole string every time, so the 250000
    appends copy about 3.1x10^10 bytes. That is the quadratic cost the task is about, and it makes
    this one of the slowest cells in the matrix.
  - **Raku** is slow per operation: `given`/`when` costs about 5.7 us per iteration against
    0.47 us for the equivalent `if`/`elsif` chain, because `when` smartmatches. The row keeps
    `given`/`when` in task 02, since that is Raku's own switch, and takes the ~10 minute run.
    Task 06's per-character `substr` scan is the other slow cell.
  - **Erlang and Elixir** are the reverse: both are fast, and their per-run start-up (about
    520 ms for Erlang, 800 ms for Elixir) is the main fixed cost, charged to every cell.
  - **VBScript** is the slowest row overall. Task 14 is about **46 s** (91 s measured at 100 MiB,
    so about 46 s at 50 MiB, at roughly 1.1 us per byte through the text-mode stream), and task 06
    about 35 s. Task 10
    is the worst cell in the matrix after `a68g`'s. Measured scaling at 100/200/400/800/1600
    digits is 1.19 s, 3.24 s, 10.4 s, 46.1 s and 205.5 s, an exponent of about 2.16 in the digit
    count, which puts the 1000-digit run at roughly **1.4 minutes**. The digit sums at those
    scales are 471, 897, 1753, 3588 and 7269, each matching an independently computed value.
  - **OCaml** task 10 is about **4 s** at 1000 digits (405 s measured at 10000, scaled
    quadratically): the hand-rolled int64 base-1e9 limbs, since the standard library has no
    bignum and `zarith` is not in MSYS2's UCRT64 repository.
  - **ActionScript** task 10 is about **2.8 s** at 1000 digits (268 s measured at 10000, scaled
    quadratically): the same bounds-checked spigot, running on the AVM2 JIT with
    double-precision limbs.
  - **Oberon-07** task 10 is about 10 s at 1000 digits, **Algol 68 Genie** task 02 takes about
    2.5 minutes and its task 11 about the same and its task 14 about
    about 1.75 minutes, and **Cim** task 10 about 3 s.
  - **The newest five rows** are a mix. **Euphoria** is fast (task 01 in 4.3 s, task 09 in
    43 s) and **erlang-compiled** is the fast one (task 01 in 2.7 s — compiling ahead of time
    removes the per-run compile the escript row pays). **OCaml bytecode** sits mid-pack: 5.3 s
    for task 01 and 17.5 s for task 10, against 0.4 s for the same file compiled natively.
    The other two are the slow ones, and they are slow by construction, because each is the
    *interpreted* half of a pair whose other half is fast:
    - **R without its JIT** task 01 takes **362 s** against 82 s with the byte-compiler on
      (3622 ns per iteration against 823) — the 4.4x the row exists to show. Task 06 is
      its worst cell at 651 s and task 09 at 1356 s.
    - **Julia under `--compile=min -O0`** takes **438 s** for task 01, **497 s** for task 02
      and **562 s** for task 09, and its worst cells are task 13 at **942 s** and task 14
      at **954 s**, against about 20 ms and 2 s compiled. Task 11 needs `-t4`; with it the
      cell is 151 s against a 497 s single-thread baseline, a 3.3x speedup.
  - **The six newest rows** are interpreted, so they are slow on the 100-million-iteration
    tasks and fast elsewhere. Measured per task 01: **Jython 55 s**, **babashka 40 s**,
    **QuickJS 24 s**, **DuckDB 20 s**, **QB64 4.3 s**, and **flat assembler** 2.4 s (it is
    compiled, so it sits with the other assembly rows). The two that cost the most are
    Jython and babashka on the call-heavy tasks: task 09 is 331 million interpreted calls and
    measured **105 s** for Jython and **94 s** for babashka, and task 13 measured 103 s and
    106 s. **DuckDB task 07 is 126 s** — the quadratic append is quadratic in SQL too, because
    a recursive CTE rebuilds the string each step. **QB64 builds cost about 6-12 s each** on
    top of the run, since the compiler translates to C++ and shells out to a C++ compiler.
  - **SQLite** task 10 takes about **4 minutes** at 1000 digits (223–256 s over three measured
    runs), which puts it second behind Algol 68 Genie's 7.5 minutes and well ahead of VBScript's
    1.4. That is much better than the limb count suggests, and the reason is worth recording:
    **the cost is dominated by the fixed per-statement overhead, not by the number of limbs.**
    The 200-digit run takes 47 s and the 1000-digit run takes 248 s, so a 5x larger state costs
    only 14% more per step. The row's own primitive is a recursive CTE walk that carries a carry
    column, and each spigot step is a fixed block of about 44 statements over limb tables, with
    the two alternating step programs written out by `writefile()` and replayed by 4500 `.read`
    lines so the two state buffers ping-pong and no state is ever copied. The quotient — the one
    place the algorithm needs a division — is not repeated subtraction but a single pass that
    carries the borrow chains of all nine candidate digits `j = 1..9` at once, and takes the
    count of those whose final borrow is zero.
  - **Algol 68 Genie task 10 is the slowest cell in the matrix.** The interpreter's own
    arbitrary-precision mode is unusable for it (its cost scales with `PR precision=`, which
    would have to be about 30000 here), so the row hand-writes the base-1e9 limbs
    like every other row and hoists the row references out of the loops for another 13-18%.
    Six measured points of the final file, each printing the correct digit sum, every sum
    cross-checked against an independent mpmath computation of pi:

    | digits | 200 | 300 | 400 | 500 | 700 | 1000 |
    |---|---|---|---|---|---|---|
    | seconds | 9.5 | 20.4 | 40.3 | 61.2 | 126.9 | 293 |
    | digit sum | 897 | 1337 | 1753 | 2212 | 3122 | 4470 |

    The cost grows faster than the square of the digit count (exponent about 2.3 over the last
    two points), so those extrapolate to roughly **7.5 minutes** for the 1000-digit run, and the
    cell's warm-up plus five timed runs is about two and a half hours. The cause is not the
    program: the C reference does the identical work in **0.6 s** on this machine, so a68g is
    about 900x slower
    per limb operation because it walks the tree instead of compiling. Its `-O2` (compile units,
    drop runtime checks) is documented as Linux/FreeBSD only and measurably does nothing on
    Cygwin (23.7 s vs 23.3 s on a probe). Every other route was tried and rejected: the
    interpreter's MP mode is slower still, and `LONG LONG BITS` is multi-precision-backed rather
    than a 128-bit word, so it is not a wider byte container. The row keeps the cell, because
    the README's rule is that nothing is cut off for being slow and a partial row is reserved
    for tasks the language genuinely cannot express; the file's header states the extrapolation
    so nobody reads the cell as measured. The alternative, if a four-day cell is judged
    unacceptable, is to `SKIPPED` it with this measurement as the reason — that is a
    documentation change, not a code one.
  - **Janet** task 07 is quadratic by design: Janet
    strings are immutable and `(string acc "x")` allocates a fresh buffer, copies the
    accumulator into it and then allocates the result string, so the 250000 appends copy about
    6.3x10^10 bytes — twice what Racket's one-copy version copies. Every other Janet cell is
    seconds (the slowest are task 09 at 24 s
    and task 13 at 16 s), so this is the row's slowest cell.
  - **Scheme** task 07 is the same quadratic append Racket's is: Chez strings are fixed-length and
    immutable, so the 250000 appends copy about 3.1x10^10 bytes.
  - **Prolog (SWI)** task 07 is quadratic for the same reason: SWI strings are immutable, the
    standard library has no string builder, and
    `string_concat/3` copies the whole string on every append.
  - **Ring** task 07 uses the spec's `text = text + "x"` form and is honestly quadratic: `+`
    appends into a copy of the left operand and the assignment copies the result back. Ring's own
    `+=` appends in place and was deliberately not used.
  - **Octave** is a tree-walking interpreter with no JIT, so its 100-million-iteration cells are
    minutes each: task 01 479 s, 02 666 s, 03 962 s, 05 289 s, 06 490 s, 08 461 s, 09 1408 s
    (fib(40)), 11 213 s, 13 890 s and 14 360 s. One pass of the whole row is about 1.8 hours, so
    six runs per cell is roughly **11 hours**.
  - **Haxe** task 07 is quadratic because a Haxe `String` is immutable and every iteration copies
    the whole thing, which makes it the row's slow cell.
    `StringBuf` was deliberately not used — on cpp it is an `Array<String>` with a join at
    `toString()`, i.e. linear, which would have measured a different program.
  - **AutoHotkey** task 09 is about **4.2 minutes** (249.1 s for ~331 million interpreted calls)
    and task 10 about 1.2 minutes (73.4 s at 1000 digits); its four 100-million-iteration loops
    are 30 to 50 seconds each. Task 07 is *not* slow and that is the point: the expression
    compiler gives `text .= "x"` an in-place path, so the 250000 appends are amortised.
  - The compiled rows (C3, Vala) are in the normal range, with C3's task 07 the outlier
    because appending to a string 250000 times is quadratic by design.
  - **Standard ML** is a fast row with one slow cell, like the other native compilers: every cell
    except task 07 is under a second, and task 07 is the slow one because `^` copies the whole
    string per append. Its start-up floor is 65 ms, and `PolyLib.dll` has to be beside the
    executable or the program prints nothing at all.
  - **Terra** is fast except for task 07, which is the same quadratic copy in Lua strings,
    since the cell copies the whole accumulator on every append and the
    machine is memory-bandwidth-bound, and except for task 11, whose ~1.3 s is almost all
    `includec("windows.h")`, the only C header any task in that row includes. Everything else is
    0.07-0.5 s. The start-up floor is 36-50 ms.
  - **Nelua** is a native row with no VM: every cell is milliseconds except task 07
    (quadratic by design) and task 05 at about 0.5 s. Its start-up floor is 13-17 ms, the same as
    an empty C program compiled by the same gcc.
  - **Dyalog APL** is the slowest of the four by a wide margin, and its cost is spread evenly
    rather than concentrated in one cell: the 100-million-iteration tasks are **59-126 s** each
    (02 is 122.7 s, 09 126.4 s, 11 125.2 s), task 13 is 175.9 s and task 10, the hand-rolled
    1000-digit spigot, is 100.3 s. Its start-up floor is 0.2-0.25 s. Task 07 is *not* slow here,
    because `,←` grows in place.
- Measured slow cells elsewhere: Modula-3 task 10 at 206 s, Modula-2
  task 10 at 115 s.
- **The four C toolchains disagree by 4.2x on task 07**, which is the largest spread inside any
  single row, and it is worth knowing before the matrix is read as a language comparison.
  Measured on this host with the same unmodified source and the machine otherwise idle,
  unoptimised tcc is within 19% of gcc while fully optimised msvc is 4.2x slower. The loop is
  `realloc` plus `strcat` 250000 times, so it is bound by how the C
  runtime grows a heap block and walks the string, not by generated code quality. The locus is
  the CRT rather than the compiler `[INFERENCE]`: the gcc and clang binaries import the UCRT
  (`api-ms-win-crt-*`) and the msvc one links its CRT statically, so the two are calling
  different `realloc` implementations with different in-place-growth policies. Whatever the
  cause, the cell is measuring the toolchain's allocator and string routines as much as it is
  measuring C, and no other row in the matrix has a spread this wide.
- **The six original WebAssembly rows** are the cheapest of the recent additions except for one cell each.
  Task 07 is quadratic in AssemblyScript and in the hand-written row, because the append copies
  the whole string, which puts them in the same range as VBScript's and Racket's. Everything
  else in those two rows is under two seconds, and the other four rows are compiled code whose
  cells are in the normal range. Every one of the six pays the runtime's module load and compile
  on every run, measured at **44 ms** for a no-op module against 30 ms for a native executable
  and 31 ms for `wasmtime-min`.
- **The three interpreted WebAssembly rows are the slow ones in that group**, because a
  language runtime starts inside wasmtime on every cell and the module is large. **Ruby** measured
  11.6-54.8 s on the 100-million-iteration tasks (01 11.6 s, 02 19.7 s, 06 54.8 s, 09 18.9 s, 11 18.6 s),
  11-19 s on the matrix and file tasks, and its task 07 is the honest quadratic append,
  and the row's slow cell. **Lua** is much quicker: 2.5-8.4 s on the loops, 0.4-4.6 s on the rest.
  **CPython** measured 29-36 s on the four 100-million-iteration tasks
  (01 36.6 s, 02 35.7 s, 03 28.9 s, 08 27.0 s), 0.4-10.6 s elsewhere and
  **74.1 s** on task 13, which is its slow cell. `RUN.md` records the measurements.
- **The four newest rows** are cheap except where the task is quadratic. **Cython** costs what
  CPython costs to start — measured, its floor is the same as `python print(1)` on this host,
  90-200 ms — and its loops are **not uniformly faster**, because pure-mode Cython on untyped
  Python objects still does Python arithmetic. Measured against CPython on the same host:
  task 01 6.1-6.3 s against 8.2-8.3 s, task 02 5.8-6.5 s against 7.5-7.6 s and task 03
  4.5-5.2 s against 5.8-6.8 s — about **1.25-1.35x** — task 04, a builtin `sum`, identical at
  0.2-0.3 s, and task 13 *slower* at 17.6-20.0 s against 14.1-17.2 s. Its slow cell is task 07,
  the honest quadratic append. **GraalVM JIT** and **Loom**
  are the `openjdk` row's costs: every short cell is 0.2-0.5 s, and task 07 is the slow one.
  **TinyGo** is a native compiler, so everything is milliseconds except its task 07 — the same
  quadratic append, and its slow cell.
- **Nothing is cut off, so a pass has no upper bound.** The compiled rows are all under a
  second per run, but one of the slow cells above can outweigh the entire rest of the matrix,
  and it runs six times. Budget from the slowest cells, not from the average.

`WRONG` is a result, not a failure. So is `SKIPPED`, which is what a cell reports when the
toolchain is missing or the language cannot do the task at all.

## Platform limits

Some cells cannot be filled on some platforms. This is worth knowing up front rather than
discovering halfway through a run.

| Toolchain | Linux | macOS | Windows |
|---|---|---|---|
| powershell (`powershell`) | no | no | yes |
| powershell (`pwsh`) | yes | yes | yes |
| tcc | yes | yes | yes (native win64 build) |
| clang, clang++ | yes | yes | yes, but needs MinGW headers or the MSVC SDK |
| swift | yes | yes | yes, via the burn-bundle extraction; needs MSVC to link |
| flang | yes | yes | yes, from MSYS2 `ucrt64`; the official LLVM Windows tarball has no `flang.exe` |
| luajit | source | source | source, builds in about 30 seconds with MinGW once `PREFIX` has no spaces |
| graalvm, graalpy | yes | yes | yes |
| jruby | yes | yes | yes, on Java 25 |
| msvc | no | no | yes |
| crystal | yes | yes | yes, official MSVC build; needs the MSVC environment to link |
| objective-c (`clang` + GNUstep) | yes | yes | yes, via MSYS2 `ucrt64` |
| modula-2 (adw) | no | no | yes, freeware, Windows only |
| modula-3 (cm3) | yes | yes | yes, official `AMD64_NT` build; needs MSVC for its C backend |
| cobol (gnucobol) | yes | yes | yes, from MSYS2 `ucrt64` or the SourceForge release |
| basic (freebasic) | yes | no | yes, official win64 build |
| v (vlang) | yes | yes | yes, official `v_windows.zip`; needs a C compiler |
| ats | yes | yes | yes, source build under Cygwin (its own requirements page says "Windows with Cygwin") |
| assembly | no | no | yes (freestanding PE, `nasm -f win64` + `link.exe`; Windows x64 only) |
| masm | no | no | yes (freestanding PE, `ml64.exe` + `link.exe`; Windows x64 only) |
| fasm | no | no | yes (freestanding PE, flat assembler emits it directly with no link step; Windows x64 only) |
| dolphin smalltalk | no | no | yes (Windows-only VM) |
| groovy | yes | yes | yes |
| tcl | yes | yes | yes (task 11 needs a distribution that bundles the `Thread` package) |
| unicon | untested | untested | yes, the 64-bit Windows installer unpacked with `innoextract`; **13.3 only** for task 11, because 13.2 ships without concurrent threads. Verified on Windows x64 only |
| c3 (c3c) | yes | yes | yes, but needs the MSVC SDK to link; `lld-link` has no MinGW mode |
| vala (valac) | yes | yes | yes, via MSYS2 `ucrt64` (about 2.2 GB of GLib dependency chain) |
| algol 68 (a68g) | yes | yes | yes, but task 11 needs a **Cygwin** source build with `--enable-parallel`; the prebuilt win64 binary has no parallel clause and `mingw32` is treated as an untested host |
| component pascal (gpcp) | no | no | yes, .NET only, so it needs the .NET runtime wherever it runs |
| oberon-07 (akron) | yes | no | yes, the repository ships a Windows `Compiler.exe`; on Linux the compiler has to be built from source with `make lin64` |
| vbscript (cscript) | no | no | yes, and only ever Windows: it is a Windows Script Host component with no port. It is also being **withdrawn by Microsoft** — a Feature on Demand in Windows 11 24H2, enabled by default at first, then disabled by default, then removed — so this row will eventually become `SKIPPED` on new installs. |
| actionscript (AIR) | no | yes | yes. The SDK's captive runtime — what `-target cmdline` bundles into a standalone app — ships for `win`, `win64` and `mac` only (`runtimes/air-captive/`), so a self-contained bundle is possible on Windows and macOS and **not** on Linux, which gets only the non-captive runtime. Verified on Windows; the macOS path is untested here. |
| scala (native) | untested | untested | yes, via the portable llvm-mingw zip (no MSVC, no admin); the documented route wants Visual Studio's C++ workload |
| beef | untested | untested | yes, Windows x64 only as verified here; Beef's Linux and macOS back ends were not exercised, and its installer is Windows-specific |
| haxe (hxcpp) | untested | untested | yes, the official win64 zip plus a 64-bit MinGW `g++`, verified on Windows only |
| eiffel (eiffelstudio) | untested | untested | yes, the win64 `.7z` unpacked in place; the delivery ships its own MinGW gcc, so no MSVC is needed. Verified on Windows only |
| seed7 (s7c) | untested | untested | yes, built from the source release with MSYS2's MSVCRT MinGW gcc; the only prebuilt Windows artifact is an admin-requiring installer. Verified on Windows only |
| scheme (chez) | untested | untested | yes, built from the release tarball with MSYS2 UCRT64 MinGW gcc; `make install` has to be done by hand. Verified on Windows only |
| prolog (swipl) | untested | untested | yes, the official x64-win64 NSIS installer extracted with 7-Zip; the tree is self-locating. Verified on Windows only |
| octave (octave-cli) | untested | untested | yes, the official MXE w64 `.7z` (or the user-scope winget package). Verified on Windows only |
| j (jconsole) | untested | untested | yes, the Windows x64 base zip; `j.dll` needs the VC++ x64 runtime. Verified on Windows x64 only |
| janet | untested | untested | yes, the per-user Windows x64 MSI. Verified on Windows only |
| ring | untested | untested | yes (the light release is a no-admin ZIP); its macOS and Linux support was not exercised |
| jscript (cscript) | no | no | yes, and only ever Windows: it is the same Windows Script Host component as the VBScript row and shares its deprecation path. On Windows 11 24H2 and later the engine is the replacement JScript9Legacy, which reports 11.0.16384 on this host. |
| autohotkey (v2) | no | no | yes, and only ever Windows: the official project builds Win32 and x64 Windows targets and nothing else. |
| standard ml (poly/ml) | untested | untested | yes, the `PolyML5.9.1-64bit.msi` administratively extracted, plus a MinGW `gcc` to link the exported object and build the two missing pieces the MSI omits. Verified on Windows x64 only. The MSI is the only Windows asset and v5.9.2 ships none, so the version is pinned at 5.9.1 there |
| terra | untested | untested | yes, the official `terra-Windows-x86_64-*.7z`; no admin and no MSVC, but the interpreter **requires a non-nil `VCINSTALLDIR`** or it aborts before running any file, and `INCLUDE` must point at a C sysroot for the one task that includes `windows.h`. Verified on Windows x64 only |
| dyalog | untested | untested | yes, the 20.0 Unicode Windows distribution administratively extracted. Runs unregistered with nothing on stdout. Verified on Windows x64 only; the download page's other platforms get `.deb`/`.rpm` and a macOS `.pkg`, none of which were exercised here |
| nelua | untested | untested | yes, the git repository plus a C compiler and its own bundled Lua interpreter. No admin. Verified on Windows x64 only |
| go (tinygo) | yes | yes | yes, the official `tinygo0.42.0.windows-amd64.zip` (the release also ships Linux and macOS builds of the same layout). Verified on Windows x64 only, but nothing in it is Windows-specific: it needs no MSVC and emits a standalone executable. Its task 15 flush-and-close deviation is a Windows-target property — TinyGo implements `os.File.Sync` on linux, darwin and wasip1 and stubs it on Windows |
| python (cython) | yes | yes | yes, and the build flags are **not** portable: the row's `-DMS_WIN64` and `-municode` are MinGW-on-Windows requirements, and on Linux or macOS the same two steps are plain `cython --embed` plus a `gcc` that links the interpreter. Verified on Windows x64 only |
| java (graalvm jit) | yes | yes | yes, the same GraalVM tarball on all three |
| java (openj9) | yes | yes | yes, the Semeru zip ships Linux, macOS and Windows builds of the same layout. Verified on Windows x64 only |
| java (loom) | yes | yes | yes, any JDK 21 or newer on any platform; nothing Windows-specific |
| c/c++/rust/go/assemblyscript/webassembly/ruby/lua/python/zig/tinygo (`wasmtime 46.0.3`) | yes, all eleven | yes, all eleven | yes, all eleven. The runtime is a portable release zip; the only Windows-specific piece is the wasi-sdk tarball for the C and C++ rows, which ships `x86_64-windows` and `x86_64-linux` builds of the same thing. Task 11 is the version-sensitive cell on every platform: `wasi-threads` was deleted in wasmtime 47, so **46.0.3 or older is required** and the row cannot be run on a current runtime. Verified on Windows x64 only |

**Windows reaches every row**; it is the only host that does. Linux loses `actionscript`
(no captive runtime), `dolphin smalltalk` (Windows-only VM), `vbscript` and `jscript`
(Windows Script Host components, and ones Microsoft is removing), `autohotkey` (the
official project builds only Windows targets) and both `assembly` rows (freestanding PE
programs built against `kernel32.dll`). Linux also
loses Tcl's task 11 unless the distribution bundles the `Thread` package. macOS loses
both `assembly` rows, `msvc` and `dolphin smalltalk`, which exists nowhere else, plus the Windows
PowerShell 5.1 row (use `pwsh` there), the Windows-only scripting rows (`vbscript`, `jscript`
and `autohotkey`), and the two rows whose toolchain ships Windows-only
binaries: `oberon-07` (build the compiler with `make lin64` instead) and `component pascal`,
which is .NET-only by construction and has no non-Windows release. The twenty-two newest rows were
all verified on Windows x64; where a material file did not exercise Linux or macOS, the table
says `untested` rather than guessing. Whichever host you pick,
run the whole matrix on it, because numbers are only comparable within a run.

### Cygwin-hosted toolchains: native or cross-compiled

Some toolchains only exist under Cygwin (ATS's own
requirements page says "Windows with Cygwin"; Cim and the parallel-capable a68g are built
there too). Those have a choice of C backend, and the choice is worth recording per row
because it changes the number:

| Backend | Produces | Startup cost |
|---|---|---|
| Cygwin `gcc` | a PE that loads `cygwin1.dll` | measured **7.54 ms** for hello-world |
| `x86_64-w64-mingw32-gcc` | a standalone Windows binary, no Cygwin dependency | measured **5.84 ms** for hello-world |

Both ship in the Cygwin `gcc-core` and `mingw64-x86_64-gcc-core` packages. The gap is about
1.7 ms of pure `cygwin1.dll` initialisation, and it is systematic rather than noise, so it
shifts every cell in a Cygwin-native row. It matters most for the short tasks: 1.7 ms against
a compiled row's sub-millisecond loop time is a large relative effect. A row that wants to be
comparable with `gcc` and `clang` should use the mingw cross compiler.

One caveat when cross-compiling: the binary is standalone, so the *runtime* is not Cygwin's,
but the *build* still is. Anything the program reads from the filesystem at run time sees
native Windows paths, not `/cygdrive/...`.
