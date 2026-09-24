# Run requirements

What has to be installed to execute the built programs, and what the machine has to look
like for the numbers to mean anything. For compilers, see `BUILD.md`.

## Host

| | Requirement | Why |
|---|---|---|
| OS | x86-64, Linux or Windows | Nothing in the matrix is unavailable on Windows. `msvc` is the only Windows-only toolchain. `tcc`, `clang`, `flang` and `luajit` all need a little care there but no WSL. |
| CPU | 4 physical cores | Task 11 runs four threads. Every other task is pinned to one core, so more cores do not help them. |
| RAM | 8 GB minimum, 16 GB comfortable | The tasks themselves are small (the largest allocates 24 MB). The 16 GB is for the JVM, GraalVM and Julia toolchains. `native-image` alone wants 2–4 GB to build. |
| Disk | 5 GB free | 200 MiB of fixtures, plus room for 51 toolchains. |
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
| Assembly | nasm | none | |
| Java | openjdk | JRE 17 or newer | |
| Java | graalvm native-image | none | standalone binary |
| Kotlin | jvm | JRE + kotlin-stdlib | |
| Kotlin | native | none | |
| C# | coreclr | .NET 8 runtime | |
| C# | nativeaot | none | |
| C# | mono | Mono runtime | |
| F# | dotnet | .NET 8 runtime | |
| Scala | jvm | JRE + scala library | |
| Dart | aot | none | |
| Dart | jit | Dart VM | |
| JavaScript | node, bun, deno | the runtime itself | |
| PHP | zend | PHP + opcache | |
| PHP | zend + jit | PHP + opcache | JIT needs `opcache.enable_cli=1`. The stock Windows zip ships no `php.ini`, so JIT is off until you write one and set `opcache.jit_buffer_size`. |
| Python | cpython, pypy, graalpy | the interpreter | |
| Python | nuitka | none | standalone binary |
| Ruby | cruby | Ruby | **the stock Windows build has no YJIT**: `ruby --yjit` warns "Ruby was built without YJIT support". The `cruby + yjit` row needs a Ruby built with rustc present. |
| Ruby | jruby | JRE + JRuby | needs Java 25 |
| Lua | puc-lua, luajit | the interpreter | task 11 also needs the Lanes extension, see below. No `luarocks` ships with the Windows binaries, so Lanes has to be built by hand. |
| Perl | perl | Perl | |
| R | gnu-r | R | task 11 uses the bundled `parallel` package, PSOCK mode |
| Julia | julia | Julia | about 1 GB with the standard library |
| GDScript | godot | Godot binary | roughly a second of startup on its own |
| Nushell | nu | the `nu` binary | version 0.115.1 or newer. No build step. |
| PowerShell | powershell, pwsh | .NET runtime | **not a shell in the usual sense.** See below. |

### JVM versions are not interchangeable

Four rows need a JVM and they disagree about which one:

- `jruby` needs **Java 25**; on Java 24 and older it dies with `UnsupportedClassVersionError`.
- `kotlin/native` needs **Java 17**. Its launcher mis-parses JDK 24's version string and fails with a batch syntax error.
- `scala` needs anything modern. Oracle's `java8path` shim, if it is ahead of the real JDK on `PATH`, makes `scalac` fail on class file version 61.0.
- `graalvm native-image` is its own JDK 25.

Set `JAVA_HOME` per row rather than relying on whatever `java` resolves to. On a machine with
several JDKs installed, the default `PATH` order is usually the wrong one for at least two of
these four.

## The two "shells" are real languages

Neither `powershell` nor `nu` is a shell in the POSIX sense. Both are full languages with
typed data and real concurrency, and both can do far more of these tasks than a POSIX shell
could. Every claim below was measured, not assumed.

