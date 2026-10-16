# Run requirements

What has to be installed to execute the built programs, and what the machine has to look
like for the numbers to mean anything. For compilers, see `BUILD.md`.

## Host

| | Requirement | Why |
|---|---|---|
| OS | x86-64, Linux, macOS or Windows | Every row is reachable on Windows and on Linux; macOS loses `msvc` and `dolphin smalltalk`. The `assembly` and `masm` rows are Windows x64 only, because both are freestanding PE programs built against `kernel32.dll`. `tcc`, `clang`, `flang` and `luajit` all need a little care on Windows but no WSL. |
| CPU | 4 physical cores | Task 11 runs four threads. Every other task is pinned to one core, so more cores do not help them. |
| RAM | 8 GB minimum, 16 GB comfortable | The tasks themselves are small: the largest allocation is task 06's 100 MB text, and task 12's three 1000x1000 arrays are 24 MB together. The 16 GB is for the JVM, GraalVM and Julia toolchains. `native-image` alone wants 2–4 GB to build. |
| Disk | ~43 GB free | 100 MiB of fixtures, the toolchains themselves, and 2-3 GB of scratch while reassembling MSVC and Swift. `BUILD.md` measures the toolchains at about **42 GB for all 210 toolchain entries**, and that figure is the authority — it is maintained in one place there rather than as a running total here, which had drifted. The heavy terms are LLVM (4.0 GB), Swift (3.2 GB), the AIR SDK (1.6 GB), GNAT with its MSYS2 runtime (1.8 GB), MSVC (1.2 GB once reassembled from a 2.5 GB layout), Julia (1.1 GB), Perl (1.0 GB), the .NET SDK (0.7 GB), GraalVM (0.7 GB) and GHC's bindist (4.1 GB); most other rows are 0.1-0.6 GB. Package caches do not count and can be far larger than the toolchains themselves. |
| Filesystem | `tmpfs` or RAM disk preferred for the file tasks | Reading 50 MiB from a spinning disk measures the disk. Anything run under WSL2 measures the WSL disk layer instead. Where the fixture lives must be recorded in the results. |

## Runtimes

Languages compiled to a static native binary need nothing. The rest need the following.

The table is per **front end** — what has to be installed for that row's own compiler. Several
front ends share one runtime, which is the point of the backend axis in `README.md` and
`BUILD.md`: `ada`, `fortran`, `c`, `c++`, `cobol`, `vala` and the other GCC rows all execute
native code with nothing installed, and `java`, `kotlin`, `scala`, `clojure` all
need the same JVM. A row that needs a runtime is really saying its **backend** does.

