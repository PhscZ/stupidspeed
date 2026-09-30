# Build requirements

What has to be installed to turn each task's source into something runnable.
For what has to be installed to *run* the result, see `RUN.md`.

Convention below: `<task>` is the task's own name, so the source for task 01 in C is
`sources/c/01_branches.c`, and the output is `prog`. Add the thread flag where a language
needs one, because task 11 uses four threads.

Fourteen things do not follow the flat `<task>.<ext>` layout, and each says why:

- **C#, F# and VB.NET** keep a folder per task (`01_branches/01_branches.csproj`) because the
  .NET SDK does not support several projects in one directory: `dotnet build` with no project
  argument fails when the folder holds more than one `.csproj`, and the projects would share
  one `obj/` and `bin/`.
- **Fortran task 03** is two files, `03_func_sum.f90` and `03_func_sum_add_one.f90`, because
  the no-inline requirement needs a second translation unit.
- **Modula-2 task 03** is three files, `03_func_sum.mod`, `Func.def` and `Func.mod`, for the
  same reason: the caller only sees the declaration, so the 100000000 calls cannot be
  inlined. Compile `Func.mod` first and link both objects.
- **GDScript** has one shared `sources/gdscript/project.godot` beside the 15 `.gd` files. It
  is what `godot --headless --script <task>.gd` resolves against, and its
  `run/print_header=false` is what keeps the output to the single expected line. The key is
  the setting path minus its first component, so it must be `run/print_header` under
  `[application]`; `config/run/print_header` is not a registered setting and leaves the
  engine's version banner on stdout.
- **Tcl task 03** is two files, `03_func_sum.tcl` and `03_func_sum_add_one.tcl`, because the
  proc has to live in another file to be a real cross-file call; the main file `source`s it.
- **Vala task 03** is two files, `03_func_sum.vala` and `03_func_sum_add_one.vala`, for the
  same reason as Fortran's and Tcl's: Vala has no no-inline attribute (`[NoInline]` is rejected
  as "attribute never used"), and a same-file `add_one` keeps external linkage in the generated
  C, so `gcc -O2` is free to inline it at its single call site. valac emits one C file per Vala
  file, so passing both names makes them two translation units.
- **Oberon-07 task 03** imports `AddOne.ob07` instead of carrying a `_03_func_sum_add_one`
  name: the compiler requires an imported module's name to equal its file name (error 23), and
  Oberon identifiers are `letter {letter|digit}`, so `_03_func_sum_add_one` is not a legal
  module name. `AddOne` is named after the procedure it exports. It
  needs no separate compile step — the import pulls it in.
- **Beef** keeps a directory per task (`01_branches/01_branches.bf`) because BeefBuild builds
  *projects*, not files: a workspace is a `BeefSpace.toml` naming its projects, a project is a
  `BeefProj.toml` naming its sources and its `StartupObject`, and `-proddir=` points at the task
  directory. Each task therefore carries a two-file wrapper beside its source. Task 03 is three
  files: `03_func_sum.bf`, `03_func_sum_add_one.bf` and the wrapper that lists both.
- **Haxe** needs `T01_branches.hx` … `T15_file_write.hx`, because a Haxe module's type name must
  equal its file name and start with an uppercase letter — the lexer's `idtype` is
  `'_'* 'A'..'Z' (alnum|'_')*` — so neither `01_branches.hx` nor `_01_branches.hx` is a legal
  module.
- **Eiffel** needs `t01_branches.e` … `t15_file_write.e`, holding classes `T01_BRANCHES` …
  `T15_FILE_WRITE`: an Eiffel class name cannot start with a digit, and the convention is one
  class per file named after the class. Task 03's helper is therefore `add_one.e`, not
  `03_func_sum_add_one.e`.
- **Octave task 03** loads `add_one.m` instead of carrying a `_03_func_sum_add_one` name: Octave
  resolves a call to `add_one()` by looking for `add_one.m` on the load path, so a file named
  `03_func_sum_add_one.m` would define a function no call could reach.
- **Scala native** shares `sources/scala/` with the `jvm` row rather than getting a directory of
  its own: the fifteen files are one source set built by both rows, the same arrangement
  `sources/kotlin/` has with `kotlin/native`, because Scala Native 0.5.x's `javalib` implements
  every JDK type those files use (`java.lang.Thread`, `java.math.BigInteger`, `java.io`).
- **Scheme, Prolog (SWI), Janet, Ring, JScript, AutoHotkey, VHDL and Seed7 task 03** each keep the
  helper in a second file beside the task — `03_func_sum_add_one.ss`, `.pl`, `.janet`, `.ring`,
  `.js`, `.ahk`, `.vhd` and `.s7i` — which is the same shape as the Fortran, Tcl, Vala and
  Oberon-07 entries above, so it is one case here and not eight. Two of the eight are shape
  rather than necessity: Seed7 has no no-inline marker at all, and `s7c` emits one C translation
  unit whatever the file split, so its helper is inlined anyway; and AutoHotkey has no inlining
  pass to defeat, so its `#Include` split is the row's cross-file convention. Neither row claims
  a real call on that account. **Terra, Nelua and Standard ML task 03** join this group with
  `03_func_sum_add_one.t`, `.nelua` and `.sml`. Terra and Nelua have real no-inline facilities
  (`setinlined(false)` and `<noinline>`), and both need them *as well as* the file split — Terra
  inlines a plain cross-file call and then deletes the loop, and Nelua concatenates every
  required module into one C translation unit, so the same thing happens. Standard ML has no
  per-function marker at all and needs `PolyML.Compiler.maxInlineSize := 0` set before the
  helper is loaded, because a separate file alone is not enough there either.
- **Standard ML** keeps a build driver per task, `build/<task>.ML`, holding
  `use "<task>.sml"; PolyML.export ("<task>", main);`, because the MSI ships no `polyc` and the
  two steps it would have driven are run by hand (see the toolchain table). The task sources
  themselves are flat: `01_branches.sml` … `15_file_write.sml`.

Swift is flat like everything else: `swiftc -O -o prog <task>.swift`. The rule that top-level
code needs a file called `main.swift` only applies when several files are passed in one
invocation, where `swiftc` has to pick which one holds `main`; with a single file there is
nothing to pick, so the name is free.

Java, D, Nim, Ada, Eiffel, Haxe, Component Pascal and Oberon-07 prefix the name
(`_01_branches.java`, `_01_branches.d`, `_01_branches.nim`, `t01_branches.adb`,
`t01_branches.e`, `T01_branches.hx`, `_01_branches.cp`, `_01_branches.ob07`), because those
languages tie the file name to an identifier and a digit cannot start one — in Haxe's case the
identifier must additionally start with an uppercase letter, which is why its prefix is `T` and
not `_`. In Component Pascal and Oberon-07 the compiler enforces the tie — the
`MODULE` name must equal the file name — so the underscore is mandatory there, not merely
conventional.

A toolchain whose source genuinely differs from its language's main toolchain gets a folder of
its own rather than a suffixed file beside the shared one. There is one such case today:
`sources/kotlin-native/`, which holds the three Kotlin/Native files (tasks 11, 14 and 15) that
cannot use `java.lang.Thread` or `java.io`. The other twelve tasks are one source shared by
both Kotlin rows and stay in `sources/kotlin/`, so those twelve are built from `kotlin/` for
either row and only the three are built from `kotlin-native/`.

The version column is the **minimum** that works, not the newest release. Anything
reasonably recent works; it is what the task actually needs, not what happens to be current.

## Host

Builds assume **x86-64**, on Linux, macOS or Windows. `msvc`, `jscript` and `autohotkey` are
the Windows-only toolchains — the last two because `cscript.exe` and the AutoHotkey interpreter
are Windows components and there is no other platform's build of them — and every other row
builds on Windows too, including `flang` and `luajit`. The one row that is *not* portable is
`assembly`: it is a freestanding ELF64 binary built with `nasm -f elf64` and `ld`, so it is
Linux x86-64 only. See `RUN.md` for the full platform breakdown.