| Task | Needs | PowerShell 5.1 | Nushell 0.115.1 |
|---|---|---|---|
| 05 `alloc_churn` | allocation and GC | yes, the .NET GC | yes, garbage collected |
| 08 `average` | floating point | yes, `[double]` | yes, `float` |
| 10 `pi` | big integers | yes, `System.Numerics.BigInteger` | **no**, integers are i64 and `2 ** 200` overflows |
| 11 `parallel_sum` | threads | yes, runspace pools | yes, `par-each` |

So nushell is `SKIPPED` on task 10. It is the only task it cannot do.

### Task 11, measured in both

Four workers of 25000000 iterations each, 100000000 total:

| | Result | Time | Speedup vs serial |
|---|---|---|---|
| PowerShell, runspace pool | `7500000075000000` | **75.9 s** | 3.48x |
| Nushell, `par-each` | `7500000075000000` | **53.3 s** | 1.98x |
| (serial, for reference) | `7500000075000000` | ~264 s / ~105 s | 1x |

Both print the same number as the single-threaded task 02, which is the point of the task.

Nushell is faster in absolute terms because its loop costs about 1.05 us per iteration
against PowerShell's 2.64 us. PowerShell scales better across threads, 3.48x against 1.98x.

How each does it:

- **PowerShell**: `[runspacefactory]::CreateRunspacePool(1, 4)`, backed by real .NET thread
  pool threads. `Start-Job` is the wrong choice here because it spawns a process per job,
  and `ForEach-Object -Parallel` does not exist before PowerShell 7.
- **Nushell**: `0..3 | par-each --threads 4 {|t| ... }`, which uses a dedicated thread pool.
  Note `--keep-order` is not needed, because the four results are summed.

Both should be listed beside C# and F#, not beside a POSIX shell.

## Task 11: which languages can actually do it

Task 11 is the only task that is not portable. This is what each language actually has,
verified by running the task or by reading the official documentation.

### Real OS threads, no problem

C, C++, Rust, Zig, Go, D, Swift, Ada, Pascal, Java, Kotlin, C#, F#, Scala, Nim,
Odin, Fortran (OpenMP), Perl (ithreads), PowerShell (runspace pools), Nushell (`par-each`).

### Works, but not with shared-memory threads

| Language | What it has | Measured |
|---|---|---|
| JavaScript | `worker_threads`, one thread each with its own heap | `750000750000` |
| Dart | isolates, each with its own memory, message passing only | documented |
| R | `PSOCK` cluster: separate R processes | `750000750000` in 0.07 s against 0.15 s serial |
| Lua | needs the Lanes C extension (or llthreads2) | `750000750000`, **3.56x on 4 threads** |
| Python | threads exist but the GIL serializes them | correct, **0.97x** — use `multiprocessing` for 2.3x |
| Ruby (CRuby) | threads exist but the GVL serializes them | correct, no speedup |

### The two that need explaining

**Lua.** Stock Lua has no threads, only coroutines, which are cooperative and
single-threaded. But `lanes` is a mature C extension that wraps real OS threads, and it
works: Lua 5.4.6 with Lanes 3.17.2 produced `750000750000` and ran **3.56x faster on four
threads**. So Lua is not `SKIPPED`, but it needs `luarocks install lanes` first. The
alternatives are `lua-llthreads2` and `LuaThread`, both also C extensions.

**R.** R has no threads for R code at all. `parallel::mclapply` forks processes and is
**Unix only** — on Windows it fails with `'mc.cores' > 1 is not supported on Windows`, and
`makeCluster(type="FORK")` fails with `fork clusters are not supported on Windows`. What
does work everywhere is `makeCluster(type="PSOCK")`, which starts separate R processes and
communicates over sockets. That produced the right answer, 0.07 s against 0.15 s serial.
Note that PSOCK workers start with an empty environment, so constants must be pushed out
with `clusterExport` or they fail with `object 'N' not found`.

Threading in R exists only inside C-level packages, such as OpenMP in `data.table` or TBB
in `RcppParallel`. Plain R code never runs on two threads.

### Cannot do it

**GDScript.** Godot has a `Thread` class and it works, but it is awkward to use for this
shape of problem and Godot's headless startup is about a second, which swamps the task.
Treat it as a very slow pass rather than a skip.

