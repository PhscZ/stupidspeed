# Run requirements

What has to be installed to execute the built programs, and what the machine has to look
like for the numbers to mean anything. For compilers, see `BUILD.md`.

## Host

| | Requirement | Why |
|---|---|---|
| OS | x86-64, Linux, macOS or Windows | Every row is reachable on Windows and on Linux; macOS loses `msvc`. The one exception is `assembly`, which is Linux x86-64 only: it is a freestanding ELF64 binary built with `nasm -f elf64` and `ld`. `tcc`, `clang`, `flang` and `luajit` all need a little care on Windows but no WSL. |
| CPU | 4 physical cores | Task 11 runs four threads. Every other task is pinned to one core, so more cores do not help them. |
| RAM | 8 GB minimum, 16 GB comfortable | The tasks themselves are small: the largest allocation is task 06's 100 MB text, and task 12's three 1000x1000 arrays are 24 MB together. The 16 GB is for the JVM, GraalVM and Julia toolchains. `native-image` alone wants 2–4 GB to build. |
| Disk | 20 GB free | 200 MiB of fixtures, plus the toolchains themselves: `BUILD.md` measured 19 GB for all 61 installed and run, with another 2–3 GB of scratch while reassembling MSVC and Swift. |
| Filesystem | `tmpfs` or RAM disk preferred for the file tasks | Reading 100 MiB from a spinning disk measures the disk. Anything run under WSL2 measures the WSL disk layer instead. Where the fixture lives must be recorded in the results. |

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
| Oberon-2 | voc | none | static by default |
| ATS | ats | none | static by default; needs a C compiler to build |
| BCPL | cintsys64 | Cygwin runtime (`cygwin1.dll`) | interpretive cintcode VM, not a native binary; the 64-bit build, see `BUILD.md` |

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
Assembly (raw `clone` + `futex` syscalls, no libc).

### Works, but not with shared-memory threads

| Language | What it has | Measured |
|---|---|---|
| JavaScript | `worker_threads`, one thread each with its own heap | `7500000075000000` |
| Dart | isolates, each with its own memory, message passing only | documented |
| R | `PSOCK` cluster: separate R processes | `7500000075000000` (timing not measured, see below) |
| Lua | needs the Lanes C extension (or llthreads2) | `7500000075000000`, **3.56x on 4 threads** |
| Python | threads exist but the GIL serializes them | correct, **0.97x** — use `multiprocessing` for 2.3x |
| Ruby (CRuby) | threads exist but the GVL serializes them | correct, no speedup |

### The four that need explaining

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

### Cannot do it

**GDScript.** Godot has a `Thread` class and it works, but it is awkward to use for this
shape of problem and Godot's headless startup is about a second, which swamps the task.
Treat it as a very slow pass rather than a skip.

**Oberon-2 and BCPL** have no file for this task, so their cell is `SKIPPED` and not an
unbuilt row. These two are the only rows with no task 11 source. Nothing in the voc library
creates a thread or a process: `ulmProcess` is only the current process's identity and exit
codes, `ulmSYSTEM.UNIXFORK` is private and its `UNIXCALL` wrapper is commented out in the
source, and `oocRts.System` is a shell call. Cintsys is single-threaded — its own user guide
describes it that way, the distribution's pthreads were removed in 2010 in favour of polling
and coroutines, and the full `Sys_` call list in `g/libhdr.h` has no process creation, only
`Sys_shellcom` and `Sys_getpid`. The coroutine multi-tasking variant is Cintpos, a different
system.

### What this means for the wording

Task 11 says "start 4 threads". Under that wording:

- Pass: assembly (`clone` + `futex`), and everything in the threads list above.
- Pass, but with processes rather than threads: R, COBOL on Linux (`CBL_GC_FORK`), and
  JavaScript if you count worker threads as not being threads.
- Pass, with the GIL/GVL caveat recorded: CPython, CRuby. `jruby` is unaffected and uses real
  JVM threads.
- Pass, but only with an extra install or flag: Lua (Lanes), PHP (`parallel` on a ZTS build),
  Julia (`-t4`), Fortran (`-fopenmp`). Without the flag Julia and Fortran still print the
  right answer, because their loops fall back to serial.

If the task instead says "4 concurrent workers", everything above passes and the comparison
becomes "does this language use more than one core", which is the more useful question. That
wording also lets R and Lua participate, and it keeps the informative result that CPython and
CRuby print the right answer with no speedup.

## Fixtures

Task 14 and task 15 use two files with the same 100 MiB shape: 14 reads `data.bin`, 15
writes `out.bin`.

- `data.bin` — 104857600 bytes, the bytes 0 through 255 repeating. 409600 repetitions.
  Generate once; every language reads the same bytes. There is no generator script in this
  repository, so write one: 409600 copies of the 256-byte cycle.
- `out.bin` — written by task 15, 104857600 bytes. Overwritten on every run, so it needs
  100 MiB of free space and a writable working directory.

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

Every task runs six times, in 61 toolchains.

- Fast compiled languages: under a second per run, so about **1.5 hours** for the matrix.
- The 100-million-iteration tasks take 10 to 15 seconds in CPython.
- `powershell` costs about 2.64 us per iteration, so its 100-million-iteration loops take
  around 264 seconds each. Its call-heavy and per-character tasks are far slower: 03 and 09
  are 100 and 331 million interpreted calls, and 06 and 14 walk 100 million items one at a
  time. Task 11 was measured at the full 100000000 iterations and prints the right answer;
  see the section above.
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
| oberon-2 (voc) | yes | yes | yes, source build under Cygwin; best built with the mingw-w64 cross compiler for a standalone binary |
| ats | yes | yes | yes, source build under Cygwin (its own requirements page says "Windows with Cygwin") |
| bcpl | yes | no | yes, source build under Cygwin; the Cygwin path is the maintained one |
| assembly | yes | no | no (freestanding ELF64, `nasm -f elf64` + `ld`) |

Every row is reachable on Linux. Windows loses `assembly`. macOS loses `assembly` and `msvc`,
which exists nowhere else, plus the Windows PowerShell 5.1 row (use `pwsh` there). Whichever
host you pick, run the whole matrix on it, because numbers are only comparable within a run.

### Cygwin-hosted toolchains: native or cross-compiled

Some toolchains only exist under Cygwin (`voc` has no Windows binary at all; ATS's own
requirements page says "Windows with Cygwin"). Those have a choice of C backend, and the
choice is worth recording per row because it changes the number:

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
