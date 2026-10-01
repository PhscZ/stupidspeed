# Run requirements

What has to be installed to execute the built programs, and what the machine has to look
like for the numbers to mean anything. For compilers, see `BUILD.md`.

## Host

| | Requirement | Why |
|---|---|---|
| OS | x86-64, Linux, macOS or Windows | Every row is reachable on Windows and on Linux; macOS loses `msvc` and `dolphin smalltalk`. The one exception is `assembly`, which is Linux x86-64 only: it is a freestanding ELF64 binary built with `nasm -f elf64` and `ld`. `tcc`, `clang`, `flang` and `luajit` all need a little care on Windows but no WSL. |
| CPU | 4 physical cores | Task 11 runs four threads. Every other task is pinned to one core, so more cores do not help them. |
| RAM | 8 GB minimum, 16 GB comfortable | The tasks themselves are small: the largest allocation is task 06's 100 MB text, and task 12's three 1000x1000 arrays are 24 MB together. The 16 GB is for the JVM, GraalVM and Julia toolchains. `native-image` alone wants 2–4 GB to build. |
| Disk | 32 GB free | 100 MiB of fixtures, plus the toolchains themselves: `BUILD.md` measured 23 GB for all 78 installed and run, and the fourteen rows before the newest four add about 6.5 GB — Octave's tree alone is 2.6 GiB, Eiffel's 1.28 GB, Beef's 845 MB and the Scala Native row's 833 MB — and the four newest add about 1.3 GB, mostly Dyalog's 855 MB interpreter tree, so budget about 31 GB for all 96. The six WebAssembly rows add about **1.7 GB**: the wasi-sdk tree is 1.5 GiB, unpacked from a 591 MiB tarball that has to sit beside it while it extracts, the AssemblyScript package is 102 MiB and the wasmtime zip 44 MiB, and the hand-written row installs nothing at all. Budget about 33 GB for all 102. The MSYS2 tree that `valac` needs is 2.2 GB of the base total on its own, with another 2–3 GB of scratch while reassembling MSVC and Swift. |
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
| D | dmd, ldc2 | libphobos | or build with `-static` |
| Swift | swiftc | Swift runtime libraries | unless statically linked |
| Fortran | gfortran | libgfortran | |
| Fortran | flang | Fortran runtime | |
| Ada | gnat | libgnat | |
| Pascal | fpc | none | static by default |
| Nim | nim | none | static by default |
| Odin | odin | none | |
| Assembly | x86-64 nasm | none | |
| Dolphin Smalltalk | Dolphin 8 | MSVC x86 runtime (`vcruntime140.dll` + `msvcp140.dll`) | the VM is 32-bit, so it needs the x86 runtime, not the x64 one |
| Groovy | groovy | JRE 17 or newer | the distribution ships its own `groovy.bat` launcher |
| Tcl | tclsh | none | task 11 also needs the `Thread` extension, see `BUILD.md` |
| Java | openjdk | JRE 17 or newer | |
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
| JavaScript | node, bun, deno | the runtime itself | |
| PHP | zend | PHP + opcache | task 11 needs the `parallel` PECL extension, which stock PHP does not ship and which requires a ZTS build. |
| PHP | zend + jit | PHP + opcache | JIT needs `opcache.enable_cli=1`. The stock Windows zip ships no `php.ini`, so JIT is off until you write one and set `opcache.jit_buffer_size`. Same `parallel` requirement as the row above for task 11. |
| Python | cpython, pypy, graalpy | the interpreter | |
| Python | nuitka | none | standalone binary |
| Ruby | cruby + yjit | Ruby | **the stock Windows build has no YJIT**: `ruby --yjit` warns "Ruby was built without YJIT support". The `cruby + yjit` row needs a Ruby built with rustc present. |
| Ruby | jruby | JRE + JRuby | needs Java 25 |
| Lua | puc-lua, luajit | the interpreter | task 11 also needs the Lanes extension, see below. No `luarocks` ships with the Windows binaries, so Lanes has to be built by hand. |
| Perl | perl | Perl | |
| R | gnu-r | R | task 11 uses the bundled `parallel` package, PSOCK mode |
| Julia | julia | Julia | about 1 GB with the standard library. Task 11 must run as `julia -t4 <task>.jl`, or `Threads.@threads` stays on one thread. |
| GDScript | godot --headless | Godot binary | roughly a second of startup on its own |
| PowerShell | powershell, pwsh | .NET runtime | **not a shell in the usual sense.** See below. |
| Crystal | crystal | none | static by default; needs the MSVC toolchain to link |
| Objective-C | clang | `libobjc-4.6.dll` + `gnustep-base-1_31.dll` + UCRT | the GNUstep runtime ships with the MSYS2 `ucrt64` packages |
| Modula-2 | adw | none | static by default |
| Modula-3 | cm3 | none | static by default |
| COBOL | gnucobol | `libcob-4.dll` + UCRT | from MSYS2 `ucrt64` |
| BASIC | freebasic | none | static by default |
| V | v | none | static by default; needs a C compiler to build |
| ATS | ats | none | static by default; needs a C compiler to build |
| C3 | c3c | none | static by default; needs the MSVC SDK to link |
| Vala | valac | `libglib-2.0-0.dll` (and `libgobject-2.0-0.dll` for task 10) for the tasks that call GLib | from MSYS2 `ucrt64`; the tasks that call no GLib function link nothing extra and run with a bare system `PATH`. Static linking fails, so the DLLs have to be reachable. |
| Simula | cim | Cygwin runtime (`cygwin1.dll`) | `cim.exe` is a Cygwin program that drives `gcc`; the built program itself is a normal Windows binary with no dependency |
| Oberon-07 | akron | none | static by default; the compiler's `Compiler.exe` is a standalone Windows binary |
| Component Pascal | gpcp | .NET 8 runtime | the compiler produces a .NET assembly, not a native binary, and every executable needs `RTS.dll` beside it — plus `RealStr.dll` for task 08 and `GPFiles.dll` + `GPBinFiles.dll` for tasks 14 and 15. Those DLLs are **not** found on `PATH`. |
| Algol 68 | a68g | Cygwin runtime (`cygwin1.dll`) | compiler-interpreter, so the "build" and the "run" are the same command; task 06 needs `--heap 1900000000` (a CHAR is 16 bytes here), and the parallel clause needs the Cygwin build, see `BUILD.md` |
| ActionScript | AIR | none — the runtime is bundled | `adt -target cmdline` puts a captive AIR runtime beside the executable, so the bundle is self-contained and needs no separate install. The bundle is a directory, not a single file: `prog.exe`, `prog.swf`, `Adobe AIR\`, `META-INF\` and `mimetype` all have to stay together. Two things about it are unusual and are covered below: it prints a startup banner, and it has no working-directory API. |
| Clojure | clojure.main | a JRE (17 or newer; Clojure supports 8 through 25) plus the three runtime jars | No build step and no installer. The three jars are the whole toolchain; `clojure.main` compiles the source as it runs. Set `JAVA_HOME` per row rather than relying on whatever `java` is first on `PATH`. |
| Racket | racket (CS) | none — the installation tree is the runtime | Relocatable, but it has to move as a unit: the DLL and `collects` paths are embedded in the executables relative to the executable's own location. `Racket.exe` is the console program; task 11 uses `racket/place`, which is in `base` and therefore present even in Minimal Racket. |
| OCaml | ocamlopt | none — native static binary | The MSYS2 UCRT64 build needs the UCRT64 DLLs on `PATH` at run time, and building needs `OCAMLLIB` set to the Windows form of the stdlib path plus the `flexdll` package; see `BUILD.md`. |
| Raku | rakudo (MoarVM) | the extracted Rakudo tree | No build step. The MSI installs per-machine by default, so extract it with `msiexec /a` for a no-admin row. |
| Erlang | OTP (escript) | the extracted OTP tree | No build step. `escript` compiles the script on each run. Run with `-smp enable` so all schedulers are live. |
| SystemVerilog | iverilog | the vvp runtime, which ships with iverilog | Two commands, not one: `iverilog -g2012 -o prog.vvp <task>.sv` then `vvp prog.vvp`. The measured run is the `vvp` one. |
| Elixir | elixir (BEAM) | Erlang's tree plus Elixir's | No build step. Elixir needs Erlang on `PATH` first; `elixir` then compiles the script each run. |
| VBScript | cscript | none — `cscript.exe` ships with Windows | The runtime is a Windows component rather than something you install, which is also why the row is on borrowed time: see the platform table below. |
| Common Lisp | sbcl | none — the dumped executable embeds the core | The build dumps a standalone `prog.exe` with `save-lisp-and-die`, so nothing has to be on `PATH` at run time. Task 11 uses `sb-thread`, which is a required part of the Windows build. |
| C, C++, Rust, Go, AssemblyScript, WebAssembly (all six wasm rows) | wasmtime 46.0.3 | the `wasmtime.exe` from the release zip under `tools/wasmtime46/` | `wasmtime run prog.wasm`. Tasks 14 and 15 add `--dir=.` from a directory holding `data.bin`; Go's two cells need `--dir=<host>::/` instead, because Go opens its preopens by the WASI name and expects `/`. Task 11 adds `-S threads=y -W threads=y -W shared-memory=y` and **needs 46**, because `wasi-threads` was deleted in 47. Startup is part of every cell: measured, a no-op module costs 44 ms against 30 ms for a native executable and 31 ms for `wasmtime-min`. |
| Scala | native | none | Standalone `.exe`. The link is static, so not even llvm-mingw's `libc++.dll` is needed; without `--native-linking=-static` the executable dies with `STATUS_DLL_NOT_FOUND` when llvm-mingw's `bin` is off the DLL search path. |
| Beef | BeefBuild | none — static native binary | A Release build links the Beef runtime statically. The executable imports only `kernel32.dll`, `msvcrt.dll`, `user32.dll`, `SHELL32.dll`, `ole32.dll`, `gdi32.dll`, `version.dll` and `comdlg32.dll`; no Beef DLL has to be present. Process start-up is about 110–190 ms, which is a third of the row's slowest cell. |
| Haxe | hxcpp | none — native static binary | `-D no_shared_libs` links gcc, libstdc++ and libwinpthread statically; `objdump -p` on the produced executable lists only `KERNEL32.dll`, `USER32.dll`, `WS2_32.dll` and the `api-ms-win-crt-*` UCRT imports. Without that define hxcpp copies `libgcc_s_seh-1.dll`, `libstdc++-6.dll` and `libwinpthread-1.dll` beside the executable. |
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
| VHDL | ghdl | none — the extracted tree is the runtime | Two commands, not one: `ghdl -a --std=08 <task>.vhd` then `ghdl -r --std=08 <unit>`. The measured run is the `ghdl -r` one, which with mcode also elaborates and generates code. Tasks 14 and 15 run from `sources/vhdl/` so that `data.bin`/`out.bin` resolve. |
| Standard ML | Poly/ML | `PolyLib.dll` must be beside the executable | No build step at run time: the `.obj` the compiler exports contains the whole heap image, and the stub's `WinMain` loads it. Without `PolyLib.dll` next to the `.exe` the program dies before `main` with `STATUS_DLL_NOT_FOUND` and prints nothing. An exported program has no banner and no prompt — the top-level loop never starts — so the row's stdout is exactly the one expected line. Start-up floor about 65 ms. Tasks 14 and 15 run from `sources/standardml/` so that `data.bin`/`out.bin` resolve; task 14 reads in 65536-byte chunks. |
| Terra | terra | none, but the interpreter needs `VCINSTALLDIR` set and `INCLUDE` pointing at a C sysroot | No build step: `terra.exe <task>.t` compiles and JITs on every run, so that compile is inside the measured number, and an empty program still costs 36-50 ms. **`VCINSTALLDIR` must be non-nil or the interpreter aborts before opening the file** with `Can't find windows SDK version 8.1 or 10!` — it is a switch, the path is never read. `INCLUDE` is needed only by task 11, which includes `windows.h`; on this host it points at `tools/llvm-mingw/include`. Nothing is linked, so no MSVC and no Windows SDK are required. Task 15 syncs through `_commit`, so this row is not in the flush-and-close group. Tasks 14 and 15 run from `sources/terra/` so that `data.bin`/`out.bin` resolve. |
| Dyalog APL | dyalog | the extracted interpreter tree | No build step: `dyascript.exe -script <task>.dyalog`, run from `sources/dyalog/`. **`dyascript.exe` is the console build**; `dyalog.exe`, `dyalogrt.exe` and `dyaedit.exe` are GUI-subsystem programs whose output never reaches a console. `-script` is mandatory — without it the interpreter starts a Session instead of running the file. `⎕IO←0` and `⎕PP←17` are required in every source: the default `⎕PP` of 10 prints task 02's total as `7.500000075E15`, which is `WRONG`. Runs unregistered, with nothing on stdout or stderr at start-up; the `UNREGISTERED` banner is interactive-mode-only and goes to stderr. Start-up floor about 0.2-0.25 s. Task 03 loads `AddOne.dyalog` with `2 ⎕FIX`; tasks 14 and 15 use the working directory for `data.bin`/`out.bin`. |
| Nelua | nelua | none — native static binary | The compiled executable is self-contained and needs nothing at run time; only the compile needs the toolchain tree and a C compiler. `nelua.bat` has to be invoked through `cmd.exe`, and the build must run from `sources/nelua/` because `require` resolves against the working directory. Task 03's helper is a second module with `<noinline>`. Task 15 syncs through `_commit`, so this row is not in the flush-and-close group either. Tasks 14 and 15 run from `sources/nelua/` so that `data.bin`/`out.bin` resolve. |

