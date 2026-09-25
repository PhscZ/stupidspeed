# Build requirements

What has to be installed to turn each task's source into something runnable.
For what has to be installed to *run* the result, see `RUN.md`.

Convention below: `<task>` is the task's own name, so the source for task 01 in C is
`sources/c/01_branches.c`, and the output is `prog`. Add the thread flag where a language
needs one, because task 11 uses four threads.

Four things do not follow the flat `<task>.<ext>` layout, and each says why:

- **C#, F# and VB.NET** keep a folder per task (`01_branches/01_branches.csproj`) because the
  .NET SDK does not support several projects in one directory: `dotnet build` with no project
  argument fails when the folder holds more than one `.csproj`, and the projects would share
  one `obj/` and `bin/`.
- **Fortran task 03** is two files, `03_func_sum.f90` and `03_func_sum_add_one.f90`, because
  the no-inline requirement needs a second translation unit.
- **GDScript** has one shared `sources/gdscript/project.godot` beside the 15 `.gd` files. It
  is what `godot --headless --script <task>.gd` resolves against, and its
  `config/run/print_header=false` is what keeps the output to the single expected line.
- **Tcl task 03** is two files, `03_func_sum.tcl` and `03_func_sum_add_one.tcl`, because the
  proc has to live in another file to be a real cross-file call; the main file `source`s it.

Swift is flat like everything else: `swiftc -O -o prog <task>.swift`. The rule that top-level
code needs a file called `main.swift` only applies when several files are passed in one
invocation, where `swiftc` has to pick which one holds `main`; with a single file there is
nothing to pick, so the name is free.

Java, D, Nim and Ada prefix the name (`_01_branches.java`, `_01_branches.d`,
`_01_branches.nim`, `t01_branches.adb`), because those languages tie the file name to an
identifier and a digit cannot start one.

A toolchain whose source genuinely differs from its language's main toolchain gets a folder of
its own rather than a suffixed file beside the shared one. There is one such case today:
`sources/kotlin-native/`, which holds the three Kotlin/Native files (tasks 11, 14 and 15) that
cannot use `java.lang.Thread` or `java.io`. The other twelve tasks are one source shared by
both Kotlin rows and stay in `sources/kotlin/`, so those twelve are built from `kotlin/` for
either row and only the three are built from `kotlin-native/`.

The version column is the **minimum** that works, not the newest release. Anything
reasonably recent works; it is what the task actually needs, not what happens to be current.

## Host

Builds assume **x86-64**, on Linux, macOS or Windows. `msvc` is the only Windows-only
toolchain, and every other row builds on Windows too, including `flang` and `luajit`. The one
row that is *not* portable is `assembly`: it is a freestanding ELF64 binary built with
`nasm -f elf64` and `ld`, so it is Linux x86-64 only. See `RUN.md` for the full platform
breakdown.

Disk: **19 GB measured** for all 64 toolchains, installed and run on one Windows x64 host.
The heavy terms are LLVM (4.0 GB), Swift (3.2 GB), GNAT with its MSYS2 runtime (1.8 GB, which
also supplies `flang`), MSVC (1.2 GB once reassembled from a 2.5 GB layout), Julia (1.1 GB),
Perl (1.0 GB), the .NET SDK (0.7 GB) and GraalVM (0.7 GB); most other rows are 0.1-0.6 GB.
Budget another 2-3 GB of scratch space while reassembling MSVC and Swift, since both go
through a multi-gigabyte download that is deleted afterwards. Package caches do not count and
can be far larger than the toolchains themselves.

Beware one installer that quietly pulls in more than the toolchain: Alire's `alr toolchain`
bootstraps a full MSYS2 (about 450 MB) plus the GNAT release, and the `alr` assistant runs
that download as a side effect of `--help`. That MSYS2 is not wasted: its `ucrt64` repository
is the practical way to get a working `flang` on Windows.

## Toolchains

