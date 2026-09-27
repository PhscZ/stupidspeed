# Run requirements

What has to be installed to execute the built programs, and what the machine has to look
like for the numbers to mean anything. For compilers, see `BUILD.md`.

## Host

| | Requirement | Why |
|---|---|---|
| OS | x86-64, Linux, macOS or Windows | Every row is reachable on Windows and on Linux; macOS loses `msvc` and `dolphin smalltalk`. The one exception is `assembly`, which is Linux x86-64 only: it is a freestanding ELF64 binary built with `nasm -f elf64` and `ld`. `tcc`, `clang`, `flang` and `luajit` all need a little care on Windows but no WSL. |
| CPU | 4 physical cores | Task 11 runs four threads. Every other task is pinned to one core, so more cores do not help them. |
| RAM | 8 GB minimum, 16 GB comfortable | The tasks themselves are small: the largest allocation is task 06's 100 MB text, and task 12's three 1000x1000 arrays are 24 MB together. The 16 GB is for the JVM, GraalVM and Julia toolchains. `native-image` alone wants 2–4 GB to build. |
| Disk | 25 GB free | 180 MiB of fixtures, plus the toolchains themselves: `BUILD.md` measured 23 GB for all 74 installed and run, of which the MSYS2 tree that `valac` needs is 2.2 GB on its own, with another 2–3 GB of scratch while reassembling MSVC and Swift. |
| Filesystem | `tmpfs` or RAM disk preferred for the file tasks | Reading 90 MiB from a spinning disk measures the disk. Anything run under WSL2 measures the WSL disk layer instead. Where the fixture lives must be recorded in the results. |

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
| Elixir | elixir (BEAM) | Erlang's tree plus Elixir's | No build step. Elixir needs Erlang on `PATH` first; `elixir` then compiles the script each run. |
| VBScript | cscript | none — `cscript.exe` ships with Windows | The runtime is a Windows component rather than something you install, which is also why the row is on borrowed time: see the platform table below. |
| Common Lisp | sbcl | none — the dumped executable embeds the core | The build dumps a standalone `prog.exe` with `save-lisp-and-die`, so nothing has to be on `PATH` at run time. Task 11 uses `sb-thread`, which is a required part of the Windows build. |

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
Scala, Nim, Odin, Julia (`-t4`), Fortran (OpenMP, needs `-fopenmp`), Perl (ithreads),
PHP (`parallel`, needs a ZTS build), PowerShell (runspace pools), Crystal (`Fiber::ExecutionContext::Parallel`),
Objective-C (`NSThread`), Modula-2 (Win32 `Threads` module), Modula-3 (`Thread.Fork`), BASIC (`THREADCREATE`),
Groovy (`java.lang.Thread`), Clojure (`java.lang.Thread` interop, not `future`), Common Lisp (`sb-thread:make-thread` on real Win32 threads), OCaml (`Domain.spawn`/`Domain.join`, OCaml 5 only), Erlang and Elixir (`spawn` onto a BEAM scheduler, one per core, no global lock), Raku (`start`, which MoarVM runs through `uv_thread_create`), Vala (`GLib.Thread`), Component Pascal (the .NET `Threading` module,
via `REGISTER` on a bound method with the foreign `Th.ThreadStart` delegate), C3 (`std::thread`),
Oberon-07 (raw `CreateThread` + `WaitForSingleObject` declared as foreign procedures, no thread
module in its library),
Assembly (raw `clone` + `futex` syscalls, no libc).

The last two are the same kind of row: a language with no thread facility that gets real threads
anyway by declaring the operating system's own calls, which is legitimate under the task's
wording and is recorded per row in `BUILD.md`. Oberon-07's start routine has to be declared with
the Windows calling convention, so the procedure *and* the procedure type both carry it.

### Passes, but not faster than its own task 02

| Language | What it has | Measured |
|---|---|---|
| Algol 68 | a real parallel clause, `PAR (unit, unit, unit, unit)`, four pthreads | `7500000075000000`, in the same ~2.5 minutes as task 02 — a correct-answer-no-speedup cell |

Algol 68's parallel clause is not a broken feature and not a mis-written program: the
implementation copies a whole stack on every unit switch, and its own source says the clause
"has been included for educational purposes; this implementation is not the most efficient
one" (`rts-parallel.c`). Four pthreads really are created, the units really do overlap, and
the four-way answer is right; the bookkeeping simply costs more than the parallelism saves.
Treat the cell like CPython's and CRuby's.

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
| Racket | `(thread thunk #:pool 'own #:keep 'results)`: each thread gets its own OS thread with the heap shared, and `thread-wait` returns the result. Plain `thread` is green and `future` serialises at blocking operations, so neither is used. | `7500000075000000`, real multicore work |

### The six that need explaining

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
mutable state and the answer is gathered with `thread::send`.

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
  (`WScript.Shell.Exec` children), and JavaScript if you count worker threads as not being
  threads. ActionScript belongs here too:
  AIR `Worker`s run on real OS threads but are separate AVM2 instances with no shared memory,
  so they are isolates rather than threads in the same sense Dart's are.