### JVM versions are not interchangeable

Six rows need a JVM, and four of them disagree about which one:

- `jruby` needs **Java 25**; on Java 24 and older it dies with `UnsupportedClassVersionError`.
- `kotlin/native` needs **Java 17**. Its launcher mis-parses JDK 24's version string and fails with a batch syntax error.
- `scala` needs anything modern. Oracle's `java8path` shim, if it is ahead of the real JDK on `PATH`, makes `scalac` fail on class file version 61.0.
- `graalvm native-image` is its own JDK 25.

Set `JAVA_HOME` per row rather than relying on whatever `java` resolves to. On a machine with
several JDKs installed, the default `PATH` order is usually the wrong one for at least two of
these four.

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
portable at all: Assembly can only do it on Linux. This is what each language actually has,
verified by running the task or by reading the official documentation.

### Real OS threads, no problem

C, C++, Rust, Zig, Go, D, Swift, Ada, Pascal, Java, Kotlin (both rows), C#, F#, VB.NET,
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
Assembly (raw `clone` + `futex` syscalls, no libc),
Standard ML (Poly/ML's `Thread.Thread.fork`, whose Windows arm is literally `CreateThread` in
`libpolyml/processes.cpp`; measured **3.30x** on four workers, with `Thread.Mutex` +
`Thread.ConditionVar` for the join — note the nesting, the functions live in `Thread.Thread`,
not `Thread`),
Terra (`CreateThread` through `terralib.includec("windows.h")`; measured **3.72x** with four
distinct thread ids and a process CPU/wall ratio of 4.75),
Nelua (`require 'C.threads'`, the standard library's C11 binding over `CreateThread`, with the
GC's `nogc` pragma because a collected allocator shared across raw threads is not safe; measured
**3.5x**).