### Compiled to native code — nothing needed at run time

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| C | gcc | 9 (C11 + pthreads) | distro package | `gcc -O2 -pthread -o prog <task>.c` |
| C | clang | 10 | releases.llvm.org | `clang -O2 -pthread -o prog <task>.c` |
| C | msvc | VS 2019 | Visual Studio Build Tools, C++ workload | `cl /O2 /Fe:prog <task>.c`. Works without admin: `--layout` the bootstrapper, then reassemble the packages (see below). |
| C | tcc | 0.9.27 | bellard.org/tcc | `tcc -o prog <task>.c` |
| C++ | g++ | 9 | distro package | `g++ -O2 -pthread -o prog <task>.cpp` |
| C++ | clang++ | 10 | releases.llvm.org | `clang++ -O2 -pthread -o prog <task>.cpp` |
| C++ | msvc | VS 2019 | as above | `cl /O2 /EHsc /Fe:prog <task>.cpp` |
| Rust | rustc | 1.70 (1.63 for `std::array::from_fn`) | rustup.rs | `rustc -O -o prog <task>.rs` |
| Zig | zig | 0.16 | ziglang.org/download | `zig build-exe -O ReleaseFast <task>.zig -femit-bin=prog` |
| Go | gc | 1.20 | go.dev/dl | `go build -o prog <task>.go` |
| D | dmd | 2.100 | dlang.org/install.sh | `dmd -O -release -of=prog _<task>.d` |
| D | ldc2 | 1.30 | dlang.org/install.sh | `ldc2 -O3 -release -of=prog _<task>.d` |
| Swift | swiftc | 5.8 | swift.org/install | `swiftc -O -o prog <task>.swift`. Windows needs `-sdk <swift>/Platforms/6.4.0/Windows.platform/Developer/SDKs/Windows.sdk`, and MSVC on PATH for the link step. |
| Fortran | gfortran | 9 | distro package | `gfortran -O3 -o prog <task>.f90`. Task 03 also compiles `03_func_sum_add_one.f90`; task 11 needs `-fopenmp`. |
| Fortran | flang | LLVM 17 | MSYS2 `ucrt64` on Windows, distro or LLVM release elsewhere | `flang -O3 -o prog <task>.f90` (older LLVM: `flang-new`). Same two extras as gfortran: the second file for task 03 and `-fopenmp` for task 11. The official LLVM Windows tarball has no `flang.exe`; MSYS2's `mingw-w64-ucrt-x86_64-flang` plus `-flang-rt` is the working Windows route, and it pulls in the runtime libraries as well. |
| Ada | gnat | 12 | alire.ada.dev | `gnatmake -O3 t<task>.adb` |
| Pascal | fpc | 3.2.2 | freepascal.org | `fpc -O3 -oprogram <task>.pas`. On Windows x64 there is no native compiler: install the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, then build with `-Px86_64`. |
| Nim | nim | 2.0 | nim-lang.org | `nim c -d:release -o:prog _<task>.nim` |
| Odin | odin | dev-2024 | odin-lang.org | `odin build <task>.odin -o:speed -out:prog` |
| Kotlin | kotlin/native | 1.9 | kotlinlang.org | `kotlinc-native -opt -o prog <task>.kt`, run from `sources/kotlin-native/` for tasks 11, 14 and 15 and from `sources/kotlin/` for the other twelve. The three in `kotlin-native/` use `java.lang.Thread` and `java.io`, which do not exist on Native; the other twelve are one source shared by both Kotlin rows. |
| Java | graalvm native-image | 21 | graalvm.org | `native-image -O2 _<task>`. Emits a standalone native executable, so it belongs here and not with the bytecode rows. |
| C# | nativeaot | .NET 8 | dotnet.microsoft.com | `dotnet publish -c Release -p:PublishAot=true`. Emits a native executable. |
| Dart | aot | 3.3 | dart.dev | `dart compile exe -o prog <task>.dart`. Emits a native executable. |
| Python | nuitka | 4.0 | nuitka.net | `nuitka --standalone <task>.py`. Compiles to C and then to a binary. |
| Assembly | nasm | 2.15 | nasm.us | `nasm -f elf64 <task>.asm && ld -o prog <task>.o`. Nothing extra for task 11: there is no libc, so it issues `clone` and `futex` itself. |
| Crystal | crystal | 1.21 | crystal-lang.org | `crystal build --release -o prog <task>.cr`. Needs the MSVC environment: the compiler shells out to `cl.exe`, which drives `link.exe`. Integer literals default to `Int32`, so task 02 must be written with the `Int64` form or it raises `OverflowError`. |
| Objective-C | clang | 22 | MSYS2 `ucrt64` | `clang -fobjc-runtime=gnustep-2.2 -O2 -o prog <task>.m -lobjc -lgnustep-base`. The runtime flag is required; without it the link fails on `objc_autoreleasePoolPush` and `__objc_load`. `gcc-objc` 16.2.0 is an alternative front end, but the clang path is the one measured. |
| Modula-2 | adw | 1.6.879 | modula2.org/adwm2 | Two steps, not one. `m2amd64.exe /sym:<ADW>\ASCII\winamd64sym <task>.mod` compiles, then `sblink.exe /machine:amd64 /out:prog.exe <module>.obj rtl-win-amd64.lib win64api.lib <module>.lib` links. `/machine:amd64` is mandatory: the default linker machine type rejects the 64-bit object with `Incorrect Machine Type`. The compiler writes the `.obj` **beside the source file**, not into the working directory, and names it after the `MODULE`, not the file. Copy the source into a scratch directory first or the repo fills up with objects. |
| Modula-3 | cm3 | 5.10.0 | github.com/modula3/cm3 | `cm3 -build -O` in a directory holding `Main.m3` and an `m3makefile`. Needs the MSVC environment for its C backend, and writes the binary to `AMD64_NT\prog.exe`. Task 10 also needs `import("arithmetic")` in the m3makefile for `BigInteger`. |
| COBOL | gnucobol | 3.2 | MSYS2 `ucrt64`, or gnucobol.sourceforge.io | `cobc -x -O2 -o prog <task>.cob`. `PIC 9(18) COMP-5` is the exact 64-bit picture, and COMP-5 keeps the full binary range regardless of the PICTURE, so limb arithmetic fits in one COMPUTE. Outside an MSYS2 shell, `cobc` needs `COB_CONFIG_DIR` and `COB_COPY_DIR` set to the package's `share/gnucobol/{config,copy}` or it stops with `configuration error: /ucrt64/share/gnucobol/config/default.conf`. Task 11 needs `CBL_GC_FORK`, which GnuCOBOL documents as unavailable on Windows outside Cygwin: it returns -1 there and the program falls back to four in-process quarters, so the answer is right but the row is single-core on Windows and four-way on Linux. |
| BASIC | freebasic | 1.10.1 | freebasic.net | `fbc -O 2 -x prog.exe <task>.bas`. `-x` names the output, so the source file name must come after it; `-x <task>.bas` alone would write the executable over the source. `LONGINT` is the 64-bit type; `THREADCREATE` gives real threads for task 11. Task 03 also compiles `03_func_sum_add_one.bas` on the same command line. |
| V | v | 0.5.2 | vlang.io | `v -prod -cc x86_64-w64-mingw32-gcc -o prog <task>.v`. V compiles through a C backend, so it needs a C compiler; `-cc` picks it. Task 03 keeps `add_one` in the same file with `@[noinline]`, V's own no-inline facility, which the generated C carries over as `__attribute__((noinline))`. |
| Oberon-2 | voc | 3.0.1 | github.com/vishapoberon/compiler | Built from source (`CC=x86_64-w64-mingw32-gcc make`, ~2 min). `CFLAGS=-O2 voc <task>.mod -m` compiles and links in one step, emitting an executable named after the `MODULE`. `CFLAGS` is how the backend's optimisation level is set — the `-O2` *compiler* flag means something else entirely (it selects the integer size model). Task 03 needs both `.mod` files on the command line. No task 11: nothing in the shipped library creates a thread or a process. `ulmProcess` is only the current process's identity and exit codes, `ulmSYSTEM.UNIXFORK` is private and its `UNIXCALL` wrapper is commented out in the source, and the only escape hatch is `oocRts.System`, a shell call. |
| ATS | ats | 0.4.2 | ats-lang.org, or SourceForge `ats2-lang` | Built from source under Cygwin: `./configure && make -f Makefile_dist all`. GCC 14 rejects the 2014-era bootstrap C, so `src/CBOOT/Makefile` needs `CFLAGS += -fpermissive -Wno-implicit-function-declaration -Wno-int-conversion -Wno-implicit-int` first. That is enough to get `patsopt` and `patscc`; `make all` then fails on `utils/myatscc`, which is a build utility and not needed. `patscc -DATS_MEMALLOC_LIBC -O2 -o prog <task>.dats`. Task 03 needs `ATS_DYNLOADFLAG 0` on the helper unit, or the separate compilation gets optimised away. |
| BCPL | cintsys64 | 1.0 (2023-12-13) | cl.cam.ac.uk/~mr10/BCPL.html | Interpretive cintcode system, **not native code** — the row measures a VM, and it must be the **64-bit** one. Every `.b` file here is written for `cintsys64`: task 02's total does not fit in a 32-bit word, and under the 32-bit `cintsys` the accumulator wraps and the answer is wrong. Built from source under Cygwin; the current distribution builds both, `make bin/cintsys64` (or `make clean64` then `make run64`) puts the 64-bit Cintcode in `cintcode/cin64`, and `BCPLROOT` must point at the `cintcode` directory with `$BCPLROOT/bin` on `PATH`. The source headers name `BCPL64ROOT`/`BCPL64PATH`/`BCPL64HDRS`/`BCPL64SCRIPTS`, which is the older standalone `bcpl64.tgz` tree; upstream now marks that distribution obsolete in favour of the one above. The binary needs Cygwin's DLLs, so it must be launched from Cygwin. `cintsys64 -c bcpl <task>.b to <task>` compiles and `cintsys64 -c <task>` runs, both from `sources/bcpl/` because the compiled Cintcode file lands in the working directory; `-q` drops the banner and the CLI prompts. Use `LET start() = VALOF { ... RESULTIS 0 }` — the old `LET START() BE` form aborts with `G1 unassigned`. No task 11: Cintsys is single-threaded, as its own user guide describes it, and the distribution has no process-creation primitive either — the full `Sys_` call list in `g/libhdr.h` tops out at `Sys_shellcom` (a shell escape) and `Sys_getpid`, and the pthreads that once existed were removed in 2010 in favour of polling and coroutines. The coroutine multi-tasking variant is Cintpos, a different system. |