- Pass, with the GIL/GVL caveat recorded: CPython, CRuby, Dolphin Smalltalk, whose `Process`
  objects are green and multiplexed onto one OS thread, and Simula, whose four `PROCESS`
  objects are scheduled cooperatively by its own process simulation. `jruby` and Groovy are
  unaffected and use real JVM threads. Algol 68 belongs in this group for a different reason —
  its four pthreads are real and overlap, but the implementation's stack copying costs more
  than the parallelism returns, so it is a correct-answer-no-speedup cell too.
- Pass, but only with an extra install or flag: Lua (Lanes), Tcl (the `Thread` package),
  PHP (`parallel` on a ZTS build), Julia (`-t4`), Fortran (`-fopenmp`), Algol 68 Genie (a
  source build with `--enable-parallel`). Without the flag Julia and Fortran still print the
  right answer, because their loops fall back to serial; without it a68g refuses to parse `PAR`
  at all.

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
the same one Tcl, D, Julia, Nim, Dart, Pascal, COBOL and Dolphin note.

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

Task 14 and task 15 use two files with the same 90 MiB shape: 14 reads `data.bin`, 15
writes `out.bin`.

- `data.bin` — 94371840 bytes, the bytes 0 through 255 repeating. 368640 repetitions.
  Generate once; every language reads the same bytes. There is no generator script in this
  repository, so write one: 368640 copies of the 256-byte cycle.
- `out.bin` — written by task 15, 94371840 bytes. Overwritten on every run, so it needs
  90 MiB of free space and a writable working directory. One row cannot use the working
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

Every task runs six times, in 77 toolchains.

- Fast compiled languages: under a second per run, so about **1.5 hours** for the matrix.
- The 100-million-iteration tasks take 10 to 15 seconds in CPython.
- `powershell` costs about 2.64 us per iteration, so its 100-million-iteration loops take
  around 264 seconds each. Its call-heavy and per-character tasks are far slower: 03 and 09
  are 100 and 331 million interpreted calls, and 06 and 14 walk 100 million items one at a
  time. Task 11 was measured at the full 100000000 iterations and prints the right answer;
  see the section above.
- The six new rows are mostly slow, and they hold the slowest cells in the matrix:
  - **Component Pascal** task 10 is a .NET assembly running the same bounds-checked spigot; at
    10000 digits it took about 5 minutes a run, so about **12 s** at 2000.
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
  - **VBScript** is the slowest row overall. Task 07 takes about **9.6 minutes** (576 s
    measured) and task 14 about **1.4 minutes** (91 s measured at 100 MiB, so about 82 s at 90
    MiB, at roughly 1.1 us per byte through the text-mode stream), task 06 about 35 s. Task 10
    is the worst cell in the matrix after `a68g`'s. Measured scaling at 100/200/400/800/1600
    digits is 1.19 s, 3.24 s, 10.4 s, 46.1 s and 205.5 s, an exponent of about 2.16 in the digit
    count, which puts the 2000-digit run at roughly **5.5 minutes**. The digit sums at those
    scales are 471, 897, 1753, 3588 and 7269, each matching an independently computed value.
  - **OCaml** task 10 is about **16 s** at 2000 digits (405 s measured at 10000, scaled
    quadratically): the hand-rolled int64 base-1e9 limbs, since the standard library has no
    bignum and `zarith` is not in MSYS2's UCRT64 repository.
  - **ActionScript** task 10 is about **11 s** at 2000 digits (268 s measured at 10000, scaled
    quadratically): the same bounds-checked spigot, running on the AVM2 JIT with
    double-precision limbs.
  - **Oberon-07** task 10 is about 10 s at 2000 digits, **Algol 68 Genie** task 02 takes about
    2.5 minutes and its task 11 about the same, its task 07 about an hour and its task 14 about
    three and a half minutes, and **Cim** task 10 about 12 s.
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
    two points), so those extrapolate to roughly **half an hour** for the 2000-digit run, and the
    cell's warm-up plus five timed runs is about two and a half hours. The cause is not the
    program: the C reference does the identical work in **1.9 s** on this machine, so a68g is
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
  - The compiled rows (C3, Vala) are in the normal range, with C3's task 07 the outlier at
    about 2.5 minutes because appending to a string a million times is quadratic by design.
- Measured slow cells elsewhere: Java task 07 at 514 s, Modula-3 task 10 at 206 s, Modula-2
  task 10 at 115 s.
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

**Windows reaches every row**; it is the only host that does. Linux loses `actionscript`
(no captive runtime), `dolphin smalltalk` (Windows-only VM) and `vbscript` (a Windows Script
Host component, and one Microsoft is removing). Windows loses `assembly`, and
loses Tcl's task 11 unless the distribution bundles the `Thread` package. macOS loses
`assembly`, `msvc` and `dolphin smalltalk`, which exists nowhere else, plus the Windows
PowerShell 5.1 row (use `pwsh` there), and the two rows whose toolchain ships Windows-only
binaries: `oberon-07` (build the compiler with `make lin64` instead) and `component pascal`,
which is .NET-only by construction and has no non-Windows release. Whichever host you pick,
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