**The five WebAssembly rows that pass** are one mechanism, and it is a third kind: C, C++, Rust,
AssemblyScript and the hand-written WAT row all reach the host's thread API through
`wasi-threads` — the module imports `wasi::thread-spawn`, exports `wasi_thread_start`, and the
runtime creates the OS thread, hands it the module's shared memory, and calls the export on it.
The four quarters are real OS threads on real cores; the hand-written row measured **2.66x** on
four workers (0.142 s against task 02's 0.379 s, both 100000000 iterations). It is neither a
language facility nor a foreign declaration of the OS's own calls, so it sits between the two
kinds already described. It is also the only task-11 mechanism in the matrix that depends on the
runtime's **version**: `wasi-threads` was deleted in wasmtime 47, so every one of these cells
needs wasmtime 46.0.3 or older and cannot be run on a current runtime at all. Go is the exception
among the six and is described under the no-speedup group below, because Go's wasip1 port has no
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
| VHDL | four `process` blocks, each owning a fixed quarter of task 02's range, plus a fifth collector process that waits for all four (`wait until done = "1111"`) and sums the partials | `7500000075000000`, **2422 s** against task 02's 2430 s — 1.003x, i.e. noise, so a correct-answer-no-speedup cell |
| Dyalog APL | `f&Y`, the language's own spawn operator, with `⎕TSYNC` as the join. `⎕TID` is 0 on the master and `1 2 3 4` in the four workers, and `⎕TNUMS` reports `0 4 3 2 1`, so four threads really are created. | `7500000075000000`, **0.99 CPU per wall second** (124.05 s CPU in 125.24 s wall, measured with `GetProcessTimes` over all threads), and four 5 M-iteration workers take 4.12x the time of one — exactly serial. The threaded form is *slower* than the identical serial work (86.2 s against 73.8 s), because the spawn and `⎕TSYNC` bookkeeping is pure overhead. |

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
| Ruby (CRuby) | threads exist but the GVL serializes them | correct, no speedup |
| Simula | `SIMULATION`/`PROCESS`, the language's own process simulation: cooperative and green | `7500000075000000`, **1.9x slower** than task 02 |
| ActionScript | AIR `Worker`: separate AVM2 instances, no shared memory, results via shared properties | `7500000075000000`, **2.91x on 4 workers** |
| VBScript | four `WScript.Shell.Exec` child processes, one per quarter, partials read back from each child's stdout | `7500000075000000`, **3.41x on 4 processes** |
| SystemVerilog | `fork`/`join` with four tasks, each owning a fixed quarter. The processes are scheduled by the simulator on one thread, so this is correct-answer-no-speedup. | `7500000075000000`, no speedup |
| Racket | `(thread thunk #:pool 'own #:keep 'results)`: each thread gets its own OS thread with the heap shared, and `thread-wait` returns the result. Plain `thread` is green and `future` serialises at blocking operations, so neither is used. | `7500000075000000`, real multicore work |
| Janet | `ev/spawn-thread`/`ev/thread` + `ev/thread-chan`: one OS thread per worker, each with its own heap, partials sent back over a threaded channel (the isolates shape Dart and JavaScript use) | `7500000075000000`, **4.9x on 4 threads** |
| Octave | four `octave-cli` child processes of the same file, one per quarter, started with `popen` and joined by reading each child's stdout; the worker index travels in the environment | `7500000075000000`, **3.13x on 4 processes** |
| Seed7 | four `startPipe` child processes of the same executable, one per quarter, partials read back from each child's stdout with `getln(childStdOut(p))` and joined with `waitFor` | `7500000075000000`, real parallelism across four cores |
| JScript | four `WScript.Shell.Exec` child processes, one per quarter, partials read back from each child's stdout | `7500000075000000`, real parallelism on four cores, but not a clean 4x over task 02 — see below |
| AutoHotkey | four `WScript.Shell.Exec` child processes of the same script, one per quarter, each printing its partial sum to stdout; the parent reads each child's `StdOut`, which blocks until that child exits and is therefore the join | `7500000075000000`, real parallelism across four cores; see the note below |

### The nine that need explaining

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

**Assembly.** A freestanding ELF64 binary has no libc, so there is no `pthread_create` to
call and no thread library to link. The task is still four threads: `11_parallel_sum.asm`
issues `clone` with the flag set `pthread_create` uses (`CLONE_VM | CLONE_FS | CLONE_FILES |
CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM`) on four 64 KiB stacks in `.bss`, and joins the
workers with `futex`, which is what `pthread_join` does underneath. Each worker is task 02's
jump-table switch over a fixed range of 25000000 iterations, so the four together print the
same number as task 02. It passes, and it is Linux x86-64 only, like the rest of that row.

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

**VHDL.** VHDL's processes are the language's own concurrency construct — a process is a
concurrent statement and the simulation cycle is defined to execute the resumed processes in
an arbitrary order — so task 11 is expressed in-language exactly as SystemVerilog's
`fork`/`join` expresses it. But every shipped GHDL build schedules those processes on **one OS
thread**: `src/grt/grt-threads.ads` is `package Grt.Threads renames Grt.Unithread`,
`grt-unithread.adb` is the "mono-thread version" whose `Run_Parallel (Subprg)` just calls
`Subprg.all` on the calling thread, and `grt-processes.adb` takes the sequential loop over
resumed processes when `Nbr_Threads = 1`, its own comment saying "there is no real locks,
since the kernel is single threading". `--threads=N` is parsed but dead: its help line is
commented out, GHDL's author calls it "dead code of an aborted effort", and the pthread
process-parallel kernel sits behind a commented-out `GRT_USE_PTHREADS=y` build switch that is
pthread (Unix) only, so no Windows build has it. The run line therefore does not pass
`--threads`, which would look like an attempted speedup and does nothing. Measured: task 11 at
2422 s against task 02's 2430 s — 1.003x, i.e. noise, both doing the same 100000000 iterations
of the same switch. The answer is right and the row is single-core for this task, like Simula,
CPython, CRuby and SystemVerilog's `fork`/`join`.

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
Oberon-07 and Component Pascal each have a route to real threads, and Simula turned out not to
need one, because its process simulation is part of the language's own standard application
package. Four other rows genuinely could not do it and are no longer in the benchmark at all —
AWK, Squirrel, Oberon-2 and BCPL. The group stays documented because it is where a language with
no concurrency at all would land.

### What this means for the wording

Task 11 says "start 4 threads". Under that wording:

- Pass: assembly (`clone` + `futex`), Oberon-07 (`CreateThread`), and everything in the
  threads list above.
- Pass, but with processes rather than threads: R, COBOL on Linux (`CBL_GC_FORK`), VBScript
  (`WScript.Shell.Exec` children), Octave (four `octave-cli` children via `popen`), Seed7
  (four `startPipe` children), JScript and AutoHotkey (both four `WScript.Shell.Exec` children
  of the same script), and JavaScript if you count worker threads as not being threads.
  ActionScript belongs here too:
  AIR `Worker`s run on real OS threads but are separate AVM2 instances with no shared memory,
  so they are isolates rather than threads in the same sense Dart's are.
- Pass, with the GIL/GVL caveat recorded: CPython, CRuby, Dolphin Smalltalk, whose `Process`
  objects are green and multiplexed onto one OS thread, and Simula, whose four `PROCESS`
  objects are scheduled cooperatively by its own process simulation. `jruby` and Groovy are
  unaffected and use real JVM threads. Algol 68 belongs in this group for a different reason —
  its four pthreads are real and overlap, but the implementation's stack copying costs more
  than the parallelism returns, so it is a correct-answer-no-speedup cell too. VHDL is here for
  the third reason: its four `process` blocks are the language's own concurrency, but every
  shipped GHDL build schedules them on one OS thread, so it is a correct-answer-no-speedup cell.
  Dyalog APL is here for the fourth: `&` creates four threads that `⎕TID` can name, but the
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
Prolog (SWI), Octave, J, Janet, Ring, JScript and VHDL note.

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
  Generate once; every language reads the same bytes. There is no generator script in this
  repository, so write one: 204800 copies of the 256-byte cycle.
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
to run. That is why the loop counts are in the hundreds of millions: at a million
iterations, the loop is smaller than the noise in starting the process.

## Expected cost

Every task runs six times, in 102 toolchains.

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
  - **Racket** task 07 takes about **19 minutes** a run (1121 s measured): Racket strings are
    immutable and `string-append` allocates and copies the whole string every time, so a million
    appends copy about 5x10^11 bytes. That is the quadratic cost the task is about, and it makes
    this one of the slowest cells in the matrix.
  - **Raku** is slow per operation: `given`/`when` costs about 5.7 us per iteration against
    0.47 us for the equivalent `if`/`elsif` chain, because `when` smartmatches. The row keeps
    `given`/`when` in task 02, since that is Raku's own switch, and takes the ~10 minute run.
    Task 06's per-character `substr` scan is the other slow cell.
  - **Erlang and Elixir** are the reverse: both are fast, and their per-run start-up (about
    520 ms for Erlang, 800 ms for Elixir) is the main fixed cost, charged to every cell.
  - **SystemVerilog** is an interpreter over an event queue, at about **5 us per loop
    iteration**: its 100-million-iteration tasks (01, 02, 03, 06) take 13 to 22 minutes each,
    task 15 is 52 million single-byte `$fwrite` calls, and task 10 is the slowest cell in the
    row at **38.8 minutes** (2330 s measured; scaling 100 digits 3.8 s, 200 16.2 s, 1000 538 s,
    an exponent of about 2.2 in the digit count).
  - **VBScript** is the slowest row overall. Task 07 takes about **9.6 minutes** (576 s
    measured) and task 14 about **46 s** (91 s measured at 100 MiB, so about 46 s at 50
    MiB, at roughly 1.1 us per byte through the text-mode stream), task 06 about 35 s. Task 10
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
    2.5 minutes and its task 11 about the same, its task 07 about an hour and its task 14 about
    about 1.75 minutes, and **Cim** task 10 about 3 s.
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
  - **Janet** task 07 takes about **38 minutes** a run (2266.6 s measured, one full run): Janet
    strings are immutable and `(string acc "x")` allocates a fresh buffer, copies the
    accumulator into it and then allocates the result string, so a million appends copy about
    10^12 bytes — twice what Racket's one-copy version copies, and the measured 2266 s is about
    twice Racket's 1121 s. Every other Janet cell is seconds (the slowest are task 09 at 24 s
    and task 13 at 16 s), so this is the row's slowest cell.
  - **Scheme** task 07 is the same quadratic append Racket's is: Chez strings are fixed-length and
    immutable, so the million appends copy about 5x10^11 bytes and the run takes about **25
    minutes** (1477 s measured; two further full runs gave 1780 s and 3841 s under contention).
  - **Prolog (SWI)** task 07 is quadratic for the same reason and measures **1405 s (23
    minutes)**: SWI strings are immutable, the standard library has no string builder, and
    `string_concat/3` copies the whole string on every append.
  - **Ring** task 07 uses the spec's `text = text + "x"` form and is honestly quadratic: `+`
    appends into a copy of the left operand and the assignment copies the result back, so the
    million appends cost about **219 s of user CPU** (857 s wall measured, on a host with under
    1 GB of free memory). Ring's own `+=` appends in place and was deliberately not used.
  - **VHDL** is dominated by its 64-bit accumulator, not by any one task: under mcode a 64-bit
    vector add costs about **17 us** against about **9 ns** for a 32-bit `integer` add, so tasks
    02 and 11 take about **40 minutes each** (2430 s and 2422 s) and task 07 about **42 minutes**
    (2517 s), while task 01's identical loop count with four 32-bit counters takes 1.2 s — a
    factor of about 2000 for the same work. Task 10 is not a slow cell here: **2.7 s** at 1000
    digits, because the spigot's limb count stays small.
  - **Octave** is a tree-walking interpreter with no JIT, so its 100-million-iteration cells are
    minutes each: task 01 479 s, 02 666 s, 03 962 s, 05 289 s, 06 490 s, 08 461 s, 09 1408 s
    (fib(40)), 11 213 s, 13 890 s and 14 360 s. One pass of the whole row is about 1.8 hours, so
    six runs per cell is roughly **11 hours**.
  - **Haxe** task 07 is quadratic because a Haxe `String` is immutable and every iteration copies
    the whole thing: measured at **420 s and 504 s** on two full runs, the row's slow cell.
    `StringBuf` was deliberately not used — on cpp it is an `Array<String>` with a join at
    `toString()`, i.e. linear, which would have measured a different program.
  - **AutoHotkey** task 09 is about **4.2 minutes** (249.1 s for ~331 million interpreted calls)
    and task 10 about 1.2 minutes (73.4 s at 1000 digits); its four 100-million-iteration loops
    are 30 to 50 seconds each. Task 07 is *not* slow and that is the point: the expression
    compiler gives `text .= "x"` an in-place path, so the million appends take 1.8 s.
  - The compiled rows (C3, Vala) are in the normal range, with C3's task 07 the outlier at
    about 2.5 minutes because appending to a string a million times is quadratic by design.
  - **Standard ML** is a fast row with one slow cell, like the other native compilers: every cell
    except task 07 is under a second, and task 07 is **95-96 s** because `^` copies the whole
    string per append. Its start-up floor is 65 ms, and `PolyLib.dll` has to be beside the
    executable or the program prints nothing at all.
  - **Terra** is fast except for task 07, which is the same quadratic copy in Lua strings at
    **176-454 s** — the spread is this host, not the row, since the cell copies 465 GiB and the
    machine is memory-bandwidth-bound — and except for task 11, whose ~1.3 s is almost all
    `includec("windows.h")`, the only C header any task in that row includes. Everything else is
    0.07-0.5 s. The start-up floor is 36-50 ms.
  - **Nelua** is a native row with no VM: every cell is milliseconds except task 07 at **68-89 s**
    (quadratic by design) and task 05 at about 0.5 s. Its start-up floor is 13-17 ms, the same as
    an empty C program compiled by the same gcc.
  - **Dyalog APL** is the slowest of the four by a wide margin, and its cost is spread evenly
    rather than concentrated in one cell: the 100-million-iteration tasks are **59-126 s** each
    (02 is 122.7 s, 09 126.4 s, 11 125.2 s), task 13 is 175.9 s and task 10, the hand-rolled
    1000-digit spigot, is 100.3 s. Its start-up floor is 0.2-0.25 s. Task 07 is *not* slow here —
    375 ms for the million appends, because `,←` grows in place.