### Compiled to bytecode — the VM is needed on every run

These compile once, but the output is bytecode or an intermediate form, so a virtual machine
has to start on every measured run. That startup is part of the number.

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| Java | openjdk | 17 | jdk.java.net or Adoptium | `javac _<task>.java` |
| Kotlin | jvm | 1.9 | kotlinlang.org | `kotlinc <task>.kt -include-runtime -d prog.jar` |
| C# | coreclr | .NET 8 | dotnet.microsoft.com | `dotnet build -c Release` |
| C# | mono | 6.12 | mono-project.com | `mcs -optimize+ <task>.cs` |
| F# | dotnet | .NET 8 | as above | `dotnet build -c Release` |
| VB.NET | dotnet | .NET 8 | as above | `dotnet build -c Release`, with a `.vbproj` instead of a `.csproj`. Same SDK as C# and F#, so no extra install. |
| Scala | jvm | 3.3 | scala-lang.org | `scalac -release 17 <task>.scala` |

One SDK covers three rows here. C# (`coreclr`), F# and VB.NET are separate compilers and
separate cells, but they all build with the .NET SDK and run on the .NET runtime, so
installing it once fills all three. VB.NET is the only one of the three that needs a
`.vbproj` rather than a `.csproj` or `.fsproj`.

### No build step — the interpreter is the runtime