Disk: **31 GB measured** for all 96 toolchains, installed and run on one Windows x64 host.
The heavy terms are LLVM (4.0 GB), Swift (3.2 GB), the AIR SDK (1.6 GB), GNAT with its MSYS2
runtime (1.8 GB, which also supplies `flang`), MSVC (1.2 GB once reassembled from a 2.5 GB
layout), Julia (1.1 GB), Perl (1.0 GB), the .NET SDK (0.7 GB) and GraalVM (0.7 GB); most other
rows are 0.1-0.6 GB.
An earlier batch of six rows added about 2.4 GB between them, and one term dominates: an MSYS2
tree with the UCRT64 toolchain, `valac` and its GLib/GObject/GTK build dependencies (**2.2 GB**).
The rest are small — `c3c` with its shipped standard library and LLVM shim (79 MB), GPCP for
.NET (24 MB), the Algol 68 Genie source tree (20 MB), and Cim, the Oberon-07 compiler and the
installed a68g at a few MB each. The AIR SDK is large because it carries a runtime for every
target it supports; the packaging step copies only the one it needs, so each built bundle is
about 60 MB of runtime plus the program.
The four rows after that are small: OCaml (the MSYS2 `ocaml` and `flexdll` packages, a few
hundred MB inside the MSYS2 tree already counted above for Vala), SBCL (54 MB, extracted from
its MSI), Racket Minimal (74 MB extracted), and the three Clojure jars (4.7 MB).
The fourteen newest rows add about 6.5 GB, and two of them are nearly all of it: **Octave at
3.2 GB** — a 459 MB `.7z` whose 2.6 GiB payload is unpacked beside it, plus what
`post-install.bat` adds — and **Eiffel at 1.14 GB**, extracted from a 139 MB `.7z` with a
further 32 MB per target of `EIFGENs` once built. The rest are moderate or small —
Beef 845 MB, the Scala Native pair (scala-cli 131 MB plus the portable llvm-mingw 675 MB, and
27 MB of Scala Native artifacts in the package cache), the SWI-Prolog tree 133 MB, Haxe with
Neko and hxcpp 112 MB, GHDL 72 MB, the Seed7 tree 65 MB (from a 47 MB source tree, once its
build objects exist), Ring 19 MB, J 16 MB, Janet 8 MB, Chez Scheme 7 MB and AutoHotkey 4.4 MB.
The four rows after those add about 1.3 GB and are dominated by one term: **Dyalog at 855 MB**,
whose Windows distribution is an interpreter tree rather than a single binary (the 20.0 zip is
256 MB and the extracted tree carries the interpreter, the SALT library and the .NET bridge).
The rest are small: **Terra at 403 MB** — a 61 MB `.7z` holding a 341 MB tree whose `terra.exe`
is 158 MB because LLVM 22.1 and clang are inside it — then **Poly/ML at 11 MB** (the MSI's whole
payload is three files, plus the tarball's stub and a 187 KB import library) and **Nelua at
6 MB**, which is the git repository and its 502 KB self-built interpreter. Terra needs no MSVC
and no Windows SDK, and Nelua's interpreter is 502 KB because it is the repository's own
`src/onelua.c` build, not a separate Lua install.
Budget another 2-3 GB of scratch space while reassembling MSVC and Swift, since both go
through a multi-gigabyte download that is deleted afterwards. Package caches do not count and
can be far larger than the toolchains themselves.

Beware one installer that quietly pulls in more than the toolchain: Alire's `alr toolchain`
bootstraps a full MSYS2 (about 450 MB) plus the GNAT release, and the `alr` assistant runs
that download as a side effect of `--help`. That MSYS2 is not wasted: its `ucrt64` repository
is the practical way to get a working `flang` on Windows.

## Toolchains

### Compiled to native code — nothing needed at run time

The output is a native executable in every row below, and for most of them that executable needs
nothing but the operating system. Three rows are exceptions and say so in their own entry: Vala's
binary imports `libglib-2.0-0.dll` whenever the code touches GLib, COBOL's imports `libcob-4.dll`,
and Standard ML's needs `PolyLib.dll` beside it — in that last case the exported `.obj` is a whole
heap image and the DLL is the runtime that loads it, so the pair has to travel together.

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
| Modula-2 | adw | 1.6.879 | modula2.org/adwm2 | Two steps, not one. `m2amd64.exe /sym:<ADW>\ASCII\winamd64sym <task>.mod` compiles, then `sblink.exe /machine:amd64 /out:prog.exe <module>.obj rtl-win-amd64.lib win64api.lib <module>.lib` links. `/machine:amd64` is mandatory: the default linker machine type rejects the 64-bit object with `Incorrect Machine Type`. The compiler writes the `.obj` **beside the source file**, not into the working directory, and names it after the `MODULE`, not the file. Copy the source into a scratch directory first or the repo fills up with objects. Task 03 compiles `Func.mod` first and links `Func.obj` as well, because its `AddOne` has to live in a separate module. |
| Modula-3 | cm3 | 5.10.0 | github.com/modula3/cm3 | `cm3 -build -O` in a directory holding `Main.m3` and an `m3makefile`. Needs the MSVC environment for its C backend, and writes the binary to `AMD64_NT\prog.exe`. Task 10 also needs `import("arithmetic")` in the m3makefile for `BigInteger`. |
| COBOL | gnucobol | 3.2 | MSYS2 `ucrt64`, or gnucobol.sourceforge.io | `cobc -x -O2 -o prog <task>.cob`. `PIC 9(18) COMP-5` is the exact 64-bit picture, and COMP-5 keeps the full binary range regardless of the PICTURE, so limb arithmetic fits in one COMPUTE. Outside an MSYS2 shell, `cobc` needs `COB_CONFIG_DIR` and `COB_COPY_DIR` set to the package's `share/gnucobol/{config,copy}` or it stops with `configuration error: /ucrt64/share/gnucobol/config/default.conf`. Task 11 needs `CBL_GC_FORK`, which GnuCOBOL documents as unavailable on Windows outside Cygwin: it returns -1 there and the program falls back to four in-process quarters, so the answer is right but the row is single-core on Windows and four-way on Linux. |
| BASIC | freebasic | 1.10.1 | freebasic.net | `fbc -O 2 -x prog.exe <task>.bas`. `-x` names the output, so the source file name must come after it; `-x <task>.bas` alone would write the executable over the source. `LONGINT` is the 64-bit type; `THREADCREATE` gives real threads for task 11. Task 03 also compiles `03_func_sum_add_one.bas` on the same command line. |
| V | v | 0.5.2 | vlang.io | `v -prod -cc x86_64-w64-mingw32-gcc -o prog <task>.v`. V compiles through a C backend, so it needs a C compiler; `-cc` picks it. Task 03 keeps `add_one` in the same file with `@[noinline]`, V's own no-inline facility, which the generated C carries over as `__attribute__((noinline))`. |
| ATS | ats | 0.4.2 | ats-lang.org, or SourceForge `ats2-lang` | Built from source under Cygwin: `./configure && make -f Makefile_dist all`. GCC 14 rejects the 2014-era bootstrap C, so `src/CBOOT/Makefile` needs `CFLAGS += -fpermissive -Wno-implicit-function-declaration -Wno-int-conversion -Wno-implicit-int` first. That is enough to get `patsopt` and `patscc`; `make all` then fails on `utils/myatscc`, which is a build utility and not needed. `patscc -DATS_MEMALLOC_LIBC -O2 -o prog <task>.dats`. Task 03 needs `ATS_DYNLOADFLAG 0` on the helper unit, or the separate compilation gets optimised away. |
| C3 | c3c | 0.8.4 | github.com/c3lang/c3c releases | `c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog <task>.c3`. `-O0` is the default and `-O2` is the first level that turns off bounds and null checks, so `-O2` is the flag the task wants; `int` is 32 bits, so the 100-million counters are `i64` and task 02's total does not fit in `int`. On Windows c3c links through `lld-link` and wants the MSVC SDK: it will offer to **download** one if it cannot find one, which needs no admin but is a large fetch. The hand-extracted tree under `tools/msvc` works with `--win-sdk "…/Windows Kits/10"` plus one `-L` per library directory (the MSVC `lib\x64`, the SDK `ucrt\x64` and the SDK `um\x64`); `--win-vs-dirs` does **not** accept that tree. `-o prog` already yields `prog.exe` — passing `-o prog.exe` produces `prog.exe.exe`. Task 11 uses the standard library's `std::thread` module (`Thread.create` / `Thread.join`); task 10 hand-writes the limbs, because the standard library's `std::math::bigint` is 8192 bits (about 2466 decimal digits) and 10000 digits do not fit. |
| Vala | valac | 0.56 | MSYS2 `ucrt64` on Windows, distro package elsewhere | `valac -X -O2 -o prog <task>.vala`, run from the MSYS2 UCRT64 shell. `valac` translates to C and drives `gcc`; `-X -O2` is what hands `-O2` to that gcc, and without it the generated C is compiled unoptimised. The build needs `valac` plus GLib's development files (`pkg-config` resolves them). The generated binary imports `libglib-2.0-0.dll` **whenever the Vala code touches GLib**, which is most of these tasks, so those executables need the UCRT64 `bin` directory on `PATH` at run time; the few tasks that call no GLib function at all link nothing extra and run with a bare system `PATH`. Each file's header says which case it is. Static linking (`-X -static`) fails and is not used. Task 03 also compiles `03_func_sum_add_one.vala` on the same command line, because Vala has no no-inline attribute. Task 11 uses `GLib.Thread<int64?>` with a lambda, joined in spawn order; task 10 hand-writes the base-10^9 limbs, since GLib has no big integers. |
| Simula | cim | 5.1 | ftp.gnu.org/gnu/cim | GNU Cim compiles Simula to C and then to native code, so it needs a C compiler and its own runtime library. Built from source under Cygwin: `./configure --prefix=<dir> CFLAGS="-O2 -w -std=gnu89 -fpermissive" LDFLAGS="-s" && make && make install`. The 2013-era C does not build under a default `-std=gnu17`, hence `-std=gnu89`; the install puts `cim.exe` in `bin/` and the runtime in `lib/libcim.a`, and `cim.exe` is a Cygwin program that drives the system gcc. `cim -q -o prog <task>.sim` compiles and links in one step. **The memory pool has to be set on the compiler command line** — `-m12`, `-m128` — or an 8 MB array aborts with `Alloc: Virtual memory exhausted`; the compiled program's own `-mN` option is ignored by this build. Task 03 needs no no-inline marker: every Simula procedure compiles to a separate C function reached through the runtime dispatcher, so gcc cannot inline it. Task 11 uses Simula's own process simulation, the `SIMULATION`/`PROCESS` part of the language's standard application package: four `PROCESS` objects started with `ACTIVATE`, yielding with `HOLD(0)` and waited for with a plain `HOLD`. It is cooperative and green — one OS thread, and `nm` on `libcim.a` lists no `pthread_*`, `_beginthread` or `CreateThread` symbol at all — so the four interleave but never run at once, and the cell is a correct-answer-no-speedup one. The workers split each quarter into four chunks with a yield between chunks, which is what makes the interleaving real; the arithmetic and the accumulation order are unchanged. |
| Oberon-07 | akron | 1.69 | github.com/AntKrotov/oberon-07-compiler | The repository ships a ready 64-bit Windows `Compiler.exe`, no build needed. `Compiler.exe <task>.ob07 win64con -out prog.exe`, run from the directory holding the source (the compiler resolves the file name against the process working directory) with `lib\Windows\` beside it. It has **no optimisation switch**: its x86-64 code generator has no unoptimised mode, so the plain build line is the whole story, and `-nochk a` is not used because turning off the range and type checks changes what a program means. `INTEGER` is 64 bits. No task 11 problem: the shipped library has no thread module, but the compiler's own `[convention, "dll", "proc"]` foreign declaration imports `CreateThread` and `WaitForSingleObject` from kernel32 directly, which is how its `Out`, `File` and `WINAPI` modules are built — the same hand-rolled route the Assembly row takes with `clone` and `futex`. The start routine must be declared `PROCEDURE [windows]` with a matching `PROCEDURE [windows] (p: INTEGER): INTEGER` type, or the ABI is wrong and the thread never returns. |
| Beef | BeefBuild | 0.43.5 | beeflang.org/setup, `BeefSetup_0_43_5.exe` (259 MB) extracted with 7-Zip, not installed — no admin | `tools/beef/bin/BeefBuild.exe -proddir=sources/beef/<task> -config=Release -platform=Win64`, then `sources/beef/<task>/out/prog.exe`. **`-config=Release` is mandatory**: Beef's Windows Debug toolset is Microsoft's and stops without Visual Studio, while Release links with the bundled `lld-link.exe`. Every project wrapper also sets `CLibType = "SystemMSVCRT"`, because the Release default asks for MSVC's static CRT. `corlib` is recompiled once per project on every build, so a task takes 11-23 s. |
| Haxe | hxcpp | 4.3 | haxe.org win64 zip, plus `neko` for `haxelib` and a 64-bit MinGW `g++` | `haxe -cp sources/haxe -main T01_branches -cpp temp/haxe/01_branches -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs`, then `<outdir>/T01_branches.exe`. `haxe -cpp` writes C++ and runs `haxelib run hxcpp`, which drives `g++` and `windres`; `-D no_shared_libs` is what makes the link static. `MINGW_ROOT` is not optional — hxcpp guesses `c:/MinGW` and otherwise stops with `Could not guess MINGW_ROOT`. |
| Eiffel | eiffelstudio | 25.12 | ftp.eiffel.com/pub/download, win64 `.7z` (139 MB) extracted — no admin, no activation | `ec -batch -finalize -c_compile -config stupidspeed.ecf -target tNN`, run from `sources/eiffel/`; the executable is `EIFGENs/<tNN>/F_code/prog.exe`. `-finalize` is the optimisation — EiffelStudio has no `-O` level, its knob is the compilation mode (`-melt`, `-freeze`, `-finalize`). The delivery ships its own MinGW gcc 4.4.5, so no MSVC is needed. One ECF carries all 15 targets, and only task 11 sets the concurrency capability to `thread`. |
| Seed7 | s7c | 2026-07-11 (interpreter 5.4.10, s7c 3.5.10) | source release `seed7_05_20260711.tgz` (4.5 MB), built with MSYS2's MSVCRT MinGW gcc: `cp mk_msys.mak makefile`, `make -f mk_msys.mak depend`, `make -f mk_msys.mak`, `make -f mk_msys.mak s7c` | `s7c -O2 prog.sd7` -> `prog.exe`. **There is no output-name flag**: s7c names the executable after the source file and writes it beside the source, so the build copies the task to `prog.sd7` in a scratch directory first. `-O2` is required — without `-O` s7c passes no optimisation flag to the C compiler it drives. |
| Scala | native | 0.5 (0.5.12 measured) | scala-cli plus a C toolchain; on Windows the portable llvm-mingw zip, no admin | `scala-cli --power package <task>.scala --native -S 3.9.0 --native-version 0.5.12 --native-mode release-fast --native-clang <llvm-mingw>/bin/clang.exe --native-clangpp <llvm-mingw>/bin/clang++.exe --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe`, then `prog.exe`. Builds `sources/scala/`, the same fifteen files as the `jvm` row. `--native-mode release-fast` is mandatory: the default `debug` mode compiles with `-O0` and measured 0.270 s against 0.074 s on task 02. |
| Standard ML | Poly/ML | 5.9.1 | github.com/polyml/polyml releases, `PolyML5.9.1-64bit.msi` (3.03 MB), extracted with `msiexec /a <msi> TARGETDIR=<dir> /qn` — no admin. **v5.9.2 is newer but has no Windows asset at all**; 5.9.1 is the one. | Two steps, and they are the two `polyc` would have driven, because the MSI ships no `polyc` and no import library (see below): `PolyML.exe -q --error-exit --script build/<task>.ML` exports a whole heap image to `<task>.obj`, where the driver file contains `use "<task>.sml"; PolyML.export ("<task>", main);`, then `gcc -Wl,-u,WinMain -mconsole -o prog.exe <task>.obj polystub.obj -Ltools/polyml -lpolyml`. **`PolyLib.dll` must sit beside the produced executable** or it dies before `main` with `STATUS_DLL_NOT_FOUND` and no output. Task 03 loads `03_func_sum_add_one.sml` with `use` and sets `PolyML.Compiler.maxInlineSize := 0` **before** it — a separate file alone is not enough. Task 14 reads in 65536-byte chunks. |
| Nelua | nelua | 0.2.0-dev (`a5845056`) | `git clone --depth 1 https://github.com/edubart/nelua-lang tools/nelua` (6 MB, no installer, no admin), then build the repository's own Lua interpreter once: `mingw32-make` in `tools/nelua/`, which compiles `src/onelua.c` with its `lfs`, `hasher` and `lpeglabel` companions into `nelua-lua.exe` (24 s). The host's own Lua cannot run the compiler: `runner.lua` requires those three C modules and there is no `luarocks` here to add them. | `cmd.exe /c tools/nelua/nelua.bat -r -o prog.exe <task>.nelua`, run from `sources/nelua/` — the launcher has to go through `cmd.exe`, and `require` resolves against the **working directory**, not the source file's, so the build must run from the row's directory (`-L sources/nelua` also works). `-r` (`--release`) is this compiler's `-O2` equivalent, literally `gcc ... -fwrapv -fno-strict-aliasing -O2 -DNDEBUG`, and it also turns on the compiler's `nochecks` pragma; `-M`/`--maximum-performance` is deliberately not used because it adds `-Ofast -march=native -flto=auto`. Task 03's helper is in its own file **and** marked `<noinline>`: Nelua concatenates every required module into one C translation unit, so a plain cross-file call is inlined and the loop is deleted. |

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
| Scala | jvm | 3.3 | scala-lang.org | Two steps: `scalac -release 17 -d out <task>.scala`, then `java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main`, where `<scala>` is the distribution and `<v>` its version. **Scala CLI's `scala` is a subcommand runner, not the classic `scala Main` launcher**, so it rejects `scala Main` with `Main is not a scala sub-command`; running the compiled class through `java -cp` is the equivalent and it also keeps the launcher's own start-up out of the measurement. The compiler needs a JDK 17 or newer on `PATH`. |
| Component Pascal | gpcp | 1.4.08b3 | github.com/k-john-gough/gpcp releases | Gardens Point Component Pascal for .NET, `gpcp-NET1.4.08b3.zip`, expanded anywhere. `gpcp /list- _<task>.cp` compiles a module to an assembly named after the `MODULE`; `/list-` only suppresses the `.lst` file and there are no optimisation levels. It needs `CROOT` pointing at the expanded tree, `%CROOT%\bin` on `PATH`, and `CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem` — the leading `.` is not decoration: without it the compiler cannot find the helper module that task 03 builds in the same directory, and without the `NetSystem` entry no `mscorlib` type is visible. The file name must equal the `MODULE` name, so the row uses `_<task>.cp`. The .NET runtime is needed on every run (see `RUN.md`), and `RTS.dll` plus any `GP*Files.dll` the module imports must be copied next to the executable — they are not found on `PATH`. Task 03 is two modules, `_03_func_sum_add_one.cp` and `_03_func_sum.cp`, compiled in that order, because Component Pascal has no no-inline marker and the call has to cross an assembly boundary. Task 11 uses the foreign `mscorlib_System_Threading` module: `Th.ThreadStart` is already a delegate type, so `REGISTER(s, w.Run)` attaches a bound method to it and `Th.Thread.init(s)` / `Start` / `Join` give four real .NET threads. Task 10 hand-writes the base-10^9 limbs with `LONGINT`; nothing in the shipped symbol files is arbitrary-precision. |
| SystemVerilog | iverilog | 13.0 | MSYS2 UCRT64 `mingw-w64-ucrt-x86_64-iverilog` | Two steps: `iverilog -g2012 -o prog.vvp <task>.sv` compiles to a vvp file, then `vvp prog.vvp` runs it. **`-g2012` is required** — plain Verilog has no automatic functions, so a recursive function shares one static frame and returns wrong answers (`fib(10)` measures as -80 instead of 55), which is why the row is SystemVerilog and why no Verilog row exists. Task 03's helper is a second file at compilation-unit scope and must be listed **first** on the command line; reversed, Icarus fails at run time with no diagnostic. Two further Icarus limitations shape the sources: `buf` is a reserved word and cannot be an identifier, and package-qualified calls are rejected. `$finish(0)` is used rather than a bare `$finish`, because Icarus prints a "$finish called at" line to stdout for the latter and the task must print one line and nothing else. |
| VHDL | ghdl | 6.0.0 | github.com/ghdl/ghdl releases — `ghdl-mcode-6.0.0-ucrt64.zip` (22.6 MB, sha256 76e160ce…, extract anywhere, no admin, standalone: no MSYS2 needed); or MSYS2 UCRT64 `mingw-w64-ucrt-x86_64-ghdl-mcode` | Two steps. `ghdl -a --std=08 <task>.vhd` analyses into the work library, then `ghdl -r --std=08 <unit>` elaborates, JIT-compiles and runs. The **mcode backend generates no output file** — its `-e` "does not generate anything" and the run command elaborates the design itself — so the measured run includes elaboration and code generation, and there is no optimisation flag to set because the backend has none. `--std=08` is required (`std.env`, `numeric_std`) and mcode must be given the same options at analysis and run. Task 03 analyses `03_func_sum_add_one.vhd` **first**; reversed, the analysis fails with `unit "add_one_pkg" not found in library "work"`. |
| OCaml | ocamlopt | 5.0 (5.4.1 measured) | MSYS2 UCRT64 `mingw-w64-ucrt-x86_64-ocaml`, plus `mingw-w64-ucrt-x86_64-flexdll` | `ocamlopt -unsafe -o prog.exe _<task>.ml`. **Version 5 is required**: the 4.14 toolchain that the old "OCaml for Windows" installer ships has no `Domain` module and serialises `Thread`, so task 11 could only be a correct-answer-no-speedup cell there. `-unsafe` drops array and string bounds checks, which is the usual speed knob; `-O3` is accepted but is a **no-op** unless the compiler was built with Flambda, and the MSYS2 package reports `flambda: false`. Two environment details are mandatory and neither is obvious. `OCAMLLIB` must be set to the **Windows** form of the stdlib directory (`C:\...\ucrt64\lib\ocaml`), because `ocamlopt` is a native Win32 binary and the MSYS2-style `/ucrt64/...` path baked into its config resolves to nothing — without it every compile fails with `Unbound module Stdlib`. And `flexdll` is a **separate package**; without it the link step stops with `'flexlink' is not recognized`. Filenames carry the row's `_` prefix because OCaml derives a module name from the file name and a module name must be a valid identifier, so `01_branches.ml` draws `Warning 24: bad source file name`. Task 03 uses `[@inline never]`, OCaml's own no-inline attribute, so it needs only one file. Task 10 hand-writes the base-1e9 limbs in `int64`: the standard library has no bignum, and `zarith` is not in MSYS2's UCRT64 repository. Task 11 uses `Domain.spawn`/`Domain.join`. |
| ActionScript | AIR | 51.4.1 | AIR SDK from harman.com/developer/air | Two steps. `amxmlc -swf-version=51 -output prog.swf _<task>.as` compiles the AS3 to a SWF, then `adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf` packages it into a standalone `out\prog.exe` with the AIR runtime bundled beside it. Use **`amxmlc`, not `mxmlc`**: only `amxmlc` links against `airglobal.swc`, so the AIR-only APIs this row needs (`System.output`, `flash.filesystem`, `Worker`) do not exist under the plain Flex compiler. A JDK (17 works) has to be on `PATH` for both tools. `adt` refuses to package an unsigned bundle, so one self-signed certificate is generated once with `adt -certificate -cn SelfSigned 2048-RSA test.p12 pass` and reused by every task. **The signing options must precede `-target`**: `adt` scans for them in order and otherwise stops with `Found misplaced signing arguments`, and the application descriptor has to be the literal `app.xml` path rather than the class name or it reports `error 301: Application descriptor missing`. Class names carry the row's `_` prefix because AS3 requires the public class name to equal the file name and a file cannot start with a digit. One shared `app.xml` sits beside the fifteen `.as` files, the way GDScript's `project.godot` does, because every task compiles to `prog.swf` and packages to `prog.exe`; only the `.as` name changes between tasks. Task 11 is two translation units: `_11_parallel_sum_worker.as` compiles separately to `worker.swf`, which the `adt` line passes as an extra file so it lands in the bundle and the main SWF can load its bytes for `createWorker`. Task 14's `data.bin` is passed to `adt` the same way — see the note below on why. |

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
| Algol 68 | a68g |
| Clojure | clojure.main |
| Racket | racket (CS) |
| Common Lisp | sbcl |
| VBScript | cscript |
| Raku | rakudo (MoarVM) |
| Erlang | OTP (escript) |
| Elixir | elixir (BEAM) |
| Scheme | chez |
| Prolog (SWI) | swipl |
| Octave | octave-cli |
| J | jconsole |
| Janet | janet |
| Ring | ring |
| JScript | cscript (WSH) |
| AutoHotkey | v2 |
| Terra | terra |
| Dyalog APL | dyalog |

Eighteen of these need more than a run command.

**Dolphin** is
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

**Algol 68 Genie** is `a68g <task>.a68`, and it is a compiler-interpreter: no build step, but
one task needs a flag and one needs a different build. Task 06 runs as
`a68g --heap 1900000000 06_char_count.a68`, because a CHAR is 16 bytes in this interpreter (a
status word plus the value) and the default 65 MB heap cannot hold the 100-million-character
text. Task 11 needs a build with the parallel clause enabled: the
prebuilt Windows binary on the project's download page is built **without** it and answers
`interpreter was built without parallel-clause support`; `./configure --enable-parallel` from
the source tarball turns it on, and the source's own `configure.ac` disables it again for any
host it does not recognise (`HAVE_UNTESTED`), so the Cygwin build is the one that works.
`a68g` also carries an arbitrary-precision `LONG LONG INT` mode, but it was measured and
**rejected for task 10**: its cost is linear in the `PR precision=` setting, and 1000 digits
need a spigot state of about 11232 digits, so the precision would have to be set to roughly
30000 (200-digit spigot: 1 s at precision 4000, 4 s at 20000, 37 s at 150000, which is the
linearity the mode is rejected for). Task 10 therefore hand-writes the base-1e9 limbs in
`LONG INT` arrays, like every other row, and hoists each row reference out of its loop (worth
another 13-18%). It is still quadratic in the digits and still the slowest cell in the matrix:
a68g is about 900x slower per limb operation than the C reference, which does the same 1000
digits in **0.6 s** on this machine, so a68g extrapolates to roughly **7.5 minutes** for the
run. See `RUN.md` for what that means for the cell.

**Clojure** is three jars and no installer: `clojure-1.12.0.jar`, `spec.alpha-0.5.238.jar` and
`core.specs.alpha-0.4.74.jar`, all from Maven Central, about 4.6 MB together, used in place
from a directory. `clojure.main <task>.clj` then loads the file, compiles it to JVM bytecode as
it runs and executes it, so the compile time sits inside the measured number rather than
happening once up front the way `javac` does for the Java row. The classpath needs the three
jars and, on Windows, `;` between them. The Clojure CLI is deliberately **not** used: it
resolves dependencies at run time, which would make the row depend on a warm local Maven
repository, and its own Windows install script is marked unsupported and now points at WSL.

Two things in the sources are load-bearing rather than stylistic. `(set! *unchecked-math* true)`
with `^long` hints on every loop binding is what keeps the arithmetic on primitive longs: an
unhinted `(loop [i 0] ...)` boxes on every iteration, which is roughly the difference between a
loop that is near Java speed and one an order of magnitude slower. And task 11 uses raw
`java.lang.Thread` interop rather than `future`, because `future`'s executor threads are
non-daemon and the JVM would not exit after printing without an explicit `(shutdown-agents)` —
a timed run would simply hang. Task 10 needs none of the hand-rolled limb machinery the other
rows use: Clojure's `+'` and `*'` are exact at any size and promote to a `BigInt` only on
overflow, so it is a built-in-bignum row, like Python's.

**Racket** ships no installer that works without admin — its Windows `.exe` is an NSIS package
that writes `HKLM` and the Start menu, so it wants elevation — but the **Minimal Windows x64
`.tgz`** (39 MB) is a plain tarball with a single top-level `racket/` directory, and extracting
it is the whole installation. Minimal ships `base`, `racket-lib` and `racket/place`, which is
everything this row needs; the one thing it lacks is `compiler-lib`, so `raco make` and
`raco exe` are unavailable, and neither is needed because `Racket.exe <task>.rkt` compiles the
module on every run and that compile time is part of the measured number. Two details matter:
the tree has to move as a unit, because the DLL directory and the `collects` directory are
embedded as paths relative to the executable, and it has to be `Racket.exe`, the console
launcher — `GRacket.exe` is the GUI-subsystem build of the same runtime and its output never
reaches a console. The row uses `#lang racket/base` rather than `#lang racket`, which is
Racket's own documented way to start faster, and `racket/fixnum` for the packed
`fxvector` arrays (that module, not a `racket/fxvector`, is where `make-fxvector` lives).

Racket's parallel story needs care, because two of its three mechanisms do not parallelise.
`thread` is green: cooperative, on one OS thread, no speedup. `future` is real parallelism only
while its body stays future-safe, and the manual's own example shows futures silently
serialising once the body blocks. `racket/place` does give real parallelism — each place is a
separate Racket VM instance, all inside the one OS process — but it was measured and rejected
for this row: four places cost about **6.2 GB of resident memory** and the task took roughly six
minutes, because each place instantiates a whole VM. What the row uses instead is
`(thread thunk #:pool 'own #:keep 'results)`, which puts each thread on its own OS thread with
the heap shared and makes `thread-wait` return the thunk's value; the same work then takes about
a second. That form needs Racket 8.18 or later.

**Common Lisp** is SBCL, whose only Windows x86-64 binary is a per-machine MSI — it installs
into `Program Files` and writes an `HKLM` `PATH` entry, so `msiexec /i` wants elevation. The
no-admin route is `msiexec /a <msi> TARGETDIR=<dir> /qn`, an administrative extract that unpacks
the payload without installing anything: `sbcl.exe`, `sbcl.core` and `contrib/`, which then run
in place with `SBCL_HOME` pointing at the directory. The build is
`sbcl --load <task>.lisp --eval "(sb-ext:save-lisp-and-die \"prog.exe\" :executable t :toplevel
(function main) :application-type :console)"`, which dumps a standalone executable once so the
timed runs pay only the core's start-up and not the reader and compiler as well;
`sbcl --script <task>.lisp` is the development form and re-reads the source every run. Two
details in the sources are load-bearing. `(declaim (optimize (speed 3) (safety 0) (debug 0)))`
with `fixnum` declarations is what lets the compiler assume machine-word arithmetic, and task 02's
accumulator is deliberately declared `(signed-byte 64)` rather than `fixnum`, because under
`safety 0` a fixnum sum wraps silently and would print a wrong answer. Task 10 needs no
hand-rolled limbs: Common Lisp integers are arbitrary precision by the standard and promote
automatically. Task 11 is real: `(find :sb-thread *features*)` is true on the Windows port,
threads are a required part of the win32 build (implemented over `_beginthreadex` since SBCL
1.1.1), and there is no global interpreter lock, so `sb-thread:make-thread` plus
`sb-thread:join-thread` gives four genuine OS threads.

**VBScript** needs nothing installed: `cscript //nologo <task>.vbs` runs it, and `cscript.exe`
ships with Windows. Three things about the row are worth knowing. It has **no byte type** —
`ADODB.Stream.Read` returns a `Byte()` array that the engine will not let you index, and it
refuses `For Each` over it with "object is not a collection" — so task 14 reads the file
through the same stream in text mode with the single-byte `ISO-8859-1` charset, where one
character is one byte, and reads each byte back with `Asc(Mid(chunk, i, 1))`; that decodes and
re-encodes through the machine's ANSI code page, which round-trips the byte values exactly, at
a measured cost of about 1.1 µs per byte. It has **no big-integer type**, so task 10 is the
same hand-written base-1e9 limbs the C row uses, with the limbs as `Double` (a limb times the
spigot's multiplier is at most 2.3e14, well inside the 2^53 where a Double is exact) and the
carry taken as `Int(p / 1e9)` rather than `Mod`, which is `Long`-only and overflows at this
size. And its `Mod` cannot express the task-14 checksum either, so the remainder mod 2^32 is
taken as `total - Int(total / 4294967296) * 4294967296`. Task 11 is four child processes:
VBScript has no thread library and no way to declare one, so the parent re-runs its own file
four times through `WScript.Shell.Exec` with a worker index as the argument and reads each
child's stdout back, which blocks until that child exits and is therefore the join. That is
real parallelism across four cores, the same category as the R row's `PSOCK` workers.

**Raku, Erlang and Elixir** are three separate rows that share a runtime shape and one caveat.
All three install without admin: Raku is a 64 MB MSI that `msiexec /a <msi> TARGETDIR=<dir> /qn`
administratively extracts (the same no-admin route the SBCL row uses — the MSI itself installs
per-machine and wants elevation), Erlang OTP 29.1.1 is a plain 179 MB Windows `.zip`, and Elixir
is an 8 MB zip that sits on top of that Erlang. None has a build step: `raku <task>.raku`,
`escript <task>.erl` and `elixir <task>.exs` each compile the file as they run, so that compile
time is inside the measured number. All three have arbitrary-precision integers built in, so
task 10 is a fast cell rather than a hand-rolled one, and all three have real OS threads, so
task 11 is a genuine pass — Erlang measured **4.27x**, the best in the matrix.

The caveat is task 07, and it is the same one for all three: each runtime has an explicit
optimisation for repeatedly appending the same value, which turns the natural expression into an
amortised O(1) in-place extend. MoarVM's `MVM_string_concatenate` detects the pattern and bumps a
repetition counter on the string's strand tree; BEAM's writable-binary optimisation does the same
for `<<Acc/binary, "x">>`. Both therefore run **linear**, not quadratic, and the cell measures the
optimised append instead of the quadratic copy the task is about. Measured: Raku 0.39 s for 1M
appends (0.05/0.07/0.14 s at 100k/200k/400k), Erlang 19 ms for 1M and 87 ms for 4M. The rows
record this rather than forcing a copy, because forcing one would mean writing them artificially.

Erlang and Elixir also need a style note that the other 90 rows do not. Neither language has
mutable variables or loop syntax — there is no assignment statement — so every loop in those two
rows is tail recursion with explicit accumulators, which the compiler turns into a jump, plus
`case`/`cond` for the branches. The rows deliberately avoid the functional style (no
`map`/`foldl`/comprehensions/higher-order functions in any timed path) and use the languages' own
escape hatches for state: the process dictionary, and `:atomics`, a real mutable array of 64-bit
integers. That is the most procedural register either language has; it cannot honestly be called
imperative and the rows do not claim to be. Raku needs no such note — it has mutable variables
and `for`/`while`/`loop`, so its row is ordinary imperative code.

**Scheme** is Chez Scheme 10.4.1, and its toolchain has to be *built* before it can be run:
there is no download-and-unpack Windows tree, and the only official
Windows binary is a 27 MB WiX burn bundle that chains two per-machine MSIs and so wants
elevation. The no-admin route is the release tarball, `csv10.4.1.tar.gz`, configured `-m=ta6nt`
— the threaded 64-bit machine type — and built with MSYS2 UCRT64's
`mingw-w64-ucrt-x86_64-gcc` and GNU Make; it took about 72 minutes here, with two restarts,
because zlib's Windows makefile fails under a parallel `make` in **both** workareas
(`pb/zlib` and then `ta6nt/zlib`, each with `collect2.exe: error: ld returned 32 exit status`)
and has to be built once serially in each. `make install` does not work either: its script is a
`/bin/sh` script that `zuo` hands to `cmd.exe`, so the four installed files
(`bin/ta6nt/scheme.exe`, `petite.exe`, `boot/ta6nt/scheme.boot`, `petite.boot`) are placed by
hand — which is the official installer's layout, because on Windows the default boot-file
search path is the executable's own directory and then `<exe>/../../boot/<machine type>`, so
the tree must move as a unit. **A non-threaded build is not an option**: task 11 needs
`fork-thread`, which the `a6nt` machine type and `--nothreads` do not have. The minimum is
**10.0.0**, the release that made the threaded machine type `configure`'s default. There is no
build step: `scheme --optimize-level 3 --script <task>.ss` loads the boot files and compiles
the script on the fly, so the compile is inside the measured number — an empty script already
costs 0.24-0.44 s, which is the floor under all fifteen cells. `--optimize-level 3` is this
row's `-O2`, the documented batch-mode way to let the compiler generate unsafe code and drop
the run-time type checks, and it has to be on the command line. Task 03 must be run from
`sources/scheme/`, because `load` resolves its argument against the working directory rather
than the script's directory. Task 10 is a built-in-bignum cell — Chez has exact
arbitrary-precision integers — and task 15 is flush plus close, because the standard library
exposes no fsync. Task 11 is a genuine four-OS-thread pass over the Windows API, measured at
about **3.0x** on four cores against the same work on one thread; the row's own task 11 is
nevertheless not faster than its task 02, because the loop is about 0.1 s and creating and
joining four `fork-thread`s costs more than that.

**Prolog (SWI)** is the official x64 Windows build, 10.0.2-1. Its installer is a CPack NSIS64
package that defaults to `C:\Program Files\swipl`, adds that `bin` to the **machine** `PATH`
and writes `HKLM\Software\SWI\Prolog`, so `winget install --id SWI-Prolog.SWI-Prolog` wants
elevation; the no-admin route is the one the official Scoop manifest uses, extracting the
payload with 7-Zip into `tools/swipl/` (2798 files, about 133 MB). The extracted tree is
self-locating — it finds its home from the executable's own path, with `SWI_HOME_DIR` or
`--home` as an override — and needs no `PATH` entry, because the run line uses the full path.
That run line is `swipl -q -O -f none -g main -t halt <task>.pl`, from `sources/swipl/`: `-q`
suppresses the banner, `-f none` skips the personal init file, `-g main` runs `main/0` and
`-t halt` makes it the top level. **`-O` is load-bearing** — it sets the `optimise` flag, which
compiles the arithmetic and deletes redundant `true/0`, and the same goal measured 5.73 s with
it against 17.07 s without. `qsave_program/2` and `-c` are deliberately **not** used: a saved
state would move clause compilation out of the measured run, and loading fifteen tiny files
costs milliseconds against 100-million-iteration loops. 10.0.2 is the version measured and the
row's recorded minimum. Four things about the row are worth knowing. It has **no array
library**, so tasks 04, 05, 12 and 13 use compound terms with one argument per element, written
with `nb_setarg/3` and read with `arg/3` — a 1 000 000-argument term is the C row's 8 MB array,
and task 05's 64-byte buffer is an 8-argument term. Task 06 cannot use `string_code/3`, which
costs time proportional to the string's length on *every* call on this version, so the scan
converts the built text to code lists in 1 MiB chunks. Task 07 is quadratic by design — SWI
strings are immutable, there is no string builder in the standard library, and `string_concat/3`
copies the whole string per append — and at **1405 s** it is the row's slowest cell. Task 15 has
no fsync, since 10.0.2 exposes `flush_output/1` and `close/1` and nothing lower, so it is flush
plus close. Task 11 is real OS threads with no global interpreter lock, measured at 3.4x on
four workers, and it needs message queues rather than shared variables: `thread_create/3`
**copies** the goal, so each worker sends its partial with `thread_send_message/2` and the
parent collects four times before joining.

**Octave** is the official MXE `w64` build, 11.3.0, installed by the portable 7-Zip route:
`octave-11.3.0-w64.7z` is 459 MiB and unpacks to **2.6 GiB** in `tools/octave/`, and
`post-install.bat` in the extracted root has to be run once through `cmd.exe` before the first
start — it converts the root to 8.3 form, writes `mingw64/bin/qt.conf` with absolute `Prefix`
paths, runs `bash --login -c echo` to register the MSYS environment, rebuilds the fontconfig
cache and runs `pkg rebuild`; the one complaint it prints on this host comes from the MSYS login
shell's `PATH` walk hitting a broken `jre` shim and is not an Octave error. The winget package
`GNU.Octave` is the same build and also admin-free, but it installs under `%LOCALAPPDATA%`. The
console interpreter is `mingw64\bin\octave-cli.exe` — the tree also carries a versioned alias,
the Qt-linked `octave-gui.exe` and an `octave-launch.exe` dispatcher — and the run line is
`octave-cli.exe -qf <task>.m`, from `sources/octave/`. `-q` suppresses the banner and `-f`
(`--no-init-all`) skips both init files, which is the manual's own stand-alone idiom and stops
a stray `~/.octaverc` from changing a timed run; a `FILE` argument executes the script and
exits, so no `--persist` is needed. There is no build step: Octave is a tree-walking interpreter
with no JIT, the prototype compiler having been removed in version **7**, which is the row's
minimum. The trap that cost real time is that a script's local functions are defined only when
their definition is **executed**, so a function placed after its first call is still undefined
when the call runs and the script dies with `error: 'name' undefined`; every file in this row
that carries a function defines it first, after a leading `1;` that keeps the file's first token
from being `function`. Task 03 loads `add_one.m` from the working directory, because Octave
resolves a call through the file name. Task 11 is four `octave-cli` child processes started with
`popen` — core Octave has no threads for m-code, `parfor` is documented as "a mere synonym of
`for`", and `fork()` is compiled out on native Windows — and task 15 flushes and closes because
Octave exposes no fsync. Task 10's limbs are `int64` rather than doubles, which is
correctness-critical, because Octave's integer arithmetic **saturates** instead of wrapping.

**J** is `jconsole`, from the Windows x64 base zip `j9.7.1_win.zip` (6.3 MB), extracted into
`tools/` so that `tools/j9.7/bin/jconsole.exe` is the interpreter. No admin is needed for the
zip route (the AIO installer's "just for me" option is the no-admin alternative) and no addons
are needed, because the console loads the profile and the profile loads the standard library.
**The run line is a plain `jconsole.exe <task>.ijs`, from `sources/j/`; `-jprofile` is the
wrong invocation.** Verified: with `-jprofile` the profile is skipped, the standard library is
never loaded, and every name the scripts use is undefined — `4!:0` on `stdout`, `LF`, `exit`,
`echo` and `load` returns `_1 _1 _1 _1 _1` against `0 3 0 3 3` for a plain run. Every script
therefore ends with `exit 0`; without it jconsole finishes the file and drops into the
interactive prompt, which hangs a batch runner. The minimum is **9.4**: both the `T.`/`t.`
threads-and-tasks that task 11 uses and the GMP-backed extended integers that task 10 uses
arrive in that release. The one runtime dependency is the VC++ x64 runtime for `j.dll`, which
the `msvc` row already puts on this machine. Three traps cost time. J evaluates **right to
left**, so `i * n + j` is `i * (n + j)` and every index and every spigot multiplier in this row
is parenthesised. `":` on a *list* pads every number to a common width and the default print
precision is 6 significant digits, so task 01 formats each counter atom at a time and task 08
uses the fit form `(":!.12)` or it prints `0.498047`. And counted loops are `while.`, because
`for_i. i. 100000000` materialises the 800 MB index vector before the first iteration — the same
trap the R row records. Task 03 loads `AddOne.ijs` with `0!:0`, so the helper sits next to the
task file. Task 07 measures a linear append: J documents that `x , y` appends to `x` in place
when `x` is a zombie, which is exactly what the task's own line is. Task 15 has no fsync — J's
foreign tables contain no flush, sync or `FlushFileBuffers` operation at all. Task 11 is real
OS threads inside the interpreter (`0 T. ''` creates them, `u t. n y` dispatches a task and
returns a pyx), with no extra install and no child processes, but the speedup is about **1.7x**
rather than 4x, because J's explicit verbs run roughly 1.8x slower inside a worker thread than
on the master thread.

**Janet** is a single 2.13 MB per-user MSI from the project's releases page (1.42.1). The MSI is
`InstallScope="perUser"`, so it installs without admin, and the no-touch alternative is
`msiexec /a <msi> TARGETDIR=tools\janet /qn` — the same administrative extract the Raku and
SBCL rows use — which leaves the binary at `tools\janet\Janet\bin\janet.exe`. `janet.exe` is
built with MSVC `/MD`, so it needs `vcruntime140.dll`; the winget package declares
`Microsoft.VCRedist.2015+.x64` as a dependency, and the same release also ships a static
Cosmopolitan `janet.com` as a fallback. There is no build step and no `jpm`:
`janet <task>.janet` compiles the file to bytecode and runs it, so the ~3 ms VM start and the
compile are inside every measured number, and `janet -c`/`.jimage` precompilation is
deliberately **not** used, the way it is not for Racket and Clojure. The minimum is **1.17.1**:
task 11 uses `ev/thread` plus `ev/thread-chan`, and threaded channels landed in 1.17.0 —
`ev/spawn-thread` is absent from the 1.16.1 API. Those threads are core, with no extension and
no flag, and they are the isolates shape: one OS thread per worker, each with its own heap, the
partials sent back over a threaded channel, measured at about 4.9x on four threads. Task 03
sources `03_func_sum_add_one.janet`. Two file-mode traps cost time. `file/open`'s mode keyword
is a set of flags and `:w` alone is **text mode**, so writing the 1 MiB buffer with `:w`
translates its 4096 `0x0A` bytes to CRLF and produces a 52633600-byte file; task 15 opens `:wb`
and task 14 reads `:rb`. And `file/read` returns **nil** at end of file and **appends** into a
supplied buffer, so the read loop clears the buffer and nil-checks each time. Task 10 is the
hand-rolled sign-magnitude base-1e9 bignum with the limbs as doubles, because Janet's numbers
are IEEE doubles only and there is no bignum. Task 15 flushes but does not fsync (`file/flush`
exists, `file/sync` does not). Task 07 is the row's slowest cell by two orders of magnitude:
`(string acc "x")` copies the accumulator twice per append, about 10^12 bytes over the million
iterations, measured at **2266 s**.

**Ring** is `ring.exe <task>.ring`, from the **Light Release — Windows Binary — 64bit** zip
(`Ring_1.27_LightRelease_Windows_Binary_64bit.zip`, 6.5 MB, 19 MB extracted). The 452 MB
Windows installer is the IDE plus Qt and is not needed; the light release is a plain ZIP, so
nothing here needs admin. There is no compile step — the compiler and the VM are one program and
the source is turned into bytecode on every run, so that compile (about 20 ms for these files)
sits inside the measured number. The extracted tree has to stay together, because `load`
resolves `ring/bin` and `ring/bin/load` relative to the executable rather than to the working
directory; the working directory matters only for tasks 14 and 15. The minimum is **1.27**, the
release whose documented core-operation timings this row's cost estimates were derived from and
the first with the automatic hash table for global lookups. Task 11 needs the distribution's own
Threads extension, and **the light release does not ship it** — the zip has no
`bin/ring_threads.dll`, no `bin/load/threads.ring` and no `extensions/ringthreads/`, only that
extension's sources in the repository — so six files from the `v1.27` tag are fetched and
compiled with one `gcc -O2 -shared` line into a 75 KB DLL beside `ring.exe`, which is where the
loader looks; without it task 11 stops with `Runtime Error in loading the dynamic library`. The
extension is a TinyCThread binding over Win32 threads and the VM has no GIL: each worker gets
its own VM state that **shares the global scope**, so each writes its quarter's partial into its
own slot of a global list, and the measured 8.1-10.4 s against 20.2-22.4 s for the same four
quarters run one after another is a real 2.2x on four threads. Two language traps cost time.
`+=` is not the same operation as `x = x + y` — `+=` appends into the variable's own string
object and doubles its capacity as needed, while the spec's form copies the whole string twice
per iteration — so task 07 uses the spec's form and is honestly quadratic, about **219 s of user
CPU**. And a global name assigned inside a function is the global, not a local: parameters
shadow, plain assignments do not, so task 10's big-integer helpers prefix every local with `b`
to avoid overwriting the spigot's own state. Task 12 keeps the matrices as flat
`list(1000000)` arrays because Ring allocates many small lists pathologically slowly — the three
matrices as 3000 small 1000-item lists cost **54.8 s** of user CPU against 0.14 s for the same
three million items in three flat lists, which would have measured the allocator. Task 15 has no
fsync, and its 1 MiB buffer is built by repeating a 512-hex-digit pattern and converting it with
`hex2str`, because Ring's string concatenation is length-based and an append loop would
truncate at the byte 0 in the pattern.

**JScript** needs nothing installed either: `cscript //nologo //E:JScript <task>.js` runs it,
and `cscript.exe` ships with Windows. It is **not** the `JavaScript` row — this is the Active
Scripting engine Windows Script Host loads for a `.js` file, and on this host that is
**JScript9Legacy**, which reports `ScriptEngine` "JScript" 11.0.16384; classic JScript 5.8 is
not what runs. The sources stay inside the ES3 subset both engines accept — `var`, `function`,
`for`, `switch`, `%`, `charCodeAt` — because this one has no `JSON`, no `let`/`const` (a syntax
error), no typed arrays (`typeof Uint8Array` is `undefined`), no `String.prototype.repeat` and
no `Math.imul`. Four things about the row are worth knowing. It has **no bignum**, so task 10
is the same hand-written sign-magnitude base-1e9 limbs as the C and VBScript rows, with the
limbs as doubles and the carry taken as `Math.floor(p / 1e9)`. It has **no `malloc` and no
typed array**, so task 05's 64-byte buffer is `new Array(64)`, one fresh 64-element array object
an iteration. It has **no include**, so task 03's helper lives in its own file, which the
caller reads and `eval`s — the call is measured, not assumed, not to be inlined (10 million
calls cost 4.67 s through the file against 4.24 s for the same helper declared in the calling
file and 1.90 s for 10 million inline increments). And the engine has an optimizer, with one
load-bearing consequence: a loop whose result is never observed is removed (measured, 1 ms
for 10 million iterations against 780 ms when the result is returned), so every task prints its
result and nothing in the row is dead code. Two things are easier than in VBScript:
`new VBArray(chunk).toArray()` makes the bytes `ADODB.Stream.Read` returns indexable, so task 14
reads in binary mode with no charset in the way, and `%` on doubles is an IEEE remainder, so the
task-14 checksum mod 2^32 needs no subtraction trick. Task 15 is the one write deviation:
`ADODB.Stream.Write` rejects a JScript string with `800a0bb9`, so the 1 MiB buffer goes through
the same stream in text mode with the single-byte `ISO-8859-1` charset, whose round trip was
checked byte for byte against all 256 values; there is no fsync, the same deviation the VBScript
row carries. Task 11 is four `WScript.Shell.Exec` children, as in the VBScript row, because
Windows Script Host JScript has no thread library and no way to declare one — but **no factor is
claimed for the cell**: a child runs its quarter inside a function while task 02's loop is
global code, and this engine does not treat the two alike (an in-process A/B of the identical
5-million-iteration switch measured 0.28 s inside a function against 0.78 s at top level).

**AutoHotkey** is one 3 MB ZIP from the project's releases page (v2.0.28), extracted into
`tools/autohotkey/`; there is no installer, no registry write and no admin step, because the
interpreter is portable by design — the documentation states that `AutoHotkey.exe` is all that
is needed to launch a script. `Install.cmd` and `UX\` come along in the tree and are never run;
the alternative no-admin route is `winget install -e --id AutoHotkey.AutoHotkey --scope user`.
The row is **v2, not v1**: v1 is a different language, with different syntax and no `Buffer`, no
strict arrays and no true division, and every source starts with `#Requires AutoHotkey v2.0` so
that a v1 interpreter refuses the file instead of reporting an arbitrary syntax error. There is
no build step — `AutoHotkey64.exe /ErrorStdOut <task>.ahk` loads, semi-compiles and runs the
file, so the load and the interpreter start-up are inside every measured number — and the
nearest thing to one is the syntax check `AutoHotkey64.exe /Validate /ErrorStdOut <task>.ahk`,
which exits 0 for all sixteen files. **`/ErrorStdOut` is not optional**: without it a load error
opens a modal dialog and an unattended run hangs. Task 03 pulls `03_func_sum_add_one.ahk` in
with `#Include`; AutoHotkey has no inlining pass and no no-inline marker, so the file split is
the row's cross-file convention rather than a way to defeat an optimiser. Task 11 needs no extra
install and is four child processes, because AutoHotkey's "threads" are hotkey, timer, menu and
GUI event flows inside one OS thread and there is no thread library. Three details in the
sources are load-bearing. Task 11 must carry `#SingleInstance Off`, since the directive defaults
to *Prompt* and identifies instances by the script's main-window title, so four children of one
script would otherwise prompt for or replace each other. The parent converts each child's stdout
with `RTrim(...) + 0`, because v2 refuses to convert a numeric string that still has its
trailing newline. And task 14 reads its bytes through `FileOpen(..., "r")` and `RawRead` into a
`Buffer` rather than through `FileRead`, because native strings are UTF-16 and `FileRead`
converts bytes to text by default, while task 15 opens with the explicit `UTF-8-RAW` encoding,
since any plain UTF-8 or UTF-16 encoding writes a byte order mark. Two operational facts cost
time. An uncaught run-time error is **silent and the exit code lies** — three identical runs of
a script whose only fault was an uncaught `Integer("abc")` each printed the lines before the
fault, printed nothing to stderr and exited 0, after 6.8 s, 4.7 s and 3.9 s against about 0.2 s
for a healthy script — so every task was verified by its printed line and its file side effects,
never by its exit code. And stdout is delivered only to a redirect or a pipe, because the
interpreter is a GUI-subsystem program. The row is **Windows-only**. Task 07 is a documented
deviation: the expression compiler gives `text .= "x"` an in-place path that grows the buffer
geometrically, so the loop is amortised linear rather than quadratic, and the measured cost per
append *falls* as the count grows.

**GHDL**, whose row sits in the bytecode table above because its analysis step produces no
binary, is the reference open-source VHDL simulator, and like the SystemVerilog row it is a
hardware description language: there is no `main`, a program is a testbench entity, and the work
happens inside the simulator's process scheduler. Install it by extracting
`ghdl-mcode-6.0.0-ucrt64.zip` (22.6 MB, 72 MB extracted) from the v6.0.0 release page anywhere
— a self-contained Windows build that needs no MSYS2, no `gcc-ada` and no administrator. The
mcode backend was chosen over LLVM deliberately: it is the only Windows backend GHDL ships
standalone and, decisively, it does no interprocedural inlining, so task 03's 100 million
`add_one` calls are real calls — the MSYS2 LLVM package defaults to `-O2` and folds the
one-line helper into its single call site, which is the one thing task 03 exists to prevent.
Analysis and run are separate commands, `ghdl -a --std=08 <task>.vhd` then
`ghdl -r --std=08 <unit>` from `sources/vhdl/`, but mcode's `-e` "does not generate anything",
so there is no artifact to time separately and the measured run re-elaborates and JITs every
time; there is no optimisation flag to set, because the backend has none. Task 03 analyses
`03_func_sum_add_one.vhd` **first**; reversed, the analysis fails loudly with
`unit "add_one_pkg" not found in library "work"`. Four things about GHDL cost time. Its
`integer` is **32-bit**, `to_integer` on a 64-bit `unsigned` returns a 32-bit `NATURAL`, and
overflow is a hard runtime error rather than a silent wrap, so every accumulator that can exceed
2^31 is an `unsigned(63 downto 0)` printed by a hand-rolled `to_decimal` that divides by 10.
Text files opened through `std.textio` are `fopen`ed **without `'b'`**, so on Windows the CRT
stops at the first 0x1A and turns LF into CRLF — `data.bin` has 0x1A at offset 26, so task 14
would silently read 26 bytes and print a tiny wrong number; the fix is
`type byte_file is file of character`, which GHDL opens `"rb"`. GHDL's file element type is also
the unit of I/O, and it prepends its own `#GHDL-BINARY-FILE-0.0` signature header for every
**composite** element type, so the 1 MiB chunk of tasks 14 and 15 is a real buffer filled and
drained one character at a time rather than a bulk `fread`. And unconstrained function results
— string concatenation, aggregates assigned to an unconstrained object — live on GHDL's
**secondary stack**, which raises `exception raised: stack overflow` above about **32 MiB**;
`--max-stack-alloc` does not raise that limit, because it governs the process's own variable
stack instead, which is why task 06 allocates its 100000000-character text once at full size and
doubles it in place. A simulation has to end with a bare `wait;`, not `std.env.finish`, because
`finish` prints `simulation finished @0ms` to stdout and would break the one-line rule. Task 11
is expressed in the language's own concurrency — four `process` blocks each owning a fixed
quarter, plus a fifth collector — and it is a correct-answer-no-speedup cell: every shipped GHDL
build schedules those processes on **one OS thread**, `--threads=N` is parsed but dead, and the
measured 2422 s against task 02's 2430 s is 1.003x, i.e. noise. The row is slow for a toolchain
reason rather than a language one: under mcode a 64-bit vector add costs about **17 µs** against
about **9 ns** for a 32-bit `integer` add, which is what turns a 1.5 s task into a 40-minute one.

**Terra** is a 61 MB Windows `.7z` (`terra-Windows-x86_64-<hash>.7z`) whose `bin/terra.exe` is
158 MB — LLVM 22.1 and clang are inside it — extracted with 7-Zip; no installer, no registry,
no admin. Nothing is linked at build time, so **no MSVC and no Windows SDK are needed**, but
the interpreter will not start without one of them unless it is told otherwise: `terralib.lua`
runs a toolchain probe before it opens the user's file, and with neither `VCINSTALLDIR` nor the
`KitsRoot10` registry key it aborts with `Can't find windows SDK version 8.1 or 10!` and exit
code 1 — for `print("hello terra")`, not just for a program that links something. The fix is to
satisfy the probe's first branch with the toolchain that *is* on the machine: `VCINSTALLDIR`
only has to be **non-nil** (it is the switch, and the directory it names is never read unless
Terra is asked to link), and `INCLUDE` must point at a C sysroot — this repository's existing
`tools/llvm-mingw/include` — because that is what the bundled clang is given as `-I` entries
when a task includes a C header. `LIB` is read only by `terra.getvclinker` and is set to keep
that call from failing on a `nil`. Two traps shaped the sources. `terralib.includec("windows.h")`
needs one extra flag, `-fgnuc-version=4.2.1`: Terra's clang runs in **MSVC mode** on Windows
(`terralib.lua` applies that flag on every platform except Windows), while mingw-w64's `_mingw.h`
defines `__attribute__(x)` away when `__GNUC__` is undefined, so without it the header tree fails
with 4583 errors inside `mmintrin.h`. And `C.printf` from `includec("stdio.h")` **kills the
process silently** — exit code 5, no diagnostic — because mingw-w64 renames `printf` to
`__mingw_printf` through `__MINGW_ASM_CALL` and that symbol lives in a static archive the JIT
cannot resolve; the row therefore prints through Lua. Task 03 needs no substitute for a
no-inline marker, because Terra has a real one, `setinlined(false)`, which sets LLVM's
`noinline`; without it the cross-file call is inlined anyway and the whole
hundred-million-iteration loop reduces to `smax(n, 0)` — it is deleted, not merely fast. Task 11
is four `CreateThread` workers through `includec("windows.h")`, real threads measured at 3.72x
with four distinct thread ids and a process CPU/wall ratio of 4.75; that cell's ~1.3 s is mostly
the header parse, since it is the only task in the row that includes a C header. Task 15 **syncs
for real**: `_commit` (the CRT's `fsync`, `FlushFileBuffers` underneath) resolves and returns 0,
so this row is not in the flush-and-close group — but note that `_commit(-1)` does not return
-1, the CRT's invalid-parameter handler terminates the process, so it is only ever called on a
descriptor the program just opened. Binary modes are mandatory: text mode wrote 6 bytes for
`"A\nB\n"` against 4 in binary, because a CR is inserted before every LF.

**Dyalog APL** is a 20.0 Unicode Windows distribution, and the download page offers it as a
**zip** containing `setup.exe` and `setup_64_unicode.msi`; the MSI is extracted with
`msiexec /a <msi> /qn TARGETDIR=<dir>`, the same no-admin route SBCL, Raku and Janet use, and
the interpreter tree then moves as a unit. There is no portable interpreter-only package on any
platform — Linux gets `.deb`/`.rpm`, macOS a `.pkg` — so this is the only route. Two things
about it matter more than the install. First, **it runs unregistered**: no licence file, no
serial, no registration step, and `dyascript.exe -script <file>` writes nothing at all to stdout
or stderr at start-up, so the row's cells are the program's own bytes and no ActionScript-style
offset is needed. The `UNREGISTERED - not for commercial use` banner is interactive-mode-only
and goes to **stderr**. Second, the right binary is `dyascript.exe`: `dyalog.exe`,
`dyalogrt.exe` and `dyaedit.exe` are GUI-subsystem programs (PE subsystem 2) whose output never
reaches a console, while `dyascript.exe` is the console one (subsystem 3). `-script` is
mandatory rather than cosmetic — without it the interpreter does not run the file at all, it
starts a Session. `⎕IO←0` and **`⎕PP←17`** are load-bearing in every file: the default `⎕PP` is
10 and `⍕` of task 02's total then prints `7.500000075E15` instead of the exact digits, which
would make every numeric cell `WRONG`. Dyalog has no 64-bit integer type and no bignum — `⎕DR`
of `2*62` is 645, a 64-bit float, and `2*53+1` is `2*53` — so task 10 hand-rolls base-1e9 limbs.
Three structural facts shape the whole row. **A dyadic tradfn is declared infix**: the header is
`∇ r←a badd b`, not `∇ r←badd a b`, and the second form is not a syntax error — it silently
defines a function named `a` and the failure surfaces later as an undefined name at the call
site. **APL is right-associative**, so `ai-bi-borrow` parses as `ai-(bi-borrow)`, the same trap
the J row records for `i * n + j`. And **a dfn cannot contain control structures** — "dfns do
not support control structures or branch" — so every loop in this row lives in a tradfn, with
its locals declared after the semicolon in the header, because an undeclared name assigned
inside a tradfn is a global, which under task 11 is a data race rather than merely a leak. Task
11 is the language's own `&` spawn joined by `⎕TSYNC`, and it is a correct-answer-no-speedup
cell measured rather than assumed: four workers consume 0.99 CPU per wall second, four 5 M
workers take 4.12x the time of one, and the threaded form is slower than the identical serial
work. Task 07 appends in place (`text,←'x'`) and is linear; task 15 flushes rather than fsyncs,
because the `⎕N*` foreign functions contain no flush, sync or `FlushFileBuffers` operation —
`⎕NA` could call `kernel32|FlushFileBuffers` directly, but that is a DLL call the task did not
ask for, so the deviation is recorded rather than taken.

VBScript and JScript are also the rows here that are being withdrawn. Microsoft's phased
deprecation makes the Windows Script Host engines a Feature on Demand in Windows 11 24H2 —
present and enabled at first — then disables them by default, and finally removes them;
`RUN.md` carries the platform detail.

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
| scala/native | a C toolchain that Scala Native can drive. On Windows the documented route is LLVM/clang 16+ plus Visual Studio's C++ workload (the "C++ Clang tools for Windows" package does not work); without admin the portable llvm-mingw zip is the route, and it needs the two flags in the build line above. `--native-compile=-D_PID_T_` suppresses mingw's own `pid_t` typedef through its `#ifndef _PID_T_` guard, because Scala Native's `gc/shared/ThreadUtil.h` does `typedef int pid_t` under `#ifdef _WIN32` and clang rejects the redefinition; without it every build fails. `--native-linking=-static` is needed because Scala Native forces C++ exceptions on Windows, so a default link produces an executable importing `libc++.dll` from the llvm-mingw tree and only runs with that directory on the DLL search path. The mingw codegen path ships in the released compiler (`scala/scalanative/codegen/llvm/compat/os/WindowsGnuCompat.class` beside `WindowsCompat.class`), but upstream CI does not cover it, so it can break on a Scala Native upgrade. |
| C# nativeaot | the MSVC linker. With a hand-extracted MSVC tree, `dotnet publish` cannot find `vcvarsall` and reports `Platform linker not found`; pass `-p:IlcUseEnvironmentalTools=true` so it uses `PATH`/`INCLUDE`/`LIB` instead. |
| fpc (Windows x64) | the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, since there is no native x64 compiler. |
| odin (Windows) | `WindowsSdkDir`, `WindowsSDKVersion` and `VCToolsInstallDir` in the environment. Odin does not discover the SDK on its own; without them it fails with `Windows SDK not found`. |
| c3c (Windows) | the MSVC SDK to link against, because c3c emits object files and hands them to `lld-link`. Without one it prints `To target x64 you need the MSVC SDK` and offers to download it. A hand-extracted tree works via `--win-sdk` plus three `-L` flags (see the toolchain table above); `--win-vs-dirs` does not accept one. |
| valac | a C compiler and GLib's development files. On Windows both come from MSYS2 `ucrt64` (`mingw-w64-ucrt-x86_64-vala`, which pulls in the GLib/GObject/GTK dependency chain and about 2.2 GB of tree). `valac` has to run inside that shell so `pkg-config` resolves. |
| cim | a C compiler and Cygwin. The compiler and runtime are built once under Cygwin, and `cim.exe` then drives the system `gcc` on every build, so `C:\cygwin64\bin` must be on `PATH` when it runs. |
| gpcp | the .NET runtime, and `RTS.dll` copied next to every executable (plus `RealStr.dll` for the row that formats reals, and the `GP*Files.dll` pair for the file tasks). `CPSYM` must be set or no symbol file is found. |
| a68g, for task 11 only | a source build with `--enable-parallel`. The prebuilt Windows binary is configured without the parallel clause and cannot run task 11 at all. It also needs `C:\cygwin64\bin` on `PATH` when built under Cygwin. |
| beef (Windows) | a `shell32.lib` from outside the distribution. `bin/lib/x64` ships eleven import libraries and the Release link line asks for `shell32.lib` anyway, so the link stops with `lld-link: error: could not open 'shell32.lib'`; any Windows SDK copy works, as does a MinGW import library renamed to it. `BeefConfig.toml` also has to be copied from the installer's `__user/bin/` into `bin/`, or BeefBuild stops with `ERROR: Unable to load project 'corlib'` — its `UnversionedLibDirs` is resolved against the config file's own directory. |
| haxe | Neko for `haxelib`, and the hxcpp backend. `haxelib.exe` ships without `neko.dll` and dies with `error while loading shared libraries: neko.dll`, and copying just that DLL is not enough — Neko then wants `gcmt-dll.dll`, `std.ndll`, `regexp.ndll` and the MSVC runtime, so the whole official `neko-2.4.1-win64.zip` is unpacked, put on `PATH` and named by `NEKOPATH`. `haxelib install hxcpp` is unusable where `lib.haxe.org` answers HTTP 403, so `hxcpp-4.3.171.zip` is unpacked and registered with `haxelib dev hxcpp <dir>` — dropping the tree in as a *version* fails, because haxelib parses the directory name as a version and rejects a three-part one. hxcpp 4.3.171 then does not compile with MinGW's libstdc++ as shipped: `src/hx/gc/GcCommon.cpp` calls `std::sscanf` without including `<cstdio>`, which MSVC pulls in transitively and libstdc++ does not, so one `#include <cstdio>` line has to be added to the installed copy. Every build line also carries `-D mingw -D MINGW_ROOT=<the directory holding bin/g++.exe>`, because hxcpp guesses `c:/MinGW` and otherwise stops with `Could not guess MINGW_ROOT`. |
| eiffelstudio | four environment variables and a C compiler, which the delivery supplies itself: MinGW gcc 4.4.5 under `gcc/win64/mingw/bin`, selected with `ISE_C_COMPILER=mingw`, so no MSVC is needed. `ISE_EIFFEL` points at the tree, `ISE_PLATFORM` is `win64`, and `ISE_LIBRARY` must be the **root** of the tree rather than its `library` subdirectory — every shipped ECF refers to `$ISE_LIBRARY\library\base\base.ecf`, so pointing it at `library` makes `ec` fail with `Could not open file: …\library\library\base\base.ecf`. The MSYS 1.0 `sh.exe` the generated Makefiles call through also fails intermittently with `*** Couldn't reserve space for cygwin's heap (…) in child, Win32 error 0`, aborting the C compilation partway; re-running the same `ec` command resumes and finishes it, and six of the fifteen targets needed retries, so a build script has to retry and check for `prog.exe`. |
| s7c | the MSYS2 **MSVCRT** MinGW gcc to build the toolchain itself, not the UCRT one this repository already has. `make depend` runs `chkccomp`, which probes the C compiler for a `read_buffer_empty` macro; UCRT's `FILE` is opaque, so none of the candidate struct-member probes compile and the build dies at `fil_win.c:245: implicit declaration of function 'read_buffer_empty'`. MSYS2's `mingw-w64-x86_64-gcc` has the classic `_ptr/_cnt/_base` layout and works. The build must be driven from the MSYS2 MINGW64 shell with `/mingw64/bin` first on `PATH`, because `mk_msys.mak` uses Unix shell commands while its `mk_mingw.mak` counterpart does not work under this workstation's `sh`. `make depend` takes about 31 minutes and is **not** hung — it prints a `#*.+` progress bar and spends minutes on database probes. The same gcc must be on `PATH` for every later `s7c` run too, because `s7c` has no code generator of its own and calls it. |
| octave-cli | nothing but its own `post-install.bat`, run once through `cmd.exe` from the extracted root before the first start. It converts the root to 8.3 form, writes `mingw64/bin/qt.conf` with absolute `Prefix` paths, runs `bash --login -c echo` to register the MSYS environment, rebuilds the fontconfig cache and runs `pkg rebuild`; on this host it prints one complaint from the MSYS login shell's `PATH` walk, which is not an Octave error, and exits 0. |
| chez | a MinGW gcc and GNU Make, because there is no no-admin Windows binary to unpack. The build runs from the MSYS2 UCRT64 shell with `mingw-w64-ucrt-x86_64-gcc` (plus `pacman -S make`) and bootstraps from the bytecode boot files in `boot/pb`, so no existing Chez is needed; zlib has to be built once **serially** in each workarea first, because under `make -j8` both `pb/zlib` and `ta6nt/zlib` die with `collect2.exe: error: ld returned 32 exit status` and `libz.a` is missing at link time. `make install` does not work either — `makefiles/installsh` is a `/bin/sh` script that `zuo` hands to `cmd.exe` — so the four installed files are placed by hand. |
| ring, for task 11 only | the Threads extension, which the light release does not ship: `bin/load/threads.ring`, `extensions/ringthreads/{ring_threads.c,ring_threads.rh,threads.ring}` and its bundled `tinycthread/{tinycthread.c,tinycthread.h}` from the `v1.27` tag, compiled with `gcc -O2 -shared -o bin/ring_threads.dll ring_threads.c -I../../language/include ../../bin/ring.dll`. The light release carries the headers and the import library, so no MSVC is needed, and the DLL must end up beside `ring.exe` in `bin/`, which is where the loader looks. |
| poly/ml | a C compiler **and three files the MSI does not ship**, all built once from the matching source tarball (`polyml-5.9.1.tar.gz`). The MSI's complete payload is `PolyML.exe`, `PolyLib.dll` and `PolyPerf.dll` — no `polyc`, no `poly` launcher, no import library, no `libpolymain` — so the row builds them: `gcc -c -O2 -o polystub.obj src/polystub.c` (with `winconfig.h` and `polyexports.h` beside it, which `polystub.c` includes) for the `WinMain` start-up stub, and `gendef PolyLib.dll && dlltool -d PolyLib.def -l libpolyml.a -D PolyLib.dll` for the link library (247 exports). `polyc` is a shell script and there is no `sh` in the MSI, which is why the two steps it performs are driven by hand. MinGW gcc is enough; MSVC is not needed. |
| terra (Windows) | a **non-nil `VCINSTALLDIR`** and an `INCLUDE` pointing at a C sysroot, or the interpreter will not start at all — see the paragraph below. `LIB` is needed only by `terra.getvclinker`. On this host the sysroot is the `tools/llvm-mingw/include` tree that the Scala Native row already needs, so nothing extra is installed for Terra itself. No MSVC, no Windows SDK, and nothing is linked. |
| nelua | a C compiler (the `gcc` the row already has) and a Lua 5.4 or 5.3 interpreter that has `lfs`, `hasher` and `lpeglabel`. The host's stock Lua does **not** — Nelua's `runner.lua` requires all three and there is no `luarocks` on this machine to add them — so the repository's own bundled interpreter is built once from `src/onelua.c` and its companions with `mingw32-make` in `tools/nelua/` (24 s), which is what `nelua.bat` then uses. |

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
- **cim** is a 2013 tree built against a 1990s C dialect. Three things have to be got right
  or it does not build at all, and they are all in the same class as the ATS entry above:
  `-std=gnu89` (a default `-std=gnu17` rejects the implicit declarations the generated C
  relies on), `-w` (the tree does not compile warning-free), and `-fpermissive` for the
  `reg_this` prototype conflict in `dekl.c`. Two more bite at *run* time rather than build
  time: the runtime memory pool has to be sized on the compiler command line (`-m12`, `-m128`),
  because an 8 MB array aborts the default pool with `Alloc: Virtual memory exhausted` and the
  compiled program's own `-mN` option is ignored; and Cim prints its own
  `NNN garbage collection(s) in N.N seconds.` line on stdout at exit, so the one task that
  actually churns the collector has to end with an `EXTERNAL C PROCEDURE` over C's `exit()` to
  suppress it. Its `and`/`or` are also **not** short-circuit, which matters anywhere the second
  operand indexes an array.
- **a68g's parallel clause** is disabled by its own `configure` on any host it does not
  recognise, and `mingw32` is one of those: the configure script sets `enable_stable=yes` for
  an untested platform, and `--enable-stable` implies `--enable-core`, which sets
  `enable_parallel=no`. Passing `--enable-parallel` is therefore not enough on its own; the
  build that has the clause is the **Cygwin** one, where the host is recognised and
  `pthread_attr_getstacksize` links. The prebuilt Windows binary on the project's download page
  is built without it and answers `interpreter was built without parallel-clause support`.
- **gpcp** needs three environment variables set correctly and every one of them fails with an
  unhelpful message: `CROOT` (otherwise `CPMake`/`gpcp` cannot find their libraries), `CPSYM`
  with **both** the top-level `symfiles` directory and its `NetSystem` subdirectory, and a
  leading `.` on `CPSYM` if task 03's helper module is in the working directory. Without the
  `NetSystem` entry, importing `mscorlib_System_Threading` fails with
  `Cannot open symbol file`, which reads like a missing file rather than a missing path entry.
  The runtime DLLs are found next to the executable, never on `PATH`, so a program that ran a
  minute ago dies with `FileNotFoundException: RTS` the moment it is moved.
- **a68g's binary transput never reports end of file.** `end of file (f)` stays `FALSE` after
  reading past the end of a file opened on the back channel: reading a 3 MiB file in 1 MiB
  `getbin` chunks reports `FALSE` after every chunk, so the natural
  `WHILE NOT end of file (f) DO getbin (f, buf) OD` loop **never terminates** — it spins,
  burning kernel time, and looks exactly like a very slow program rather than a hung one. This
  cost a day of measurement before it was isolated; the fix is to count the chunks, which is
  what the spec's fixed 50 MiB file size allows. `getbin` on a `CHAR` row and the scalar `get`
  route are not alternatives: `CHAR` is 16 bytes in this interpreter, so a 1 MiB `CHAR` row
  needs 16 MB and aborts with `not enough memory`, and scalar `get` on a binary file fails with
  `error transputting INT value`.
- **Akron Oberon-07** has no optimisation switch and no `LOOP`/`EXIT` statement, and its `Out.Ln`
  emits `CR CR LF` rather than `CR LF` (`Out.Ln` prints `CR LF` through `printf`, and msvcrt
  text mode translates the `LF` a second time). Every task in that row ends its output with
  `Out.Char(0AX)` instead, which goes through the same text-mode translation once and produces
  a normal `CR LF`; a harness that compares raw bytes against `\n` needs to know that.

## Reference implementations

Task 14 and task 15 use a 50 MiB fixture, and every expected output in this benchmark was
computed independently. Keeping those reproducible needs:

- a C compiler, for the reference implementations
- Python 3.10 or newer, for the fixture generator

Both are already covered above. Note that neither the generator nor the reference
implementations are committed: the repository holds the three documents, `sources/`, and the
`.gitignore` only. `data.bin` is 204800 copies of the byte cycle 0..255, which is the whole
specification.

Two directories exist locally and are deliberately **not** in the repository, so a fresh clone
will not have them:

- `tools/` — the installed toolchains. Several are hundreds of megabytes and two exceed
  GitHub's per-file limit outright, so they cannot be committed even if that were wanted.
  `BUILD.md` above is the list of what to install and where to get it.
- `temp/` — scratch: build outputs, the generated fixtures, probe programs, and the
  investigation notes written while adding a row. None of it is part of the benchmark.

Neither is needed to read the benchmark, and neither is needed to run it: `tools/` is
reproducible from the install instructions, and `temp/` is disposable. Only `sources/` is
load-bearing, which is why it is the only directory the repository tracks.