| Language | Toolchain | Runtime needed | Notes |
|---|---|---|---|
| C | gcc, clang, msvc, tcc | glibc + libpthread, MSVC runtime | MSVC build needs the UCRT |
| C | icx (oneAPI) | none | a native binary like the other C rows. The build needs the MSVC environment (`INCLUDE`, `LIB`) because `icx` links with `link.exe`; the run needs nothing. |
| C | compcert | **`tools/cygwin/bin` on `PATH` — the programs import `cygwin1.dll`** | `ccomp.exe -O2 -o prog.exe <task>.c`. **This is one of only two rows in the matrix whose output needs Cygwin at run time** (the other is `ats`). Proven rather than assumed: with `PATH` stripped to `C:\Windows\System32;C:\Windows` the exe exits `0xC0000135` (`STATUS_DLL_NOT_FOUND`) and prints nothing; with the Cygwin `bin` directory on `PATH` it prints its answer and its `TIME_MS`. The registry entry sets that `PATH` for every cell, exactly as the `ats` entry does. There is no Cygwin-free route: `x86_64-cygwin` is CompCert's only Windows target, and linking its objects with MinGW fails with `undefined reference to '__getreent'` on all fifteen tasks, because CompCert preprocesses against Cygwin's headers and the objects therefore carry Cygwin-libc references. The sources take the POSIX timer branch (`clock_gettime`), which Cygwin's libc supplies. |
| C++ | g++, clang++ | libstdc++ or libc++ | |
| C++ | msvc | MSVC runtime | |
| C++ | zig c++ | none | static by default, like the `c` row's `zig cc`: Zig's libc and compiler-rt are linked in, with no MinGW or MSVC behind it. Built by `exec/cpp/build_zigcpp.bat`. |
| Rust | rustc | none | links libstdc statically by default |
| Rust | rustc (cranelift) | none | a native Windows binary like the default `rustc` row; it links the UCRT (`ucrtbase.dll`, shipped with Windows), so nothing has to be installed. Only the build needs the MSVC environment |
| Zig | zig | none | static by default |
| Go | gc | none | static without cgo |
| Go | tinygo | none | standalone executable; TinyGo's own runtime and LLVM are linked in, so nothing from `tools/tinygo` is needed at run time. Its Windows target has no fsync, so task 15 flushes by closing — the one file where its sources differ from the `gc` half of the row. |
| D | dmd, ldc2 | libphobos | or build with `-static` |
| Swift | swiftc | Swift runtime libraries | unless statically linked |
| Fortran | gfortran | libgfortran | |
| Fortran | flang | Fortran runtime | |
| Fortran | ifx | `tools/ifx/Library/bin` on `PATH` for task 11 only | Fourteen of the fifteen executables are standalone: ifx links the Fortran runtime statically, and verified, task 01 runs with a bare system `PATH`. Task 11 is the exception — OpenMP is linked dynamically, so its exe needs `libiomp5md.dll`, which sits beside `ifx.exe` and nowhere else; without that directory on `PATH` it dies at load with `0xC0000135` and prints nothing. The row's registry entry sets the `PATH` for every cell. |
| Fortran | lfortran | `tools/msys64/msys64/ucrt64/bin` on `PATH` (`liblfortran_runtime.dll` lives there) | `exec/fortran/build_lfortran.bat` links the clock shim ahead of the runtime, so the exe needs that directory on `PATH` at run time as well as at build time; the registry entry sets it for every cell. **The runtime also needs `tools/lfortran-shim/patch_runtime.py` applied**: LFortran opens every unit file without the `b` flag, so on Windows they are text streams — task 14's read stops at the `0x1A` in `data.bin` and task 15 writes 204800 bytes too many. Two bytes fix both; BUILD.md has the measurements. |
| Ada | gnat | libgnat | |
| Ada | gnat llvm | libgnat, built for LLVM | the LLVM port links the same Ada runtime, compiled ahead of time; its fifteen cells are registered and unmeasured until the compiler is built (BUILD.md). |
| Pascal | fpc | none | static by default |
| Nim | nim | none | static by default |
| Nim | nim | none | static by default |
| Nim | nim (clang) | none | a native Windows binary like the other two Nim front ends; it links the UCRT, so nothing has to be installed. Only the build needs the MSVC environment, because `--cc:clang` drives `tools/llvm/bin/clang.exe`, which has no headers of its own. |
| Odin | odin | none | |
| Assembly | x86-64 nasm | none | freestanding PE, `kernel32.dll` only |
| Assembly | x86-64 masm | none | freestanding PE, `kernel32.dll` only |
| Assembly | x86-64 fasm | none | freestanding PE, `kernel32.dll` only |
| Dolphin Smalltalk | Dolphin 8 | MSVC x86 runtime (`vcruntime140.dll` + `msvcp140.dll`) | the VM is 32-bit, so it needs the x86 runtime, not the x64 one |
| Tcl | tclsh | none | task 11 also needs the `Thread` extension; MSYS2's `mingw-w64-ucrt-x86_64-tcl` bundles it (`ucrt64/lib/thread2.8.13/`), see `BUILD.md` |
| Java | openjdk | JRE 17 or newer | the default: tiered compilation, C1 then C2 |
| Java | openjdk (interp) | the same JRE | `-Xint`: the template interpreter, no JIT. About 11x slower than the default on task 01 (818.9 ms against 71.9 ms) |
| Java | openjdk (c1) | the same JRE | `-XX:TieredStopAtLevel=1`: C1 only, the C2 tier never runs |
| Java | openjdk (c2) | the same JRE | `-XX:-TieredCompilation`: C2 only, no C1 profiling tier |
| Java | openj9 | the Semeru JDK's own JRE (`tools/openj9/`) | Eclipse OpenJ9 21; the same class files as `openjdk`, no JVM flags, and `java.lang.Thread` maps to OS threads so task 11 is a real four-thread pass |
| Java | graalvm jit | the GraalVM JDK itself, 21 or newer | no JVM flags needed: GraalVM's `java` has `UseJVMCICompiler` on by default, so it compiles the bytecode with the Graal compiler instead of HotSpot's C2 |
| Java | graalvm native-image | none | standalone binary |
| Kotlin | jvm | JRE + kotlin-stdlib | |
| Kotlin | native | none | |
| C# | coreclr | .NET 8 runtime | |
| C# | nativeaot | none | |
| C# | mono | Mono runtime | |
| C# | mono (aot) | Mono runtime, JIT off (`--full-aot`) | the same 15 assemblies as the `mono` row, compiled by the same `mcs`; the run loads `<task>.exe.dll` instead of JITting `<task>.exe`. Aot-only mode has no fallback: if a method the program calls is missing from the module, the run aborts instead of compiling it |
| F# | dotnet | .NET 8 runtime | |
| VB.NET | dotnet | .NET 8 runtime | same SDK and runtime as C# and F# |
| Scala | jvm | JRE + scala library | |
| Dart | aot | none | |
| Dart | jit | Dart VM | |
| JavaScript | bun, deno | the runtime itself | `bun <task>.js` needs nothing; the sources are CommonJS, which Deno 2 only accepts with **`--unstable-detect-cjs`**. Deno also denies the filesystem by default, so task 11 (its `worker_threads` re-read the script file) and task 14 need `--allow-read` and task 15 needs `--allow-write`; without them it stops with `Requires read access to …`. |
| JavaScript | spidermonkey | the shell binary is the whole runtime | `js.exe <task>.js`. Real OS threads via `evalInWorker`, which runs its argument on a separate thread; cross-thread data needs a `SharedArrayBuffer` that the main thread has registered with `setSharedArrayBuffer()` first, with `Atomics` for the join — without that registration the worker's `getSharedArrayBuffer()` throws `RangeError`. Task 10 is a built-in-bignum cell: BigInt is native. `os.file.readFile(name, "binary")` gives the bytes as an ArrayBuffer, and `os.file` has no chunked read or append, so tasks 14 and 15 read and write the whole 50 MiB in one call. |
| JavaScript | quickjs | none | the binary is the whole runtime. Needs `--std` for the `std`/`os` modules, which is also what gives stderr. No threads. |
| JavaScript | quickjs | none | the binary is the whole runtime. Needs `--std` for the `std`/`os` modules, which is also what gives stderr. No threads. |
| JavaScript | hermes | the MSVC runtime (`MSVCP140.dll`, `VCRUNTIME140.dll`, `VCRUNTIME140_1.dll`) plus `icuuc.dll`/`icuin.dll` from `System32` on Windows 10 1703+ | `tools/hermes/hermes.exe <task>.js` through `exec/javascript/hermes/run.bat`, which is what puts `TIME_MS=` on stderr — **Hermes has no stderr primitive and no filesystem API at all**, so the task's own `print()` output is the only stream and the wrapper re-splits it. No module system either: `typeof require === 'undefined'`, so tasks 11, 14 and 15 have no route and are not in this toolchain. No JIT, no threads, no `performance`/`console` — the shared sources are wrapped by `exec/javascript/hermes_prelude.js`. |
| Pike | pike | none — the MSI's own DLLs sit in `tools/pike/bin` and the exe finds them there | `pike <task>.pike`. **Two numeric facts about this build that the row's cells depend on.** Its `float` is IEEE **binary32**, so task 08's accumulator would saturate at 2^24 and print `0.167772159`; the cell uses `Gmp.mpf` at 128-bit precision instead, which is the same choice the `hashlink` row makes when its `Int` is 32-bit, and prints the exact `0.498046875` through an integer render (`×10^9` is exact) rather than through `sprintf`, which would go through GMP's own notation. Its `int` is 4 bytes, so tasks 02, 11 and 13 promote to `Gmp.mpz` partway through and every subsequent add in the loop is a bignum operation — which is why those three cells take tens of seconds. **Task 11 is a correct-answer-no-speedup cell**: `Thread.Thread` is a real OS thread, but Pike holds a global interpreter lock over bytecode execution (`pike_low_lock_interpreter`), so the four loops run one after another — measured 3040.9 ms on one thread against 11906.9 ms on four, i.e. 0.26x. Task 08 is the row's slowest cell at ~250-300 s, which is why its registry entry carries `"timeouts": {"08_average": 1800}`. |
| PHP | zend | PHP + opcache | task 11 needs the `parallel` PECL extension, which stock PHP does not ship and which requires a ZTS build. **`-d memory_limit=4096M` is required**: PHP defaults to a 128 MB heap, and task 06 now builds a 250 MB string and task 12 holds about 768 MB of arrays, so both die with an out-of-memory fatal without it. |
| PHP | zend + jit | PHP + opcache | JIT needs `opcache.enable_cli=1` **and** `-d opcache.jit=tracing`: PHP 8.5 changed the master default of `opcache.jit` to `disable`, so `opcache.jit_buffer_size` alone leaves it off. Same ZTS + `parallel` requirement as the row above for task 11, and the same `-d memory_limit=4096M`. |
| Python | cpython, pypy, graalpy | the interpreter | |
| Python | cython | the interpreter's `python3xx.dll` | the built `.exe` is **not** standalone: it imports the CPython DLL, so the matching CPython installation has to be beside it or on `PATH`. That DLL is the interpreter the program embeds, not a runtime for the compiled code — the loops are native. |
| Python | nuitka | none | standalone binary |
| Ruby | cruby-yjit | the interpreter | No build step: `tools/ruby/bin/ruby.exe --yjit <task>.rb`. **YJIT cannot be enabled on Windows** — its mingw build needs `sys/mman.h`, which mingw does not provide — so the flag is inert on the stock build, which warns `Ruby was built without YJIT support`; that warning is recorded in the row's own sources and the not-here table in `README.md` explains why. The cell therefore measures CRuby, not a JIT. |
| Lua | puc-lua, luajit | the interpreter | No build step: `tools/lua/lua54.exe <task>.lua`, run from `exec/lua/`. **The binary is `lua54.exe`, not `lua.exe`** — there is no `bin\` subdirectory and no unversioned name in the Windows distribution this row uses. Task 11 also needs the Lanes extension, see below. A Windows Lua distribution that ships `luarocks.exe` (the 5.4.6 build used here) installs it with one command, `luarocks install lanes`, given a MinGW `gcc` on `PATH`; the rock lands outside the interpreter tree, so `LUA_PATH`/`LUA_CPATH` must point at it or `require("lanes")` fails with `module 'lanes' not found`. **Both interpreters' Lanes are built by `exec/lua/build_lanes.bat` into `tools/lua-rocks/`**, because LuaLanes publishes no prebuilt Windows binaries at all: the rock tree holds a `lanes.dll` per ABI (`lib/lua/5.4/` for puc-lua, `lib/lua/5.1/` for luajit) built from the LuaLanes source against that interpreter's headers, plus `lanes.lua` in the matching `share/lua/<ver>/`. The two are not interchangeable -- lanes refuses across ABIs in both directions, and a DLL built against PUC 5.1 headers dies under LuaJIT with *"Lanes is built for PUC-Lua, don't run from LuaJIT"*, which is why the LuaJIT flavour is compiled against LuaJIT's own headers with `LUA_JITLIBNAME` defined. The verifier searches that tree first, then `%APPDATA%\luarocks` (where a plain `luarocks install` lands), and `LUA_ROCKS` overrides both. When no tree has Lanes the verifier reports task 11 as the only skipped cell instead of failing with a nil-index error from inside the task. |
| Luau | luau | the interpreter, and Lute for tasks 11, 14 and 15 | one toolchain, two engines: the plain Luau CLI has no file I/O and no process API at all — no `io`, no `os.execute`, no `package` — so those three tasks need Lute, the Luau team's own runtime. Which engine ran a cell is on the cell, not in the toolchain name. |
| Pony | ponyc | none | a static binary. **0.65.0 specifically**: 0.66.0 raised the Windows floor to 11 / Server 2022, see `BUILD.md`. |
| Lean 4 | lean | none | the compiled binary is standalone; the `leanc` linker driver links against the toolchain's own tree at build time only. |
| Common Lisp | ecl | none | the `.fas` is loaded by `ecl.exe` itself, so the interpreter tree is the runtime. |
| Boo | booc | .NET 10 runtime | the emitted assembly needs `Boo.Lang.dll` and a `prog.runtimeconfig.json` beside it, or it fails before `Main`. |
| Pharo | Pharo 13 | the image | `--quit --no-source` keeps the run from saving the image or compiling the script into it. |
| Factor | factor | none — the distribution carries its own image | `factor.exe <task>.factor` from `sources/factor/`. |
| Unicon | unicon | none — the produced `.exe` is self-contained (the runtime is appended to the icode, so nothing from `tools/unicon` is needed at run time; verified with a clean `PATH`) | `tools/unicon/bin` must be on `PATH` to compile. The build is `unicon -s <task>.icn`, which writes `<task>.exe`; task 03 also names `03_func_sum_add_one.icn` on the same line. Both the compiler and the executables it produces read their own appended image through `argv[0]`, so invoke them with a **Windows-style backslash path** — `C:\…\prog.exe` runs, `C:/…/prog.exe` dies with `can't read interpreter file header`. Tasks 14 and 15 open their files in **untranslated** mode (`"u"` / `"wu"`): the default buffered mode is a text stream that stops at the `0x1A` at offset 26 of `data.bin` and reads 26 bytes instead of 50 MiB. **Unicon 13.3 is required for task 11**; 13.2 is built without concurrent threads. |
| Haskell | ghc | none — the RTS is linked into the executable | `ghc -O2 -threaded -o prog <task>.hs`, then `prog`. Task 11 is run as `prog +RTS -N4 -RTS`, which gives the runtime four capabilities; the other tasks need no RTS flag. Task 07 appends to a `ByteString`, not a `String` — a `String` is a linked list of characters and 250000 quadratic appends to one does not finish in any useful time, where `ByteString` does the same whole-accumulator copy at memcpy speed. Task 15 flushes and closes: Haskell's standard library exposes no fsync, so this row is in the flush-and-close group. |
| Lobster | lobster | none — the interpreter is the whole toolchain | No build step: `tools/lobster/bin/lobster.exe <task>.lobster`, run from `sources/lobster/` so that `data.bin`/`out.bin` resolve. Task 03 has no no-inline annotation, so `add_one` is passed as a `fn` value through a parameter with an explicit function type, which forces an indirect call rather than an inlined one. Task 07 appends in place because Lobster's `+=` grows a uniquely-referenced string, so the cell is linear rather than quadratic — the deviation the Erlang and Elixir rows already record. Task 11 uses Lobster's own worker threads. |
| Forth | gforth | none — the interpreter tree is the runtime | No build step: `gforth <task>.fs`. Needs `GFORTHPATH=<gforth dir>;.` so that the image `gforth.fi` and the working directory's `data.bin` are both findable. Task 14 reads the fixture in binary and prints the byte sum mod 2^32, as the C row does. Task 15 flushes and closes: gforth has no fsync, so this row is in the flush-and-close group. Task 11 cannot use threads on Windows — `cilk.fs` requires `unix/pthread.fs`, which is Unix-only — so the four workers are four child processes started with `start /b`, each writing its partial to a temp file that the parent polls for and sums; measured, four workers take about the same wall time as one where running them in sequence would take four times as long. Note for anyone editing this row: `exit` inside a `DO`/`LOOP` does not unwind the loop frame in this gforth build, so early returns need `unloop exit`. |
| Mercury | mmc | none — the compiled executable is standalone | `mercury_compile --make <module> --grade hlc.gc.pregen` (with `tools/mercury/bin` on `PATH` and `MERCURY_STDLIB_DIR` set) produces `<module>.exe`, named after the module rather than the file, and the measured run is that executable. Task 10 uses Mercury's own `integer` module, which is arbitrary precision, so it is a built-in-bignum cell. **Task 11 needs a different grade**: the default `hlc.gc.pregen` has no parallelism, so that one cell is compiled `hlc.par.gc`, Mercury's own parallel grade, with `thread.spawn` workers and `thread.mvar` for the join. |
| Perl | perl | Perl | |
| R | gnu-r | R | task 11 uses the bundled `parallel` package, PSOCK mode |
| Julia | julia | Julia | about 1 GB with the standard library. Task 11 must run as `julia -t4 <task>.jl`, or `Threads.@threads` stays on one thread. |
| GDScript | godot --headless | Godot binary | roughly a second of startup on its own |
| Crystal | crystal | none | static by default; needs the MSVC toolchain to link |
| Objective-C | clang | `libobjc-4.6.dll` + `gnustep-base-1_31.dll` + UCRT | the GNUstep runtime ships with the MSYS2 `ucrt64` packages |
| Modula-2 | adw | none | static by default; the `time.txt` fallback carries `TIME_MS`, because ADW exposes no stderr handle. The clock is ISO `SysClock.GetClock` — local time of day, whole seconds plus `SysClock.fractions` — so a cell under a second is read in whole seconds. |
| Modula-3 | cm3 | **three DLLs must sit beside the exe** — `m3.dll`, `m3core.dll`, and `arithmetic.dll` for task 10 | the produced `AMD64_NT\prog.exe` imports the cm3 runtime, so without them it exits `53` (`STATUS_DLL_NOT_FOUND`) before `main` with no diagnostic. `time.txt` carries `TIME_MS`, because Modula-3's `IO` has no stderr stream; the clock is `Time.Now` (seconds since the epoch as a `REAL`). |
| COBOL | gnucobol | `libcob-4.dll` + UCRT | from MSYS2 `ucrt64` |
| BASIC | freebasic | none | static by default |
| BASIC | qb64 | none — the built .exe is static | QB64-PE compiles through C++, so each build takes a few seconds. `PRINT` pads numbers; the rows use `LTRIM$(STR$(x))`. No threads. |
| V | v | none | static by default; needs a C compiler to build |
| ATS | ats (gcc) | none | static by default; needs a C compiler to build |
| C3 | c3c | none | static by default; needs the MSVC SDK to link |
| Vala | valac | `libglib-2.0-0.dll` (and `libgobject-2.0-0.dll` for task 10) for the tasks that call GLib | from MSYS2 `ucrt64`; the tasks that call no GLib function link nothing extra and run with a bare system `PATH`. Static linking fails, so the DLLs have to be reachable. |
| Oberon-07 | akron | none | static by default; the compiler's `Compiler.exe` is a standalone Windows binary |
| Component Pascal | gpcp | .NET 8 runtime | the compiler produces a .NET assembly, not a native binary, and every executable needs `RTS.dll` beside it — plus `RealStr.dll` for task 08 and `GPFiles.dll` + `GPBinFiles.dll` for tasks 14 and 15. Those DLLs are **not** found on `PATH`. |
| ActionScript | AIR | none — the runtime is bundled | `adt -target cmdline` puts a captive AIR runtime beside the executable, so the bundle is self-contained and needs no separate install. The bundle is a directory, not a single file: `prog.exe`, `prog.swf`, `Adobe AIR\`, `META-INF\` and `mimetype` all have to stay together. Two things about it are unusual and are covered below: it prints a startup banner, and it has no working-directory API. |
| Clojure | clojure.main | a JRE (17 or newer; Clojure supports 8 through 25) plus the three runtime jars | No build step and no installer. The three jars are the whole toolchain; `clojure.main` compiles the source as it runs. Set `JAVA_HOME` per row rather than relying on whatever `java` is first on `PATH`. |
| Clojure | babashka | none | a GraalVM native binary with no JVM. Single-threaded (`future` serialises), so task 11 is four child processes. |
| Clojure | cljs.main | `node 22`, plus the ClojureScript jar at build time | No JVM at run time. The build is `java -cp tools/clojurescript/cljs.jar clojure.main -m cljs.main ...`, which emits one `prog.js`; the row then runs `node prog.js`. The jar is the official 31 MB release — the 5 MB Maven artifact has no Closure compiler. |
| Racket | racket (CS) | none — the installation tree is the runtime | Relocatable, but it has to move as a unit: the DLL and `collects` paths are embedded in the executables relative to the executable's own location. `Racket.exe` is the console program; task 11 uses `racket/place`, which is in `base` and therefore present even in Minimal Racket. |
| OCaml | ocamlopt | none — native static binary | The MSYS2 UCRT64 build needs the UCRT64 DLLs on `PATH` at run time, and building needs `OCAMLLIB` set to the Windows form of the stdlib path plus the `flexdll` package; see `BUILD.md`. |
| OCaml | ocamlc (bytecode) | the MSYS2 UCRT64 OCaml runtime (`ocamlrun.exe` and `dllunixbyt.dll` must be reachable) | `ocamlc -I +unix unix.cma -o prog.exe _<task>.ml` then `./prog.exe`, both inside the MSYS2 shell. Same fifteen files as the native row. |
| Elixir | elixir (BEAM) | Erlang's tree plus Elixir's | No build step. Elixir needs Erlang on `PATH` first; `elixir` then compiles the script each run. The 179 MB OTP tree is installed for this row alone now that the two Erlang rows are gone. |
| Erlang | OTP (escript) | the extracted OTP tree | No build step. `escript` compiles the script on each run. Run with `-smp enable` so all schedulers are live. |
| Erlang | erlc (compiled) | the same extracted OTP tree | Two steps: `erlc <task>.erl` writes `<task>.beam`, then `erl -noshell -s <task> main -s init stop`. Module form, so the per-run compile the escript row pays is gone. Task 11 is a real four-worker parallel pass. |
| Gleam | gleam | Erlang/OTP | the generated `.beam` runs on the same OTP tree the `erlang` and `elixir` rows install, so this row adds no runtime. |
| VBScript | cscript | none — `cscript.exe` ships with Windows | The runtime is a Windows component rather than something you install, which is also why the row is on borrowed time: see the platform table below. |
| Common Lisp | sbcl | none — the dumped executable embeds the core | The build dumps a standalone `prog.exe` with `save-lisp-and-die`, so nothing has to be on `PATH` at run time. Task 11 uses `sb-thread`, which is a required part of the Windows build. |
| C, C++, Rust, Go, AssemblyScript, WebAssembly, Lua, Zig (the nine wasm rows that run on 46) | wasmtime 46.0.3 | the `wasmtime.exe` from the release zip under `tools/wasmtime46/` | `wasmtime run prog.wasm`. Tasks 14 and 15 add `--dir=.` from a directory holding `data.bin`; Go's two cells need `--dir=<host>::/` instead, because Go opens its preopens by the WASI name and expects `/`. Task 11 adds `-S threads=y -W threads=y -W shared-memory=y` and **needs 46**, because `wasi-threads` was deleted in 47. Startup is part of every cell: measured, a no-op module costs 44 ms against 30 ms for a native executable and 31 ms for `wasmtime-min`. |
| Lua (`wasmtime 46.0.3` or newer) | 5.4.8 | `lua.wasm`, built once with the wasi-sdk tree (see `BUILD.md`) | `wasmtime -W exceptions=y --dir . lua.wasm <task>.lua`. The `-W exceptions=y` is mandatory: Lua's `pcall`/`error` path lowers onto the exception-handling proposal, and wasmtime's `exceptions` feature is off by default, so without it the module fails to compile with `legacy_exceptions feature required for try instruction`. `--dir .` is needed on **every** cell, not just 14 and 15, because the script itself is read through the preopen. |
| Go (`gc`, wasip1) | 1.26 | `prog.wasm`, built once from the same sources as the native `go` row | `wasmtime -C compiler=cranelift prog.wasm`; tasks 14 and 15 add `--dir <host dir>::/`, not `--dir .`, because Go opens its preopens by WASI name and expects `/` — the plain form panics with `open data.bin: Bad file number`. No thread flag on any task: Go's wasip1 port is single-threaded, so the goroutines of task 11 are multiplexed onto one thread and the module imports no shared memory. |
| the same compiled modules, under `wamr 2.4.5 (iwasm)` | iwasm | `prog.wasm`, the same bytes | `tools/wamr/iwasm.exe --dir=. prog.wasm`. The one non-wasmtime runtime here that runs the `wasi-threads` task. |
| the same compiled modules, under `node 22` (V8) | node | `prog.wasm`, the same bytes | `node --no-warnings tools/nodejs/wasi-run.js prog.wasm .` — node's own WASI shim. **node's `WASI` provides no `env.memory` and no `wasi.thread-spawn`**, but this shim supplies both itself, so task 11 runs here: it parses the `env.memory` import's shared limits, creates the shared `WebAssembly.Memory` the ABI requires the host to own, and answers `wasi.thread-spawn` with a `node:worker_threads` Worker that enters `wasi_thread_start` against that memory. The shim drops `PWD` from the guest environment: node's WASI uses that variable as the guest's working directory, and a runtime that reads `PWD` directly would resolve a relative name against a path outside the preopen. This was measured while the `go-wasm` row existed — with the host `PWD` set, its task 14 failed with `open data.bin: No such file or directory`. |
| the same compiled modules, under `wasmer 4.3.7 --cranelift` | wasmer-cranelift | `prog.wasm`, the same bytes | `tools/wasmer437/bin/wasmer.exe run --cranelift --mapdir /:<dir> prog.wasm`. Threads are on by default, so task 11 needs no flags. `--mapdir /:<dir>` rather than `--dir=.`, because Wasmer's `--dir=.` preopens an empty root. **Task 15 needs a pre-created `out.bin`**: WASIX can *overwrite* a file it can see on the host but cannot *create* one — a created file stays in an in-memory overlay that is discarded at exit. The registry marks these entries `create_out`, so `exec/harness.py` stages an empty `out.bin` after its usual reset and the module truncates and overwrites it, which does reach the host. `fopen("wb")` truncates either way, so the measured work is the same 50 MiB write. Verified: the cell now leaves a 52428800-byte `out.bin`. |
| the same compiled modules, under `wasmer 4.3.7 --llvm` | wasmer-llvm | `prog.wasm`, the same bytes | The same binary and run line with `--llvm`; only the code generator changes. Same task-15 arrangement. |
| LLVM IR | llc | none — the linked executable imports only `ucrtbase.dll` and `kernel32.dll` | `prog.exe`, built by `exec/llvm-ir/build_all.bat` from the hand-written `.ll`. The build needs `LIB` from `tools/msvc_env.py` for the link and nothing else; there is no `INCLUDE` because no headers are involved and no runtime to install. |
| Scala | native | none | Standalone `.exe`. The link is static, so not even llvm-mingw's `libc++.dll` is needed; without `--native-linking=-static` the executable dies with `STATUS_DLL_NOT_FOUND` when llvm-mingw's `bin` is off the DLL search path. |
| Scala | scala-cli (js) | `node 22` (`tools/nodejs/node.exe`, the same binary the wasm rows use) | No JVM at run time: the Scala.js linker emits one `prog.js`, and the row runs `node prog.js`. `--jvm system` is needed at *build* time only, so scala-cli does not fetch its own JDK. |
| Beef | BeefBuild | none — static native binary | A Release build links the Beef runtime statically. The executable imports only `kernel32.dll`, `msvcrt.dll`, `user32.dll`, `SHELL32.dll`, `ole32.dll`, `gdi32.dll`, `version.dll` and `comdlg32.dll`; no Beef DLL has to be present. Process start-up is about 110–190 ms, which is a third of the row's slowest cell. |
| Haxe | hxcpp | none — native static binary | `-D no_shared_libs` links gcc, libstdc++ and libwinpthread statically; `objdump -p` on the produced executable lists only `KERNEL32.dll`, `USER32.dll`, `WS2_32.dll` and the `api-ms-win-crt-*` UCRT imports. Without that define hxcpp copies `libgcc_s_seh-1.dll`, `libstdc++-6.dll` and `libwinpthread-1.dll` beside the executable. |
| Haxe | haxe (js) | `node` (`tools/nodejs/node.exe`) | No JVM, no VM of its own: `--js` emits one file and node runs it. The js target has no `sys` package, so the row's shared `Out.hx` routes output through `js.Syntax.code`, and tasks 11, 14 and 15 use node's `worker_threads` and `node:fs` directly. |
| Haxe | haxe (jvm) | a JRE, plus `tools/hxjava/lib/hxjava-std.jar` on the classpath (the jar is inside the emitted one) | `java -jar jvm/T<NN>_<name>.jar`. A JVM target, so it lands on HotSpot beside the `java`, `kotlin` and `scala` rows. |
| Haxe | haxe (cs) | the Mono runtime | `mono cs/T<NN>_<name>.exe`. The assembly is compiled by Mono's own `csc`, so no .NET SDK is involved. |
| Haxe | hashlink | `libhl.dll` must sit beside `hl.exe` (the extracted tree provides both) | Two steps: `haxe -cp sources/hashlink -main <module> -hl <out>.hl`, then `hl <out>.hl`. The module name must equal the file name and start uppercase, so the files are `T01_branches.hx` etc. **`Int` is 32-bit on this target**, so every accumulator that can exceed 2^31 is a `Float` (exact below 2^53) or a `haxe.Int64`. **There is no thread API**: `sys.thread` does not resolve, and the bundled `hl.uv` bindings expose no thread creation, so task 11's four workers are four child `hl` processes — each writes its partial to a file, the parent waits on `exitCode()` and sums the files, the same shape the VBScript, COBOL and gforth rows use. Task 10 hand-rolls base-1e9 limbs in `haxe.Int64`. |
| Eiffel | eiffelstudio (`ec -finalize`) | none | The finalized executable links the Eiffel run-time into itself statically; the fifteen `prog.exe` files are self-contained and need no MinGW DLL. |
| Seed7 | s7c | none | The compiled executable is self-contained and needs nothing from the Seed7 tree at run time. Only the compile needs `gcc` on `PATH`. |
| Scheme | chez | none — the installed Chez tree is the runtime (`bin/ta6nt/scheme.exe` plus `boot/ta6nt/scheme.boot`) | No build step. The tree is relocatable but must move as a unit: on Windows the boot files are found at `<exe>\..\..\boot\<machine type>` and in the executable's own directory. It must be the **threaded** build (`ta6nt`) — a non-threaded build has no `fork-thread` and task 11 cannot run. `--optimize-level 3 --script <task>.ss` is the run line; the boot-file load and the on-the-fly compile are part of every measured run. |
| Prolog (SWI) | swipl | the extracted SWI-Prolog tree (`tools/swipl/bin/swipl.exe`) | No build step. The tree is relocatable — it finds its home from the executable's own path, with `SWI_HOME_DIR` or `--home` as an override. Run from `sources/swipl/`, because task 03 loads `03_func_sum_add_one.pl` relative to the source file and task 14 reads `data.bin` from the working directory. |
| Prolog (GNU) | gplc | none — the compiled executable links the GNU Prolog runtime into itself | `exec/gprolog/gplc/<task>/<task>.exe`. The interpreter is not used at run time and the measured cell is the native executable, not `gprolog.exe`. **Task 11 is four child processes of that same executable**, joined with `wait/2`; GNU Prolog 1.5.0 has no thread primitive. |
| Janet | janet | none — the extracted install tree is the runtime | No build step; `janet` compiles the script each run. The binary needs the MSVC runtime (`vcruntime140.dll`); the release also ships a static Cosmopolitan `janet.com` as a fallback. Task 11 uses the core `ev/` threads, so nothing extra is installed. |
| JScript | cscript | none — `cscript.exe` ships with Windows | Windows Script Host's Active Scripting JScript engine, which is not the `JavaScript` row's bun/deno. The `.js` extension is mapped to it; `//E:JScript` is passed explicitly. On Windows 11 24H2 and later the engine is JScript9Legacy, which reports 11.0.16384, rather than classic JScript 5.8. Task 03 needs `03_func_sum_add_one.js` beside it; tasks 14 and 15 need the working directory to hold `data.bin` and to be writable for `out.bin`. |
| Standard ML | Poly/ML | `PolyLib.dll` must be beside the executable | No build step at run time: the `.obj` the compiler exports contains the whole heap image, and the stub's `WinMain` loads it. Without `PolyLib.dll` next to the `.exe` the program dies before `main` with `STATUS_DLL_NOT_FOUND` and prints nothing. An exported program has no banner and no prompt — the top-level loop never starts — so the row's stdout is exactly the one expected line. Start-up floor about 65 ms. Tasks 14 and 15 run from `sources/standardml/` so that `data.bin`/`out.bin` resolve; task 14 reads in 65536-byte chunks. **The run line passes `-H 1024`** — Poly/ML's initial heap size, in megabytes — and it is required rather than a tuning knob: an exported image starts on the run-time system's default heap and grows it on demand, and when that growth fails under memory pressure the process dies with `Run out of store - interrupting threads` and no output. Measured on this machine: task 12 failed in about half of six runs, and task 06 died silently once, both with the default heap; neither failed in ten runs with `-H 256`. Reserving the heap up front also removes the growth steps, so the same cells measure about half the time — task 12 is about 25 ms against about 55 ms. |
| Terra | terra | none, but the interpreter needs `VCINSTALLDIR` set and `INCLUDE` pointing at a C sysroot | No build step: `terra.exe <task>.t` compiles and JITs on every run, so that compile is inside the measured number, and an empty program still costs 36-50 ms. **`VCINSTALLDIR` must be non-nil or the interpreter aborts before opening the file** with `Can't find windows SDK version 8.1 or 10!` — it is a switch, the path is never read. `INCLUDE` is needed only by task 11, which includes `windows.h`; on this host it points at `tools/llvm-mingw/include`. Nothing is linked, so no MSVC and no Windows SDK are required. Task 15 syncs through `_commit`, so this row is not in the flush-and-close group. Tasks 14 and 15 run from `sources/terra/` so that `data.bin`/`out.bin` resolve. |
| Nelua | nelua | none — native static binary | The compiled executable is self-contained and needs nothing at run time; only the compile needs the toolchain tree and a C compiler. `nelua.bat` has to be invoked through `cmd.exe`, and the build must run from `sources/nelua/` because `require` resolves against the working directory. Task 03's helper is a second module with `<noinline>`. Task 15 syncs through `_commit`, so this row is not in the flush-and-close group either. Tasks 14 and 15 run from `sources/nelua/` so that `data.bin`/`out.bin` resolve. |