These are interpreted or JIT-compiled, so there is nothing to compile and their compile
time is zero. Everything is paid at run time.

| Language | Toolchain |
|---|---|
| JavaScript | node, bun, deno |
| PHP | zend, zend + jit |
| Python | cpython, pypy, graalpy |
| Ruby | cruby + yjit, jruby |
| Lua | puc-lua, luajit |
| Perl | perl |
| R | gnu-r |
| Julia | julia |
| Dart | jit |
| GDScript | godot --headless |
| PowerShell | powershell, pwsh |
| Groovy | groovy |
| Dolphin Smalltalk | Dolphin 8 |
| Tcl | tclsh |

Two of these need more than a run command. **Dolphin** is
`Dolphin8 DPRO.img8 -u -f <task>.st -q`, the same form Dolphin's own `TestDPRO.cmd` uses.
`DPRO.img8` ships beside the installer in `userdocs/Dolphin Smalltalk 8/` and has to be
copied next to `Dolphin8.exe`. The VM is 32-bit and needs the x86 VC++ runtime,
which the installer ships as `vc_redist.x86.exe`. The installer is Inno Setup and needs
elevation, so `innoextract -e -d <dir> Dolphin8Setup.exe` unpacks it without admin, which is
how this row was verified. Scripts must write to stdout through `SessionManager current stdout`
and end with `SessionManager current quit: 0`. **Tcl** needs the `Thread` package for task 11,
which is not in the core distribution and is not in MSYS2's `mingw-w64-ucrt-x86_64-tcl`
either, so it comes from a distribution that bundles it (Magicsplat's Windows installer) or
from building `tcltk/thread` against the local Tcl. Task 03 also sources
`03_func_sum_add_one.tcl`.

Note that six of these are JITs rather than plain interpreters, and the distinction matters
for the numbers: `luajit`, `php zend + jit`, `cruby + yjit`, `dart jit`, `julia` and Dolphin all
start out interpreting and compile hot code as they run, so their first seconds are slower
than their steady state. A short task therefore measures the warm-up, not the JIT.

`Python / graalpy` needs a full GraalVM install, which is a several-hundred-megabyte download
and the slowest thing on this page to set up.

## Toolchains that need something else first

| Toolchain | Also needs |
|---|---|
| graalvm native-image | a C toolchain, `zlib` headers, and several GB of RAM. On Windows, the MSVC linker (`link.exe`) on `PATH` plus `INCLUDE`/`LIB`. |
| kotlin/native | an LLVM toolchain and a C toolchain. On Windows, a JDK **17** via `JAVA_HOME`: the launcher parses `java -version` with `delims=-.` and breaks on JDK 24, which prints `24` with no dot, leaving a stray quote in `if %_java_major_version% geq 24`. The result is a batch syntax error rather than a clear message. |
| swiftc | the Swift toolchain ships its own LLVM, needs `libcurl` and `libxml2`. On Windows it needs the MSVC toolchain to link, and `-sdk` pointing at the bundled Windows SDK. The Windows distribution is a WiX burn bundle, so a plain `--layout` copy is not enough: a `get_swift.py` (not committed, see the `tools/` note below) decompiles it with WiX's `dark.exe`, reads the burn manifest to recover the real package names (the extracted files are `a0`, `a1`, ...), stages each MSI next to its `.cab`, and administrative-extracts them. |
| nuitka | in principle a C compiler, but in practice nothing on Python 3.13: Nuitka downloads its own zig-based backend and ignores a system MinGW. `--mingw64` is rejected on 3.13 and later. |
| gdscript | a Godot build, run with `--headless` |
| lua, for task 11 only | the Lanes C extension: `luarocks install lanes`. Needs a C compiler. Stock Lua has no threads. No `luarocks` ships with the Windows binaries, so Lanes has to be built by hand. |
| clang, clang++ (Windows) | the LLVM Windows tarball ships no C headers. Either add a MinGW sysroot (`--target=x86_64-w64-windows-gnu -isystem <mingw>/include`) or install the MSVC SDK. |
| jruby | Java 25. It fails on Java 24 and older with `UnsupportedClassVersionError`; GraalVM 25 satisfies it. |
| scala | a modern `JAVA_HOME`. A Java 8 shim earlier on `PATH` (Oracle's `java8path`) makes `scalac` die with `UnsupportedClassVersionError` on class file 61.0. |
| C# nativeaot | the MSVC linker. With a hand-extracted MSVC tree, `dotnet publish` cannot find `vcvarsall` and reports `Platform linker not found`; pass `-p:IlcUseEnvironmentalTools=true` so it uses `PATH`/`INCLUDE`/`LIB` instead. |
| fpc (Windows x64) | the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, since there is no native x64 compiler. |
| odin (Windows) | `WindowsSdkDir`, `WindowsSDKVersion` and `VCToolsInstallDir` in the environment. Odin does not discover the SDK on its own; without them it fails with `Windows SDK not found`. |

## Things that are hard or not really possible

Worth knowing before starting, because these will eat a day each:

- **luajit** ships no binaries on any platform, by design: upstream makes source available
  from git only and states plainly that there are no release tarballs and that third-party
  builds should not be used. It does build on Windows, but only from source, and the build
  needs one fix: MinGW's default `PREFIX` is `C:/Program Files/Git/usr/local`, whose spaces
  break the `LUA_ROOT` define and abort the build with
  `gcc: error: Files/Git/usr/local": linker input file not found`. Pass a space-free
  `PREFIX` and it builds in about 30 seconds:
  `mingw32-make -j4 "PREFIX=C:/path/to/luajit"`. Copy `luajit.exe` and `lua51.dll` out of
  `src/`. Lua 5.4 from the official binaries is a separate row and is unaffected.
- **msvc** only exists on Windows. On a Linux or macOS host, drop the two msvc columns.
  It also does not need administrator rights, despite the installer insisting otherwise.
  The `tools/` scripts this section names are **not in this repository** (the directory is
  gitignored); the recipe below is what they do, and you would write them yourself. `get_msvc.py`
  runs `vs_BuildTools.exe --layout` to download the packages unelevated, and `reassemble_msvc.py`
  rebuilds a working `cl.exe` from them; `msvc_env.py` prints the PATH/INCLUDE/LIB it needs.
  Four things bite during that reassembly:
  - `cl.exe` fails with `C1510: Cannot load language resource clui.dll` unless the
    `...Res.base` package's `1033` locale DLLs are copied next to it.
  - `OLDNAMES.lib` no longer ships with VS 2022 17.14. The linker still asks for it, so
    build an empty one with `lib.exe /OUT:OLDNAMES.lib`.
  - `kernel32.lib`, `user32.lib` and friends live in the *Windows Store Apps Libs* package,
    not the Desktop Libs one.
  - `windows.h` is in the *Windows Store Apps Headers* package, and `winapifamily.h` in
    *Windows Store Apps Headers OnecoreUap*. The Desktop Headers package alone is not enough.
- **tcc** is unmaintained and only implements C99. It will not handle everything the other
  C compilers do.
- **gdscript** threads exist but are awkward, and Godot headless startup alone is on the
  order of a second, which will dominate every short task.

## Reference implementations

Task 14 and task 15 use a 100 MiB fixture, and every expected output in this benchmark was
computed independently. Keeping those reproducible needs:

- a C compiler, for the reference implementations
- Python 3.10 or newer, for the fixture generator

Both are already covered above. Note that neither the generator nor the reference
implementations are committed: the repository holds the three documents and `sources/` only.
`data.bin` is 409600 copies of the byte cycle 0..255, which is the whole specification.