**Assembly.** Possible only through a raw `clone` or `CreateThread` syscall, which is not a
traditional way to write the task. `SKIPPED`.

### What this means for the wording

Task 11 says "start 4 threads". Under that wording:

- `SKIPPED`: assembly.
- Pass, but with processes rather than threads: R, and JavaScript if you count worker threads
  as not being threads.
- Pass, with the GIL/GVL caveat recorded: Python, Ruby.

If the task instead says "4 concurrent workers", everything above passes and the comparison
becomes "does this language use more than one core", which is the more useful question. That
wording also lets R and Lua participate, and it keeps the informative result that Python and
Ruby print the right answer with no speedup.

## Fixtures

Task 14 and task 15 share one file.

- `data.bin` — 104857600 bytes, the bytes 0 through 255 repeating. 409600 repetitions.
  Generate once; every language reads the same bytes.
- `out.bin` — written by task 15, 104857600 bytes. Overwritten on every run, so it needs
  100 MiB of free space and a writable working directory.

Put both in a RAM disk when you can. On a real disk, task 14 will be measuring the disk
rather than the language, which is a different and less interesting result.

## Measurement tooling

| Need | Linux | Windows |
|---|---|---|
| Wall clock | the harness, `CLOCK_MONOTONIC` | `QueryPerformanceCounter` |
| Timeout, 300 s | `timeout 300` | `Start-Process` with a wait |
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

Every task runs six times, in 51 toolchains.

- Fast compiled languages: under a second per run, so about **1.5 hours** for the matrix.
- The 100-million-iteration tasks take 10 to 15 seconds in CPython.
- `nu` costs about 1.05 us per iteration, so the 100000000-iteration tasks take roughly 105
  seconds each and finish inside the timeout. Its heaviest task, 13 `matrix_mul` at 125
  million inner steps, will run close to the limit.
- `nu` is `SKIPPED` on 10 `pi` only, because its integers are 64-bit.
- `powershell` costs about 2.64 us per iteration, so its 100-million-iteration tasks take
  around 264 seconds and sit right on the 300 second timeout. Expect `DNF` there.
- **Task 11 works in both.** `powershell` uses runspace threads, `nu` uses `par-each`. Both
  were measured at the full 100000000 iterations and both print the right answer. See the
  section above.
- **The timeouts dominate the total.** Roughly 40 cells hit the 300 second limit, and at six
  runs each that is over 20 hours of waiting by itself. Run the timeout case once per cell
  instead of six times, and record it as `DNF` on the first hit.
- Budget **4 to 6 hours** for a full pass with that change, or **24 hours or more** without it.

`DNF` and `WRONG` are results, not failures. So is `SKIPPED`, which is what a cell reports
when the toolchain is missing or the language cannot do the task at all.

## Platform limits

Some cells cannot be filled on some platforms. This is worth knowing up front rather than
discovering halfway through a run.

| Toolchain | Linux | macOS | Windows |
|---|---|---|---|
| nu (nushell) | yes | yes | yes |
| powershell | yes | yes | yes |
| tcc | yes | yes | yes (native win64 build) |
| clang, clang++ | yes | yes | yes, but needs MinGW headers or the MSVC SDK |
| swift | yes | yes | yes, via the burn-bundle extraction; needs MSVC to link |
| flang | yes | yes | yes, from MSYS2 `ucrt64`; the official LLVM Windows tarball has no `flang.exe` |
| luajit | source | source | source, builds in about 30 seconds with MinGW once `PREFIX` has no spaces |
| graalvm, graalpy | yes | yes | yes |
| jruby | yes | yes | yes, on Java 25 |
| msvc | no | no | yes |

Every row is now reachable on every host. Windows is the only platform that fills all of
them, because `msvc` exists nowhere else. Linux and macOS lose `msvc`, and that is the only
outright loss anywhere in the matrix. Whichever host you pick, run the whole matrix on it,
because numbers are only comparable within a run.