### JVM versions are not interchangeable

Eight rows need a JVM, and they disagree about which one:

- `kotlin/native` needs a JDK for its launcher. The 1.9-era launcher mis-parsed JDK 24's version string and failed with a batch syntax error; the current 2.4.20 prebuilt drives JDK 25.0.2 fine, so the constraint is a launcher-version question rather than a JDK ceiling. The first build downloads its LLVM and libffi dependencies (about 1.4 GB) into `%USERPROFILE%\.konan`.
- `scala` needs anything modern. Oracle's `java8path` shim, if it is ahead of the real JDK on `PATH`, makes `scalac` fail on class file version 61.0.
- `graalvm native-image` is its own JDK 25.
- `java/graalvm jit` needs **GraalVM's own JDK**, not any JDK: a plain OpenJDK has no Graal compiler in it, so running the class files under HotSpot would silently be the `openjdk` row again. GraalVM 25 is the JDK the `native-image` and `graalpy` rows already need.
- `java/openjdk` is the plain HotSpot row; `java/openj9` runs the same class files on IBM Semeru. (`java/loom` needed **JDK 21 or newer** for `Thread.ofVirtual()` — on JDK 17 it does not compile, and on 19 and 20 it compiles only with `--enable-preview` — until that row was removed. and `--release 19 --enable-preview` at run time.

- `java/openj9` needs **IBM Semeru's JDK**, not any JDK: OpenJ9 is a different VM from HotSpot, and running the same class files under HotSpot would silently be the `openjdk` row again. It ships its own `javac`, so the row is self-contained.

Set `JAVA_HOME` per row rather than relying on whatever `java` resolves to. On a machine with
several JDKs installed, the default `PATH` order is usually the wrong one for at least two of
these rows. `openjdk` and `openj9` are the exception that proves the rule for a different
reason: they share every source file, so the pair isolates the VM — a difference there is a
difference in the JDK rather than in the row. `openj9`
is the opposite case — the same fifteen files and the same `javac` invocation, a different VM
executing them, so every one of its cells is a VM comparison.

## Task 11: which languages can actually do it

Task 11 is the only task whose mechanism differs per language, and the only one that is not
portable at all: the Assembly rows can only do it on Windows. This is what each language
actually has, verified by running the task or by reading the official documentation.

### Real OS threads, no problem

C, C++, Rust, Zig, Go, D, Swift, Ada, Pascal, Java (both rows: `openjdk` uses
`java.lang.Thread` and `openj9` uses the same call on OpenJ9, which maps it to an OS thread),
Kotlin (both rows), C#, F#, VB.NET,
Scala (both rows), Nim, Odin, Julia (`-t4`), Fortran (OpenMP, needs `-fopenmp`), Perl (ithreads),
PHP (`parallel`, needs a ZTS build), Crystal (`Fiber::ExecutionContext::Parallel`),
Objective-C (`NSThread`), Modula-2 (Win32 `Threads` module), Modula-3 (`Thread.Fork`), BASIC (`THREADCREATE`),
Clojure (`java.lang.Thread` interop, not `future`), Common Lisp (`sb-thread:make-thread` on real Win32 threads), OCaml (`Domain.spawn`/`Domain.join`, OCaml 5 only), Elixir (`spawn` onto a BEAM scheduler, one per core, no global lock), Vala (`GLib.Thread`), Component Pascal (the .NET `Threading` module,
via `REGISTER` on a bound method with the foreign `Th.ThreadStart` delegate), C3 (`std::thread`),
Beef (`System.Threading.Thread`; `CreateThread`, `ResumeThread` and `SetThreadPriority` are in the
executable's import table), Haxe (`sys.thread.Thread.create`, which hxcpp implements as
`CreateThread`), Eiffel (EiffelThread's `THREAD` mapped onto Win32 threads, with the project's
concurrency capability set to `thread`), Scheme (`fork-thread`/`thread-join` on a threaded
`ta6nt` build, directly on the Windows API), Prolog (SWI) (`library(thread)`: `thread_create/3` +
`thread_join/2`, partials returned through `thread_send_message/2` because the goal is copied),
J (`0 T. ''` plus `u t. n y` tasks, futex-based threadpools with no GIL; measured 1.7x rather than
4x, because J's explicit verbs run about 1.8x slower inside a worker thread than on the master
thread),
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

**Three more rows added later are in this group too.** Pony (`Worker` actors scheduled by the
runtime's thread pool — an in-process probe reading `runtime_info.Scheduler.scheduler_index()`
reports the four workers on schedulers 1, 2, 0 and 3 at `--ponymaxthreads=4 --ponynoscale`, and
all four on scheduler 0 at `--ponymaxthreads=1`), Boo (`System.Threading.Thread` on CoreCLR),
Lean 4 (`IO.asTask`, which hands the action to Lean's task pool — the compiled program holds 12
OS threads while four workers run; measured 2992 ms on one worker against 1876 ms on four on a
busy 8-core box)).