- Measured slow cells elsewhere: Java task 07 at 514 s, Modula-3 task 10 at 206 s, Modula-2
  task 10 at 115 s.
- **The six WebAssembly rows** are the cheapest of the recent additions except for one cell each.
  Task 07 is quadratic in AssemblyScript and in the hand-written row, because the append copies
  the whole string: measured **484.6 s** and **623.8 s** a run, which puts them between
  VBScript's 576 s and Racket's 1121 s, and one pass of either cell is about an hour. Everything
  else in those two rows is under two seconds, and the other four rows are compiled code whose
  cells are in the normal range. Every one of the six pays the runtime's module load and compile
  on every run, measured at **44 ms** for a no-op module against 30 ms for a native executable
  and 31 ms for `wasmtime-min`.
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
| assembly | yes | no | no (freestanding ELF64, `nasm -f elf64` + `ld`) |
| dolphin smalltalk | no | no | yes (Windows-only VM) |
| groovy | yes | yes | yes |
| tcl | yes | yes | yes (task 11 needs a distribution that bundles the `Thread` package) |
| c3 (c3c) | yes | yes | yes, but needs the MSVC SDK to link; `lld-link` has no MinGW mode |
| vala (valac) | yes | yes | yes, via MSYS2 `ucrt64` (about 2.2 GB of GLib dependency chain) |
| simula (cim) | yes | yes | yes, source build under Cygwin |
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
| vhdl (ghdl) | untested | untested | yes, the standalone `ghdl-mcode-6.0.0-ucrt64.zip`; no MSYS2 needed. Verified on Windows only |
| standard ml (poly/ml) | untested | untested | yes, the `PolyML5.9.1-64bit.msi` administratively extracted, plus a MinGW `gcc` to link the exported object and build the two missing pieces the MSI omits. Verified on Windows x64 only. The MSI is the only Windows asset and v5.9.2 ships none, so the version is pinned at 5.9.1 there |
| terra | untested | untested | yes, the official `terra-Windows-x86_64-*.7z`; no admin and no MSVC, but the interpreter **requires a non-nil `VCINSTALLDIR`** or it aborts before running any file, and `INCLUDE` must point at a C sysroot for the one task that includes `windows.h`. Verified on Windows x64 only |
| dyalog | untested | untested | yes, the 20.0 Unicode Windows distribution administratively extracted. Runs unregistered with nothing on stdout. Verified on Windows x64 only; the download page's other platforms get `.deb`/`.rpm` and a macOS `.pkg`, none of which were exercised here |
| nelua | untested | untested | yes, the git repository plus a C compiler and its own bundled Lua interpreter. No admin. Verified on Windows x64 only |
| c/c++/rust/go/assemblyscript/webassembly (`wasmtime 46.0.3`) | yes, all six | yes, all six | yes, all six. The runtime is a portable release zip; the only Windows-specific piece is the wasi-sdk tarball for the C and C++ rows, which ships `x86_64-windows` and `x86_64-linux` builds of the same thing. Task 11 is the version-sensitive cell on every platform: `wasi-threads` was deleted in wasmtime 47, so **46.0.3 or older is required** and the row cannot be run on a current runtime. Verified on Windows x64 only |

**Windows reaches every row**; it is the only host that does. Linux loses `actionscript`
(no captive runtime), `dolphin smalltalk` (Windows-only VM), `vbscript` and `jscript`
(Windows Script Host components, and ones Microsoft is removing) and `autohotkey` (the
official project builds only Windows targets). Windows loses `assembly`, and
loses Tcl's task 11 unless the distribution bundles the `Thread` package. macOS loses
`assembly`, `msvc` and `dolphin smalltalk`, which exists nowhere else, plus the Windows
PowerShell 5.1 row (use `pwsh` there), the Windows-only scripting rows (`vbscript`, `jscript`
and `autohotkey`), and the two rows whose toolchain ships Windows-only
binaries: `oberon-07` (build the compiler with `make lin64` instead) and `component pascal`,
which is .NET-only by construction and has no non-Windows release. The eighteen newest rows were
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