**The six WebAssembly rows that pass** are one mechanism, and it is a third kind: C, C++, Rust,
AssemblyScript, the hand-written WAT row and Zig all reach the host's thread API through
`wasi-threads` — the module imports `wasi::thread-spawn`, exports `wasi_thread_start`, and the
runtime creates the OS thread, hands it the module's shared memory, and calls the export on it.
The four quarters are real OS threads on real cores; the hand-written row measured **2.66x** on
four workers (0.142 s against task 02's 0.379 s, both 108000000 iterations). It is neither a
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
| Pharo | `Process`/`Semaphore`, which are **green**: the VM multiplexes the whole image onto one OS thread, so four forked workers interleave and never run at once. There is no OS-thread class in the image. Every production Smalltalk is in this position, the same one the Dolphin row records. | `8748000081000000`, **3037 ms** as four forked Processes against the serial task 02's **2714 ms** — the `fork`/`Semaphore` machinery is if anything slower than the plain loop, so the cell is correct-answer-no-speedup |
| Factor | four `future`s from `concurrency.futures`, which is `threads`' own co-operative green-thread scheduler, not OS threads | `8748000081000000`, **~8.3 s** as four futures against **~5.0 s** for the same four chunks run sequentially — the extra scheduling and per-thread data-stack machinery costs more than the parallelism saves |
| Go (tinygo) | TinyGo's default `tasks` scheduler: the goroutines are cooperative and every one of them runs on the single OS thread. `-scheduler=cores` and `-scheduler=threads` cannot be substituted on this host — neither builds for Windows/amd64, stopping in `internal/task/task_stack_multicore.go` ("`t.state.resume` undefined") and in `internal/task/task_threads.go` ("`undefined: threadID`") respectively, because neither scheduler has a Windows implementation. | `8748000081000000`, and there is no speedup to show for the four goroutines: task 11 measures **39.6 ms** against **40.3 ms** for task 02's plain single-threaded loop, three runs each on this host, where four real threads would put it near 10 ms |

### Works, but not with shared-memory threads

| Language | What it has | Measured |
|---|---|---|
| JavaScript | `worker_threads`, one thread each with its own heap | `8748000081000000` |
| Dart | isolates, each with its own memory, message passing only | documented |
| R | `PSOCK` cluster: separate R processes | `8748000081000000` (timing not measured, see below) |
| Lua | needs the Lanes C extension (or llthreads2) | `8748000081000000`, **3.56x on 4 threads** |
| Python | threads exist but the GIL serializes them | correct, **0.97x** — use `multiprocessing` for 2.3x |
| Python (cython) | the same `threading.Thread` source, compiled; Cython runs it under the same GIL | correct, and measured serial: an in-process probe of the identical loop gave **1.03x** on four threads, against CPython's 0.97x. Cython does not release the GIL from a pure-mode module |
| Ruby (CRuby) | threads exist but the GVL serializes them | correct, no speedup |
| Lua (lua.wasm) | no threads: the native rows use the Lanes C extension, which is a pthreads binding with no wasm build. The four workers are **coroutines**, the language's own cooperative concurrency. | `8748000081000000`, and the work is serial: measured, the coroutine version takes 2.3 s against task 02's 2.6 s |
| ActionScript | AIR `Worker`: separate AVM2 instances, no shared memory, results via shared properties | `8748000081000000`, **2.91x on 4 workers** |
| VBScript | four `WScript.Shell.Exec` child processes, one per quarter, partials read back from each child's stdout | `8748000081000000`, **3.41x on 4 processes** |
| Racket | `(thread thunk #:pool 'own #:keep 'results)`: each thread gets its own OS thread with the heap shared, and `thread-wait` returns the result. Plain `thread` is green and `future` serialises at blocking operations, so neither is used. | `8748000081000000`, real multicore work |
| Janet | `ev/spawn-thread`/`ev/thread` + `ev/thread-chan`: one OS thread per worker, each with its own heap, partials sent back over a threaded channel (the isolates shape Dart and JavaScript use) | `8748000081000000`, **4.9x on 4 threads** |
| Seed7 | four `startPipe` child processes of the same executable, one per quarter, partials read back from each child's stdout with `getln(childStdOut(p))` and joined with `waitFor` | `8748000081000000`, real parallelism across four cores |
| JScript | four `WScript.Shell.Exec` child processes, one per quarter, partials read back from each child's stdout | `8748000081000000`, real parallelism on four cores, but not a clean 4x over task 02 — see below |
| Luau | four child processes, one per quarter, launched with Lute's `@lute/process.run` and read back through their stdout. The plain Luau CLI cannot do this at all: it exposes no `io`, no `os.execute` and no `package`, so the row's tasks 11, 14 and 15 need **Lute**, the Luau team's own runtime, while tasks 01–10, 12 and 13 run under `luau.exe` | `8748000081000000`, real parallelism: four concurrent children measured 1.46 s wall against 3.42 s sequential |

### The rows that need explaining

**Lua.** Stock Lua has no threads, only coroutines, which are cooperative and
single-threaded. But `lanes` is a mature C extension that wraps real OS threads, and it
works: Lua 5.4.6 with Lanes 3.17.2 produced `8748000081000000` and ran **3.56x faster on four
threads**. So Lua is not `SKIPPED`, but it needs `luarocks install lanes` first. The
alternatives are `lua-llthreads2` and `LuaThread`, both also C extensions.

**R.** R has no threads for R code at all. `parallel::mclapply` forks processes and is
**Unix only** — on Windows it fails with `'mc.cores' > 1 is not supported on Windows`, and
`makeCluster(type="FORK")` fails with `fork clusters are not supported on Windows`. What
does work everywhere is `makeCluster(type="PSOCK")`, which starts separate R processes and
communicates over sockets. That produces the right answer. The `0.07 s against 0.15 s` figure
this file used to quote for it is not consistent with the current task: 108000000 interpreter
iterations of a `switch` cannot finish in 0.15 s when CPython needs 10 to 15 s for the same
work, so treat the R timing as unmeasured until it is re-run.
Note that PSOCK workers start with an empty environment, so constants must be pushed out
with `clusterExport` or they fail with `object 'N' not found`.

Threading in R exists only inside C-level packages, such as OpenMP in `data.table` or TBB
in `RcppParallel`. Plain R code never runs on two threads.

**Assembly.** A freestanding PE program has no libc, so there is no `pthread_create` to call
and no thread library to link, and no C runtime to start one for it either. The task is still
four threads: `11_parallel_sum.asm` calls `CreateThread` four times, each worker on its own
stack, and joins them with `WaitForSingleObject`. Each worker is task 02's jump-table switch
over a fixed range of 27000000 iterations, so the four together print the same number as task
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
therefore prints `8748000081000000` with no speedup over task 02, the same cell CPython and
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

line that build it.

**Pony.** Two things about this row are load-bearing. The first is the version: ponyc **0.65.0**,
not the current release. Pony 0.66.0 reworked how it does networking on Windows and the release
notes now give the minimum as Windows 11 / Server 2022 (build 20348), because the new networking
layer uses an OS readiness API introduced in that build. This machine is Windows 10 19045, and
0.65.0 predates the change, so it is the last release that runs here — the same class of
constraint as `poly/ml`'s 5.9.1 and `wasmtime`'s 46.0.3. The second is task 03. Pony has no
no-inline marker, and ponyc compiles every package into a single LLVM module, so a plain
`fun add_one` is inlined and the four-hundred-million-iteration loop is constant-folded away
completely: `ponyc --pass=ir` shows the loop replaced by the constant `400000000`, and the
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

**GDC used to be the third D toolchain, and is gone.** There is no current GDC on Windows:
Cygwin's `gcc-gdc` gives you a working `gdc.exe` and its `d21` backend but **no D runtime** —
no `object.d`, no phobos, no druntime — so the first compile dies with `cannot find source code
for runtime library file 'object.d'`, and no companion package exists. MSYS2 packages no `gdc`
at all, and WinLibs, whose front page advertises C, C++, Objective-C, Fortran *and* D, ships no
`gdc` binary in any archive. The row therefore ran on **GDC 4.9.2 with D 2.066.1**, built in
April 2015 — the last native-Windows GDC ever published — and that age is what made it the
toolchain to drop: it predates `pragma(inline, false)` (D 2.070) and `MonoTime`, so every task
in `sources/d/` carried a `version(GNU)` branch just for it, and its task 03 measured **362 ms
against dmd's 30 ms and ldc2's 22 ms** — a 12x outlier that was a compiler-version artifact
rather than a language property. Removing it let those fifteen files drop their `version(GNU)`
branches; `dmd` and `ldc2` never compiled them in the first place.

**Luau.** The plain Luau CLI cannot run three of the fifteen tasks, and not for an interesting
reason: it exposes **no file I/O and no process API at all**. Dumping `_G` shows no `io`, no
`os.execute`, no `package`, no `dofile` and no `loadfile`, and its `os` is exactly
`{clock, date, difftime, time}`. Its only file access is `require()` of Luau source. So
`data.bin`, `out.bin` and the four child processes of task 11 are unreachable under `luau.exe`,
not merely awkward. The row runs tasks 01–10, 12 and 13 under `luau.exe` and tasks 11, 14 and 15
under **Lute**, the Luau team's own runtime, which supplies `@lute/fs` and `@lute/process.run` and
a scheduler on which `process.run` yields — four concurrent children measured 1.46 s wall against
3.42 s sequential. Leaving the standard library is allowed here for the same reason Lua's Lanes
is: the rules say task 11 may use the language's own threading extension when the standard
library has none, and Lute is Luau's own runtime rather than a third-party bolt-on.

**Luau is one toolchain, not two.** It was registered as `luau` for tasks 01–10, 12 and 13 and
`lute` for 11, 14 and 15, which made one language look like two front ends and split a single
row's coverage across two names. The split is a property of the *tasks* — which of them need file
I/O or processes — and not a choice between two builds of the same program, so the registry now
registers the one toolchain `luau` and its cells carry the engine that ran them: `luau` for the
twelve VM cells, `lute` for the three. Nothing else changed; the two engines are still not the
same backend and their numbers are still not comparable (Lute enables Luau's native code
generator for functions it runs hot, the plain CLI does not), which is exactly why the engine
stays visible on every cell instead of being flattened into the toolchain name.

**Zig (wasm).** The wasm row is the native `sources/zig/` row's sibling, and Zig reaches
`wasi-threads` the same way C and C++ do — but with a flag the C rows do not need. `-rdynamic` is
load-bearing: wasm-ld only exports symbols listed in the dynamic table, and without it the module
instantiates and then dies with `failed to find a wasi-threads entry point function; expected an
export with name: wasi_thread_start`. `-fno-single-threaded` is also required, because Zig's
default for wasm is single-threaded and `std.Thread.spawn` does not exist without it. The
verification is a barrier test rather than a timing: all four workers spin on an atomic counter
until all four have arrived, which cannot complete under cooperative scheduling, and the four
spans then overlap.

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
for want of a concurrency facility. Two rows were expected to land here and neither did:
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
  (`WScript.Shell.Exec` children), Seed7
  (four `startPipe` children), JScript (four `WScript.Shell.Exec` children of the same
  script), and JavaScript if you count worker threads as not being threads.
  ActionScript belongs here too:
  AIR `Worker`s run on real OS threads but are separate AVM2 instances with no shared memory,
  so they are isolates rather than threads in the same sense Dart's are.
- Pass, with the GIL/GVL caveat recorded: CPython, CRuby and Dolphin Smalltalk, whose `Process`
  objects are green and multiplexed onto one OS thread. `Cython` belongs here too:
  its task 11 is the `cpython` row's `threading.Thread` source compiled unchanged, and
  pure-mode Cython does not release the GIL, so the four workers serialise exactly as CPython's
  do. The same is true of the `Lua (lua.wasm)` row, whose
  task 11 is coroutines because its wasip1 build has no threads at all.
- Pass, but only with an extra install or flag: Lua (Lanes), Tcl (the `Thread` package),
  PHP (`parallel` on a ZTS build), Julia (`-t4`) and Fortran (`-fopenmp`). Without the flag
  Julia and Fortran still print the right answer, because their loops fall back to serial.
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
Prolog (SWI), J, Janet and JScript note.

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

**The bundle is line-ending sensitive, so it is checked out byte for byte.** This one is a
property of the repository rather than of the runtime, and it is the reason `.gitattributes`
exists at the root. `adt -target cmdline` does not write a single file: `out\` is a
*directory* package — `prog.exe`, `prog.swf`, `mimetype`, `META-INF\` and `Adobe AIR\` — and
the runtime validates the bytes inside it before running the program. Five of those files are
plain text, so a checkout with `core.autocrlf=true` (the Windows default, and set on this
machine) rewrites them to CRLF and every cell then fails with

```
Security warning: invalid license or package - application may have been modified after packaging
```

Measured, one file at a time, on task 09: the package loads with `META-INF\AIR\application.xml`
restored to its committed bytes, and does not with `signatures.xml` or the
`Adobe AIR\...\Licenses\*\COPYING` files restored. `META-INF\AIR\hash` is a 32-byte digest,
but it does not equal a plain hash of any single file in the bundle, so which bytes are being
compared is not established — what is established is that `application.xml`'s must be the
committed ones. `.gitattributes` therefore marks `exec/actionscript/*/out/**` `-text`, which
is scoped to the packaged directories: the row's `.as` sources, logs, `app.xml` and scripts
are ordinary working files and keep the normal text handling.

Two consequences. A clone made before that file existed still holds the CRLF copies, and the
row stays broken until they are restored:

```
git rm -r --cached exec/actionscript
git checkout -- exec/actionscript
```

And repackaging is not needed to repair it — the committed bundles are intact, only the
working-tree copies were rewritten. `git status` cannot see the damage on its own, because
`core.autocrlf` converts the worktree back to LF before comparing, so the files look clean
while the bytes on disk differ from the blobs.
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

**Staging, and why it is hard links.** Tasks 14 and 15 run from a working directory of their
own, so each row needs the fixture beside its program. Doing that with copies is what made
`exec/` 23.2 GB, of which 17.5 GB was 359 copies of this one 50 MiB file — 215 `data.bin`
plus 144 `out.bin`. `exec/stage_fixtures.py` is the alternative:

```
python exec\stage_fixtures.py            # replace every data.bin copy with a hard link
python exec\stage_fixtures.py --prune    # also delete the copies nothing reads
python exec\stage_fixtures.py --check    # report only, change nothing
```

A hard link is a second name for the same file — the bytes exist once, every program that
opens `"data.bin"` relative to its working directory still sees an ordinary file, and the
tree drops by 10.5 GB. It has to be the same volume, which it is inside one checkout. The
script verifies the root fixture's sha256 before and after, so a run that damaged it is
caught rather than propagated into 200 more directories.

`--prune` removes two kinds of file, both regenerable. `data.bin` inside
a `*15_file_write*` directory: no task-15 program reads it, because task 15 writes `out.bin`
and nothing else, so those 67 copies are pure waste. And `out.bin` anywhere, which task 15
overwrites on every run. Neither is worth committing: the fixture itself is already at the
repository root, and `out.bin` is a result, not an input. `exec/` is tracked — the built
programs and their row scripts both — so `--prune` is what keeps a checkout from carrying
359 copies of a file that exists once.

The verifiers tolerate either state: each one copies the fixture only when the destination is
missing or is not already the same file, so a hard-linked tree and a freshly built tree both
verify. `build_all.bat` for a row still copies `data.bin` the ordinary way, so a row can be
rebuilt from scratch and re-verified without staging first.

## Measurement tooling

Every row has a **row verifier** at `exec/<row>/verify.py`, and it is what decides whether a
row passes: run one command, compare one line of stdout, read the timing line, check the file
side effect. It is not the timer — the program times itself under the contract below — it is
the pass/fail check that keeps a row honest while its cells are being filled in.

A verifier checks three things per task, and nothing else:

1. **stdout** equals the task's `expected output:` line, read from the row's own source header
   rather than from a copy, so a source edit cannot leave the check behind;
2. a **`TIME_MS`** value is present, on stderr or in `time.txt` for the rows whose language has
   no reachable stderr;
3. **task 15 left `out.bin`** behind, at 52428800 bytes, and task 14 read the fixture.

Rows whose task 15 writes somewhere other than the working directory say so in the verifier:
`actionscript` writes `out.bin` and `time.txt` into AIR's application-storage directory, and
those are deleted before each run because all fifteen of its tasks share that one directory.

Run one with `python exec\<row>\verify.py`; it prints one line per task and a final
`<ROW> PASS n/15`. `exec/python/verify.py` is a thin entry point over the only row that needs
two verifiers — `verify_interpreters.py` for cpython/pypy/graalpy and `verify_compilers.py`
for nuitka — because its four toolchains are two interpreters and two compilers with
different run recipes.

### The harness

The verifiers answer "is this row still correct?". `exec/harness.py` answers "how fast is
every cell, how much memory does it take, and how big is the program?" — it runs every built
program in `exec/`, not just one row's, and it is the tool the results table comes from.

```
python exec/harness.py                    # every cell, one timed run a cell
python exec/harness.py --runs 5           # five timed runs a cell
python exec/harness.py --runs 3 --rows c,rust --tasks 01,07,10
python exec/harness.py --rows ada         # one row, by its folder under exec/
python exec/harness.py --language C++     # every row of one language
python exec/harness.py --start 1 --end 200    # items 1-200 of the matrix
python exec/harness.py --start 201 --end 400  # the next chunk
python exec/harness.py --rows 1-30        # the first thirty languages, by number
python exec/harness.py --check            # one run each: pass/fail, no timing
python exec/harness.py --validate         # check the registry without running anything
python exec/harness.py --list             # print the cells that would run
python exec/plot.py --open                # results.json -> the interactive results.html
```

`--runs N` is the whole-suite repetition count: `--runs 1` (the default) runs the entire suite
once, `--runs 5` five times, `--runs 3` three times. Every run counts — there is no
discarded warmup, so the median is taken over all of them — and the first run is also where
the answer is checked, which is why a cell that answers wrongly is reported as `WRONG`
instead of being measured.

`--check` runs each cell once and reports pass/fail without timing. It is the fast way to
ask "does every row still work on this machine?" without paying for repeated runs a cell.

On a terminal the run draws a live status line for the cell in flight — which cell of the
selected set, which run of that cell's `N`, the previous run's time, how long the cell has
taken so far, and the program being loaded:

```
[12/165] ada/gnat 09_fib_recursive                run 3/5  last 556.4 ms  cell 1.7s  t09_fib_recursive.exe
```

The line is cleared when the cell ends, so the ordinary result line takes its place.

Nothing is drawn while a program is running, and that is deliberate. `pinned` sets the
affinity mask on the harness process itself, so the harness shares the cell's cores with the
program it is measuring; a thread redrawing a status line mid-run would take time from the
program being timed — the same cost the harness avoids when it keeps a child's stdout off
the console. The counter therefore advances at run boundaries, and the two elapsed figures
are the previous run's time and the cell's total so far, not a clock ticking under the
child. With stdout redirected the line is not drawn at all, so `> log` and pipes keep
exactly the one-line-per-cell output they always had.

#### Running part of the matrix

`--list` numbers every cell — row first, then toolchain, then task — and `--start`/`--end`
select an inclusive range of those numbers. `--start` alone runs from there to the end,
`--end` alone runs from the beginning to there. Numbers are positions in the *selected* list,
so `--rows rust --start 1 --end 15` is the whole Rust row, while a bare `--start 1 --end 200`
is the first two hundred cells of the matrix.

`--rows` itself takes names, numbers and ranges: `--rows c,rust`, `--rows 7`, `--rows 1-30`,
`--rows 1-109` (everything). Both together is how a long sweep is broken up.

#### Running one language

A row is named by its folder under `exec/`, so `--rows ada` is Ada's fifteen cells. The name
is case-insensitive and may be given as a path — `--rows exec/ada`, `--rows sources\ada`,
`--rows ./exec/ada/` are all the same row — which is convenient when the name comes from a
listing or a shell completion rather than from memory.

A language the results table splits across several rows is run with `--language` and the name
that table gives it:

```
python exec/harness.py --rows actionscript       # one row: its fifteen cells
python exec/harness.py --language C++            # cpp and cpp-wasm, sixty cells
python exec/harness.py --language Python         # python, python-cython
python exec/harness.py --language "Prolog (SWI)" # the one row, named as the table spells it
python exec/harness.py --language C --rows rust  # the two are unioned
```

Both are merged into `exec/results.json` like any other run, so re-measuring one language
leaves every other language's numbers alone: `--rows ada` after a full sweep rewrites Ada's
fifteen cells and nothing else. A name that matches no row and no language is an error, not an
empty run — with a merged file, a run that selected nothing would look like a run that
measured nothing, so the harness stops and suggests the nearest names instead.

`--language` matches the Language column of the results table exactly (apart from case), so
`--language C` is the `c` and `c-wasm` rows and `--language C++` is `cpp` and `cpp-wasm`;
quoting is needed for the names with spaces, as usual for a shell.

#### Results are additive

`exec/results.json` is merged, not replaced. A cell measured again replaces its own older row;
a cell that was not run keeps the number it already had; `--replace` starts the file over.
So

```
python exec/harness.py --start 1 --end 500
python exec/harness.py --start 501 --end 1000
```

leaves a file holding all thousand cells, and a sweep killed half-way is continued with
`--start` rather than repeated. Because the file can then hold cells measured by different
invocations, each cell carries its own `runs`, `pinned_cpu` and `measured` fields, and the
header reports the spread (`"runs": "1-5 (mixed)"`) rather than one number that would be true
of only some rows.

The file is written atomically — a temporary file then a rename — and flushed every
`--flush-every` cells (25 by default, `0` to write only at the end), so a run cut off mid-way
keeps everything but the last few cells rather than losing the whole sweep. `Ctrl+C` writes
what was measured and prints the `--start` to continue from.

A `--check` cell never replaces a timed one. It carries no number — one run has no median —
so letting it overwrite a measured cell would quietly throw the measurement away and leave a
row that looks measured but has nothing in it. Checking a cell that was never timed still
adds it, and such a cell is marked `"check": true` in the JSON so a reader can tell.

Per cell the harness records

| What | How |
|---|---|
| Speed | the program's own `TIME_MS`, plus the harness's end-to-end wall clock beside it |
| Memory | `PeakWorkingSetSize` from `GetProcessMemoryInfo` on the child's handle |
| File size | the built program — or, for an interpreted row, the script that was executed |
| Correctness | stdout against the task's expected line, judged on the first run |

and reports the median, minimum, maximum and standard deviation of the runs. Results go
to `exec/results.json`, every sample, and `exec/results.md`, the three tables — speed, peak
memory and program size — in the same Language/Toolchain/task shape as the results table in
`README.md`, so a run can be pasted straight into it.

`exec/plot.py` reads that file and writes `exec/results.html`, a self-contained, offline
benchmark explorer. The page embeds every recorded sample and uses the registry to include
toolchains and cells not yet run. It adds no dependencies: plain HTML, SVG and JavaScript.

- **Task ranking** opens with every language/toolchain separate. Each individual row carries
  its execution kind (Native AOT, Native JIT, bytecode VM, interpreter, WebAssembly or
  assembly); colour is not the only indication of kind.
- **Engine-kind and status filters** apply to all views, and the metric selector picks which
  number is ranked and charted. Pagination defaults to 25 rows, with 50, 100 and All options.
  No fastest-N cutoff silently discards the remaining rows.
- **Overall ranking** ranks one item per front end — a language plus its toolchain, which is
  what the matrix measures — over the rows the filters leave. Nothing is rolled up: `C`/`gcc`,
  `C`/`clang` and `C`/`msvc` are three entries, and no entry stands for all of C. Each item
  takes a position per task among the filtered toolchains (1 is the fastest, ties share the
  better position); the rank sum adds those positions, the mean rank divides by the tasks the
  item covers and the suite time adds its execution medians. **Rank sum**, **Mean rank** and
  **Suite time** are the three columns and the ordering control: click any of them to sort by
  it, or use the selector. Mean rank is the default; the first two agree for a toolchain
  measured on all fifteen tasks and differ only in the incomplete tail. The strip shows the
  item's position in each task. Only complete items are ranked: a sum of positions rewards work
  that was never done, so an item missing tasks is listed after the ranked ones with its
  coverage. The all-task matrix follows this order.
- **Bar encoding** defaults to linear measured values: each value divided by the largest
  matching value. Shorter time bars mean faster execution; 20 ms is twice the bar length
  of 10 ms. Bars start at zero with no minimum width, so very fast results can be tiny beside
  slow outliers. The compact bar track is at most 220 pixels wide. The optional logarithmic
  encoding compresses large ranges and explicitly warns that lengths are not proportional.
  The scale includes all matching pages. The separate
  **vs. best** ratio compares each value to the smallest positive matching value;
  zero timings have no ratio. Inverse relative-speed bars are not offered.
- **Metric** selects execution time, end-to-end wall clock, peak memory or artifact size.
  All metrics use the same shorter-is-better direction. Wall-clock fallbacks and mixed timing
  sources are flagged rather than silently presented as self timing.
- **All-task matrix** displays every task with sticky headings and horizontally scrollable
  columns. Sorting uses the selected task. Status filters retain rows with any matching
  task; the other cells keep their real statuses. Click a task heading to rank it.
- **Compare trends** draws the current page's toolchains across tasks on a log or
  linear axis. Adjust the page size to control crowding; legend buttons hide
  individual lines, wheel zooms, drag pans and Reset zoom restores the view. Missing values
  break lines; zeros are omitted on the logarithmic axis, not changed into positive values.
- **Details** (also available from matrix values and chart points) exposes all metrics,
  sample timings, variation, correctness-check flags, warnings/errors, and the full record
  including commands and captured output. A language's details list every contributing or
  missing toolchain, with an Inspect button for its record. Escape closes the inspector.

Failed, skipped, **Not run**, **Not supported** and **No metric** are distinct; none is counted
as a zero or silently discarded from the all-results view. “OK” reproduces the recorded
harness status; the inspector says separately whether correctness checking was enabled.
The footer explains the method and retains the file metadata; individual records retain
their own measurement dates, since a results file can combine several batches.

A cell ends in one of four states, and the difference matters:

| State | Meaning |
|---|---|
| measured | the first run printed the expected answer and the runs produced numbers |
| measured `!` | as above, but something about how it ran is worth knowing — see below |
| skipped | the cell cannot run on this machine: the toolchain is not installed, or a runtime it needs is not (a `0xC0000135` or `0xC0000142` load failure with no output) |
| failed | `WRONG` — the program ran and printed a different answer; or `ERROR` — it timed out, died without producing anything, or failed to load for some other reason |

The pass criterion is the one the row verifiers use: the expected line on stdout, a `TIME_MS`
value, and task 15's 52428800-byte `out.bin`. **The exit code is not part of it.** A row may
die in teardown after printing both numbers — `hxcpp` does, with a heap-corruption code — and
the contract brackets only the work up to the final output statement, so that measurement
stands. Such a cell is measured and marked `!`, with the code recorded; the same applies to a
run that produced no number at all, which is dropped from the statistics rather than
counted as a zero. A cell with no `TIME_MS` line anywhere — the twelve `luau.exe` cells, whose
CLI has no stderr — is measured by wall clock and marked `*` in the speed table.

A crashed child would otherwise put a Windows error dialog on the screen, and Windows Error
Reporting's handling of it costs seconds that land in the wall clock — measured, 2.8 s for a
68 ms cell. The harness sets `SEM_NOGPFAULTERRORBOX | SEM_FAILCRITICALERRORS |
SEM_NOOPENFILEERRORBOX` once at start-up, which every child inherits, so an unattended run
cannot block on a modal dialog.

**The registry.** How each cell is invoked lives in `exec/cells.json`, one entry per
(row, toolchain): the exact argv, working directory, environment and timeout, transcribed
from that row's `verify.py`. The verifier stays the authority — if a run recipe changes, the
verifier changes first and the registry follows. Placeholders `{root}`, `{task}`, `{row}`,
`{toolchain}`, `{PATH}` and `{env:NAME}` are substituted at run time; an entry's `tasks` list
names the tasks it covers, `["*"]` covers the rest, and `except` carves out the tasks a
different toolchain of the same row runs instead.

Two optional keys say where a row keeps files outside its working directory, and both are
needed because the harness can only look where it is told:

- **`time_file`** — where the `TIME_MS` fallback lands. Only the AIR row needs it: its bundle
  is read-only, so `time.txt` goes to the application-storage directory
  (`%APPDATA%\stupidspeed.actionscript\Local Store\time.txt`). Without the key the harness
  reads `<cwd>/time.txt`, finds nothing, and reports all fifteen AIR cells as wall-clock
  timings (`*`) — the number would be right but it would be the wrong number, start-up
  included, and the row's real `TIME_MS` would be discarded.
- **`out_file`** — where a task-15 program writes `out.bin`, when that is not the working
  directory. Again AIR, for the same reason. Without it the cell measures fine but is marked
  `!` with "task 15 left no out.bin", because the harness looked in the wrong place.
- **`restore`** — files the program rewrites that are *committed*, and so have to be put back
  after a run. Only the `gleam` row needs it: `gleam run` re-sorts the `[packages]` table of
  `exec/gleam/build/packages/packages.toml` on every invocation, which leaves a dirty
  checkout behind. The harness snapshots each listed path before the cell and restores it
  afterwards, exactly as it already does for `out.bin` and `time.txt`.

The harness stages the fixture and clears residue the way the verifiers do — `data.bin`
put into a cell's directory for task 14 (task 15 never reads it), `out.bin` and any
`time.txt` deleted before *every* run, not once per cell, because several task-15 programs
fail outright if `out.bin` is already there and a stale `time.txt` would be read as the new
number. Everything it deletes is put back when the cell finishes — whether it measured, was
skipped or failed — so a run leaves `exec/` exactly as it found it.

That delete is retried rather than attempted once. Windows refuses to remove a file while
another handle still holds it mapped — error 1224, "the requested operation cannot be
performed on a file with a user-mapped section open" — and a task-15 program that has just
written and fsync'd 50 MiB keeps that mapping for a few milliseconds while its runtime tears
down. Losing that race left the old `out.bin` in place, the next program failed to open it,
and the cell was reported as producing no measurement at all: an artifact of the harness
reported as a fact about the language. The retry is bounded, and a file that is genuinely
stuck is recorded as a `!` note instead of being swallowed.

Three rules from the sections above are built in rather than left to the operator:

- **Nothing goes to a terminal.** The child's stdout goes to a file, which is also what the
  answer is read from; its stderr is a file, so a chatty runtime cannot fill a pipe and
  deadlock the run. Every run writes to the same kind of sink, so no sample in a cell is
  measured under different conditions from the others.
- **One cell at a time, pinned.** Cells run in sequence, and each one is confined to a
  single logical CPU — CPU 3 by default, `start /affinity 8` — except task 11, which gets
  four. The mask is set on the harness process before the child starts and restored after,
  so the child is pinned from its first instruction instead of from whenever the scheduler
  was told. `--cpu N` moves the core and `--cpu -1` turns pinning off; `--cores N` changes
  what task 11 gets.

  The pin is only real if the Win32 calls are prototyped. `GetCurrentProcess` returns a
  pseudo-handle that does not survive ctypes' default `int` return type — it comes back as
  `-1`, `SetProcessAffinityMask` rejects it, and the call fails. That failure is invisible
  unless it is looked for: the run continues unpinned while the header still says which CPU
  it intended to use. The harness declares the prototypes, checks that the machine will
  accept the mask before the sweep starts, and records the CPUs each child actually ran on
  in every sample, so a silently unpinned run is a warning on stderr and `"cpus": null` in
  `results.json` rather than a plausible-looking number.
- **A tool this checkout keeps elsewhere still runs.** The registry records the path the
  row's verifier uses. If that file is not where the registry says, the harness looks for it
  under `tools/` and `exec/` by name and accepts only a single candidate that keeps the
  registered path's directory components — the wasmtime executable lives one directory
  deeper here than the verifier's constant, for instance. Anything ambiguous or absent is
  left alone and the cell is reported as skipped, never as failed.

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

Per cell: the timed runs the harness was told to take — one by default, `--runs N` for N — and the
median is reported alongside the minimum, maximum and standard deviation.

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
- **Absent toolchains.** `swipl`, `seed7` and `swift`, and
  also `ats`, `basic`, `beef`, `boo`, `cobol`, `dolphin`, `eiffel`, `babashka`,
  `modula2`, `modula3` and `qb64`, were all absent when their rows were instrumented, so their
  timing code was written by inspection first. Every one of those toolchains is installed here now
  and every one of those rows has been verified end to end (15/15 each), so no cell is
  inspection-only. ADW and CM3 both installed portably — an Inno Setup unpack and a prebuilt zip —
  with no admin rights.

## Expected cost

**The tasks were rescaled on 2026-10-16**, because the fastest rows finished most of them in
single-digit milliseconds and the fixed cost of starting a process was beginning to show through
the measurement. Each task's workload was raised so the fastest implementation takes roughly
200-300 ms, and the figures in this section that were measured before that date are scaled by
the task's own law — linear in the loop count for the loop tasks, quadratic for task 07 (it
copies the whole string) and for task 10 (it is a spigot), and linear in the pass count for
tasks 14 and 15. The per-task factors:

| Task | Was | Now | Factor |
|---|---|---|---|
| 02, 11 | 100,000,000 iterations | 108,000,000 | 1.08x |
| 03 | 100,000,000 calls | 400,000,000 | 4x |
| 04 | 1,000,000 elements, summed once | 10,000,000 elements, summed 12x | 120x |
| 05 | 10,000,000 allocations | 50,000,000 | 5x |
| 06 | 100,000,000 characters | 250,000,000 | 2.5x |
| 07 | 250,000 appends | 750,000 | 3x, and quadratic |
| 08 | 100,000,000 iterations | 200,000,000 | 2x |
| 10 | 1000 digits | 2000 | 4x, and quadratic |
| 12 | 1000x1000 matrices | 4000x4000 | 16x |
| 14 | one 50 MiB pass | 8 passes | 8x |
| 15 | one 50 MiB write | 8 passes | 8x |

Task 02 is the one that could not be raised as far as the rest: its checksum is quadratic in the
count and several rows hold it in a double, so 108,000,000 is the largest round count whose
answer stays below 2^53. See README's task 02.

Every task runs once by default (`--runs N` for N), in 105 rows of 210 toolchain entries.

- Fast compiled languages: under a second per run, so about **half an hour** for a default
  one-run pass over the whole matrix — 2621 cells at roughly 0.5 s each. Five runs over the
  same matrix is about 2.5 hours, before the slow cells below are counted.
- The 108-million-iteration tasks take 10 to 15 seconds in CPython.
- The new rows are mostly slow, and they hold the slowest cells in the matrix:
  - **Component Pascal** task 10 is a .NET assembly running the same bounds-checked spigot; at
    10000 digits it took about 5 minutes a run, so about **12 s** at 2000.
  - **Racket** task 07 is the quadratic append: Racket strings are
    immutable and `string-append` allocates and copies the whole string every time, so the 750000
    appends copy about 2.8x10^11 bytes. That is the quadratic cost the task is about, and it makes
    this one of the slowest cells in the matrix.
  - **Elixir** is the reverse: it is fast, and its per-run start-up (about 800 ms) is the main
    fixed cost, charged to every cell. `erlang` and `erlang-compiled` are the same shape, about
    520 ms, so the three BEAM rows all pay a start-up floor rather than a slow loop.
  - **Tcl** is slow per operation and, unlike the rows around it here, it is slow in *every*
    108-million-iteration task rather than in one cell: measured task 06 210.0 s, task 01
    201.3 s, task 03 185.8 s, task 08 185.5 s, task 02 165.7 s, task 13 155.6 s and task 09
    143.5 s, about 1.4-2.1 us per iteration through Tcl's bytecode. That shape — cost spread
    across the whole row instead of concentrated in one cell — is why Tcl is one of the
    slowest rows in the matrix. Task 07 is *not* slow
    (0.28 s): `append` extends a uniquely-referenced value in place, so those appends are
    amortised — see the task-07 note below. Everything else is small, except task 14's 288 s
    eight-pass read of the 50 MiB fixture and task 11's 8.5 s four-thread pass.
  - **VBScript** concentrates its cost instead: task 09 is 222.0 s, task 13 83.5 s, task 03
    80.3 s, task 10 74.8 s, task 06 38.4 s and task 14 about **368 s** (91 s measured at
    100 MiB, so about 46 s per 50 MiB pass, times the eight passes, at roughly 1.1 us per
    byte through the text-mode stream). Its task 10 is the slowest 2000-digit spigot cell in the matrix.
    Measured scaling at 100/200/400/800/1600 digits is 1.19 s, 3.24 s, 10.4 s, 46.1 s and
    205.5 s, an exponent of about 2.16 in the digit
    count, which puts the 2000-digit run at roughly **5.5 minutes**. The digit sums at those
    scales are 471, 897, 1753, 3588 and 7269, each matching an independently computed value.
  - **OCaml** task 10 is about **16 s** at 2000 digits (405 s measured at 10000, scaled
    quadratically): the hand-rolled int64 base-1e9 limbs, since the standard library has no
    bignum and `zarith` is not in MSYS2's UCRT64 repository.
  - **ActionScript** task 10 is about **11 s** at 2000 digits (268 s measured at 10000, scaled
    quadratically): the same bounds-checked spigot, running on the AVM2 JIT with
    double-precision limbs.
  - **Oberon-07** task 10 is about 40 s at 2000 digits, and **Cim** task 10 about 12 s.
  - **That batch of rows** is a mix. **OCaml bytecode** sits mid-pack: 5.3 s
    for task 01 and 17.5 s for task 10, against 0.4 s for the same file compiled natively.
    **R** and **Julia** were each a pair whose other half was fast — R without its byte-code
    compiler, and Julia under `--compile=min -O0` — and both halves were removed on request
    2026-10-16 for the same reason the too-slow rows above are not in the matrix: their cells
    were absurdly slow, far past the slowest cell any row keeps. R without its JIT took 362 s
    for task 01 against 82 s with the compiler on (3622 ns per iteration against 823, the
    4.4x the pair existed to show) and **1356 s** for task 09 — twice COBOL's task 09, the
    slowest cell the matrix accepts. Julia under `--compile=min -O0` took 438 s, 497 s and
    562 s for tasks 01, 02 and 09, and 942 s / 954 s for tasks 13 and 14, against about 20 ms
    and 2 s compiled. Both were also one compiler setting on the same fifteen sources, so
    nothing the matrix could read would have changed except the clock.
  - **Four rows from that batch** are interpreted, so they are slow on the 108-million-iteration
    tasks and fast elsewhere. Measured per task 01: **babashka 40 s**,
    **QuickJS 24 s**, **QB64 4.3 s**, and **flat assembler** 2.4 s (it is
    compiled, so it sits with the other assembly rows). babashka costs the most on the
    call-heavy tasks: task 09 is 331 million interpreted calls and
    measured **94 s**, and task 13 measured 106 s. **QB64 builds cost about 6-12 s each** on
    top of the run, since the compiler translates to C++ and shells out to a C++ compiler.
  - **Janet** task 07 is quadratic by design: Janet
    strings are immutable and `(string acc "x")` allocates a fresh buffer, copies the
    accumulator into it and then allocates the result string, so the 750000 appends copy about
    5.7x10^11 bytes — twice what Racket's one-copy version copies. Every other Janet cell is
    seconds (the slowest are task 09 at 24 s
    and task 13 at 16 s), so this is the row's slowest cell.
  - **Scheme** task 07 is the same quadratic append Racket's is: Chez strings are fixed-length and
    immutable, so the 750000 appends copy about 2.8x10^11 bytes.
  - **Prolog (SWI)** task 07 is quadratic for the same reason: SWI strings are immutable, the
    standard library has no string builder, and
    `string_concat/3` copies the whole string on every append.
  - **Haxe** task 07 is quadratic because a Haxe `String` is immutable and every iteration copies
    the whole thing, which makes it the row's slow cell.
    `StringBuf` was deliberately not used — on cpp it is an `Array<String>` with a join at
    `toString()`, i.e. linear, which would have measured a different program.
  - **Tcl, Unicon and ActionScript** are three more rows where task 07 is *not* slow.
    Tcl's `append` extends a uniquely-referenced
    value in place — measured 0.28 s, and linear in the append count (321 / 567 / 1179 ms at
    250000 / 500000 / 1000000) — while the spec's copy form `set text $text"x"` is the
    superlinear one and is 27x slower at the row's own loop count (8890 ms at 250000, 145548 ms
    at 500000), which is why the row keeps the idiomatic form and records the deviation.
    Unicon's `text := text || "x"` is linear too (47 / 94 / 172 ms at 250000 / 500000 /
    1000000, and still linear with the accumulator declared `global` or the append moved into
    a procedure), so its concatenation extends the accumulator in place rather than copying
    it. ActionScript's `text = text + "x"` is linear as well — 49 / 101 / 200 ms at 250000 /
    500000 / 1000000, an exact doubling per doubling — because the AVM2 extends the string in
    place when the value is unshared, where a real quadratic copy would move about 281 GB at
    the row's own loop count. All three rows keep the language's own spelling and record the
    deviation, the same way the Elixir and Lobster rows do.
  - The compiled rows (C3, Vala) are in the normal range, with C3's task 07 the outlier
    because appending to a string 750000 times is quadratic by design.
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
  - **TinyGo** is fast almost everywhere and pays for one cell: task 07 is **28959 ms**, where
    every other cell in the row is under 0.5 s. The append is quadratic by design, as it is in
    the other rows that pay for it, and TinyGo's `string` concatenation goes through its own
    runtime rather than Go's optimised `concatstrings`, so it is **2.6x slower than `gc` on that
    one cell** (11.1 s) while beating `gc` on twelve of the other fourteen. The gap runs the
    other way almost everywhere, because `gc` carries a much larger per-program floor: measured
    **58.2 ms against 741.5 ms** on task 13, **2.1 ms against 591.9 ms** on task 05,
    **30.7 ms against 423.2 ms** on task 15 and **40.3 ms against 239.3 ms** on task 02. TinyGo
    also loses tasks 08 (179.0 against 159.1 ms) and 10 (95.9 against 77.2 ms). A row pair this
    lopsided in both directions is the clearest case in the matrix of why one number cannot
    stand for a compiler.
- Measured slow cells elsewhere: Modula-3 task 10 at 206 s, Modula-2
  task 10 at 115 s.
- **The four C toolchains disagree by 4.2x on task 07**, which is the largest spread inside any
  single row, and it is worth knowing before the matrix is read as a language comparison.
  Measured on this host with the same unmodified source and the machine otherwise idle,
  unoptimised tcc is within 19% of gcc while fully optimised msvc is 4.2x slower. The loop is
  `realloc` plus `strcat` 750000 times, so it is bound by how the C
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
  11.6-54.8 s on the 108-million-iteration tasks (01 11.6 s, 02 19.7 s, 06 54.8 s, 09 18.9 s, 11 18.6 s),
  11-19 s on the matrix and file tasks, and its task 07 is the honest quadratic append,
  and the row's slow cell. **Lua** is much quicker: 2.5-8.4 s on the loops, 0.4-4.6 s on the rest.
  **CPython** measured 29-36 s on the four 108-million-iteration tasks
  (01 36.6 s, 02 35.7 s, 03 28.9 s, 08 27.0 s), 0.4-10.6 s elsewhere and
  **74.1 s** on task 13, which is its slow cell. `RUN.md` records the measurements.
- **Cython and GraalVM JIT** are cheap except where the task is quadratic.
  **Cython** costs what
  CPython costs to start — measured, its floor is the same as `python print(1)` on this host,
  90-200 ms — and its loops are **not uniformly faster**, because pure-mode Cython on untyped
  Python objects still does Python arithmetic. Measured against CPython on the same host:
  task 01 6.1-6.3 s against 8.2-8.3 s, task 02 5.8-6.5 s against 7.5-7.6 s and task 03
  4.5-5.2 s against 5.8-6.8 s — about **1.25-1.35x** — task 04, a builtin `sum`, identical at
  0.2-0.3 s, and task 13 *slower* at 17.6-20.0 s against 14.1-17.2 s. Its slow cell is task 07,
  the honest quadratic append. **GraalVM JIT**
  is the `openjdk` row's cost: every short cell is 0.2-0.5 s, and task 07 is the slow one.
- **Nothing is cut off, so a pass has no upper bound.** The compiled rows are all under a
  second per run, but one of the slow cells above can outweigh the entire rest of the matrix,
  and a default pass runs it once. Budget from the slowest cells, not from the average.

`WRONG` is a result, not a failure. So is `SKIPPED`, which is what a cell reports when the
toolchain is missing or the language cannot do the task at all.

## Platform limits

Some cells cannot be filled on some platforms. This is worth knowing up front rather than
discovering halfway through a run.

| Toolchain | Linux | macOS | Windows |
|---|---|---|---|
| tcc | yes | yes | yes (native win64 build) |
| icx (oneAPI) | yes | yes | yes, the intel/llvm nightly tarball; needs the MSVC environment for headers and the linker |
| clang, clang++ | yes | yes | yes, but needs MinGW headers or the MSVC SDK |
| swift | yes | yes | yes, via the burn-bundle extraction; needs MSVC to link |
| flang | yes | yes | yes, from MSYS2 `ucrt64`; the official LLVM Windows tarball has no `flang.exe` |
| luajit | source | source | source, builds in about 30 seconds with MinGW once `PREFIX` has no spaces |
| graalvm, graalpy | yes | yes | yes |
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
| tcl | yes | yes | yes (task 11 needs a distribution that bundles the `Thread` package; MSYS2's `ucrt64` one does) |
| unicon | untested | untested | yes, the 64-bit Windows installer unpacked with `innoextract`; **13.3 only** for task 11, because 13.2 ships without concurrent threads. Verified on Windows x64 only |
| c3 (c3c) | yes | yes | yes, but needs the MSVC SDK to link; `lld-link` has no MinGW mode |
| vala (valac) | yes | yes | yes, via MSYS2 `ucrt64` (about 2.2 GB of GLib dependency chain) |
| component pascal (gpcp) | no | no | yes, .NET only, so it needs the .NET runtime wherever it runs |
| oberon-07 (akron) | yes | no | yes, the repository ships a Windows `Compiler.exe`; on Linux the compiler has to be built from source with `make lin64` |
| vbscript (cscript) | no | no | yes, and only ever Windows: it is a Windows Script Host component with no port. It is also being **withdrawn by Microsoft** — a Feature on Demand in Windows 11 24H2, enabled by default at first, then disabled by default, then removed — so this row will eventually become `SKIPPED` on new installs. |
| actionscript (AIR) | no | yes | yes. The SDK's captive runtime — what `-target cmdline` bundles into a standalone app — ships for `win`, `win64` and `mac` only (`runtimes/air-captive/`), so a self-contained bundle is possible on Windows and macOS and **not** on Linux, which gets only the non-captive runtime. Verified on Windows; the macOS path is untested here. |
| scala (native) | untested | untested | yes, via the portable llvm-mingw zip (no MSVC, no admin); the documented route wants Visual Studio's C++ workload |
| beef | untested | untested | yes, Windows x64 only as verified here; Beef's Linux and macOS back ends were not exercised, and its installer is Windows-specific |
| haxe (hxcpp) | untested | untested | yes, the official win64 zip plus a 64-bit MinGW `g++`, verified on Windows only |
| eiffel (eiffelstudio) | untested | untested | yes, the win64 `.7z` unpacked in place; the delivery ships its own MinGW gcc, so no MSVC is needed. Verified on Windows only |
| erlang (escript, erlc) | yes | yes | yes, the official OTP Windows `.zip`; one tree serves the `erlang` and `erlang-compiled` rows |
| gleam | yes | yes | yes, the release zip, on the OTP tree the Erlang rows install |
| seed7 (s7c) | untested | untested | yes, built from the source release with MSYS2's MSVCRT MinGW gcc; the only prebuilt Windows artifact is an admin-requiring installer. Verified on Windows only |
| scheme (chez) | untested | untested | yes, built from the release tarball with MSYS2 UCRT64 MinGW gcc; `make install` has to be done by hand. Verified on Windows only |
| prolog (swipl) | untested | untested | yes, the official x64-win64 NSIS installer extracted with 7-Zip; the tree is self-locating. Verified on Windows only |
| janet | untested | untested | yes, the per-user Windows x64 MSI. Verified on Windows only |
| jscript (cscript) | no | no | yes, and only ever Windows: it is the same Windows Script Host component as the VBScript row and shares its deprecation path. On Windows 11 24H2 and later the engine is the replacement JScript9Legacy, which reports 11.0.16384 on this host. |
| standard ml (poly/ml) | untested | untested | yes, the `PolyML5.9.1-64bit.msi` administratively extracted, plus a MinGW `gcc` to link the exported object and build the two missing pieces the MSI omits. Verified on Windows x64 only. The MSI is the only Windows asset and v5.9.2 ships none, so the version is pinned at 5.9.1 there |
| terra | untested | untested | yes, the official `terra-Windows-x86_64-*.7z`; no admin and no MSVC, but the interpreter **requires a non-nil `VCINSTALLDIR`** or it aborts before running any file, and `INCLUDE` must point at a C sysroot for the one task that includes `windows.h`. Verified on Windows x64 only |
| nelua | untested | untested | yes, the git repository plus a C compiler and its own bundled Lua interpreter. No admin. Verified on Windows x64 only |
| python (cython) | yes | yes | yes, and the build flags are **not** portable: the row's `-DMS_WIN64` and `-municode` are MinGW-on-Windows requirements, and on Linux or macOS the same two steps are plain `cython --embed` plus a `gcc` that links the interpreter. Verified on Windows x64 only |
| java (graalvm jit) | yes | yes | yes, the same GraalVM tarball on all three |
| java (openj9) | yes | yes | yes, the Semeru zip ships Linux, macOS and Windows builds of the same layout. Verified on Windows x64 only |
| c/c++/rust/go/assemblyscript/webassembly/ruby/lua/python/zig (`wasmtime 46.0.3`) | yes, all ten | yes, all ten | yes, all ten. The runtime is a portable release zip; the only Windows-specific piece is the wasi-sdk tarball for the C and C++ rows, which ships `x86_64-windows` and `x86_64-linux` builds of the same thing. Task 11 is the version-sensitive cell on every platform: `wasi-threads` was deleted in wasmtime 47, so **46.0.3 or older is required** and the row cannot be run on a current runtime. Verified on Windows x64 only |
| the same ten modules under `wasmtime 46.0.3 -C compiler=winch` | yes, the seven compiled ones | yes | yes. The same binary as the Cranelift row — only the code generator changes. **Winch does not implement `wasm_exceptions`**, so the three interpreted rows (Python, Ruby, Lua) stay on Cranelift |
| the same modules under `wamr 2.4.5 (iwasm)` | yes, six | yes | yes. The one non-wasmtime runtime here that runs the `wasi-threads` task |
| the same modules under `node 22` (V8, via a WASI shim) | yes, seven | yes | yes. The shim is the repository's own `exec/wasi-run.js`, so it supplies what node's `WASI` does not: it reads the `env.memory` import's shared limits out of the module, creates the shared `WebAssembly.Memory` the `wasi-threads` ABI requires the *host* to own, answers `wasi.thread-spawn` with a `node:worker_threads` Worker sharing that memory, and enters `wasi_thread_start` in each worker. All seven rows answer 8748000081000000 through it. (A module that instead *defines* its memory cannot work: every runtime then fails inside `wasi_thread_start`, measured on wasmtime.) |
| `scala-js`, `clojurescript` (node) | yes | yes | yes, the same node binary |

**Windows reaches every row**; it is the only host that does. Linux loses `actionscript`
(no captive runtime), `dolphin smalltalk` (Windows-only VM), `vbscript` and `jscript`
(Windows Script Host components, and ones Microsoft is removing) and both `assembly` rows
(freestanding PE
programs built against `kernel32.dll`). Linux also
loses Tcl's task 11 unless the distribution bundles the `Thread` package. macOS loses
both `assembly` rows, `msvc` and `dolphin smalltalk`, which exists nowhere else, plus the
Windows-only scripting rows (`vbscript` and `jscript`), and the two rows whose
toolchain ships Windows-only
binaries: `oberon-07` (build the compiler with `make lin64` instead) and `component pascal`,
which is .NET-only by construction and has no non-Windows release. The newest rows were
all verified on Windows x64; where a material file did not exercise Linux or macOS, the table
says `untested` rather than guessing. Whichever host you pick,
run the whole matrix on it, because numbers are only comparable within a run.

### Cygwin-hosted toolchains: native or cross-compiled

Some toolchains only exist under Cygwin (ATS's own
requirements page says "Windows with Cygwin"; Cim is built there too). Those have a choice
of C backend, and the choice is worth recording per row
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
