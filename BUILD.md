# Build requirements

What has to be installed to turn each task's source into something runnable.
For what has to be installed to *run* the result, see `RUN.md`.

Convention below: `<task>` is the task's own name, so the source for task 01 in C is
`sources/c/01_branches.c`, and the output is `prog`. Add the thread flag where a language
needs one, because task 11 uses four threads.

Seven things do not follow the flat `<task>.<ext>` layout, and each says why:

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

Swift is flat like everything else: `swiftc -O -o prog <task>.swift`. The rule that top-level
code needs a file called `main.swift` only applies when several files are passed in one
invocation, where `swiftc` has to pick which one holds `main`; with a single file there is
nothing to pick, so the name is free.

Java, D, Nim, Ada, Component Pascal and Oberon-07 prefix the name (`_01_branches.java`,
`_01_branches.d`, `_01_branches.nim`, `t01_branches.adb`, `_01_branches.cp`,
`_01_branches.ob07`), because those languages tie the file name to an identifier and a digit
cannot start one. In Component Pascal and Oberon-07 the compiler enforces the tie — the
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

Builds assume **x86-64**, on Linux, macOS or Windows. `msvc` is the only Windows-only
toolchain, and every other row builds on Windows too, including `flang` and `luajit`. The one
row that is *not* portable is `assembly`: it is a freestanding ELF64 binary built with
`nasm -f elf64` and `ld`, so it is Linux x86-64 only. See `RUN.md` for the full platform
breakdown.

Disk: **23 GB measured** for all 78 toolchains, installed and run on one Windows x64 host.
The heavy terms are LLVM (4.0 GB), Swift (3.2 GB), the AIR SDK (1.6 GB), GNAT with its MSYS2
runtime (1.8 GB, which also supplies `flang`), MSVC (1.2 GB once reassembled from a 2.5 GB
layout), Julia (1.1 GB), Perl (1.0 GB), the .NET SDK (0.7 GB) and GraalVM (0.7 GB); most other
rows are 0.1-0.6 GB.
The six new rows add about 2.4 GB between them, and one term dominates: an MSYS2 tree with
the UCRT64 toolchain, `valac` and its GLib/GObject/GTK build dependencies (**2.2 GB**). The
rest are small — `c3c` with its shipped standard library and LLVM shim (79 MB), GPCP for .NET
(24 MB), the Algol 68 Genie source tree (20 MB), and Cim, the Oberon-07 compiler and the
installed a68g at a few MB each. The AIR SDK is large because it carries a runtime for every
target it supports; the packaging step copies only the one it needs, so each built bundle is
about 60 MB of runtime plus the program.
The four most recent rows are small: OCaml (the MSYS2 `ocaml` and `flexdll` packages, a few
hundred MB inside the MSYS2 tree already counted above for Vala), SBCL (54 MB, extracted from
its MSI), Racket Minimal (74 MB extracted), and the three Clojure jars (4.7 MB).
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

Eight of these need more than a run command.

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

Erlang and Elixir also need a style note that the other 74 rows do not. Neither language has
mutable variables or loop syntax — there is no assignment statement — so every loop in those two
rows is tail recursion with explicit accumulators, which the compiler turns into a jump, plus
`case`/`cond` for the branches. The rows deliberately avoid the functional style (no
`map`/`foldl`/comprehensions/higher-order functions in any timed path) and use the languages' own
escape hatches for state: the process dictionary, and `:atomics`, a real mutable array of 64-bit
integers. That is the most procedural register either language has; it cannot honestly be called
imperative and the rows do not claim to be. Raku needs no such note — it has mutable variables
and `for`/`while`/`loop`, so its row is ordinary imperative code.

VBScript is also the only row here that is being withdrawn. Microsoft's phased deprecation
makes it a Feature on Demand in Windows 11 24H2 — present and enabled at first — then disables
it by default, and finally removes it; `RUN.md` carries the platform detail.

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
| c3c (Windows) | the MSVC SDK to link against, because c3c emits object files and hands them to `lld-link`. Without one it prints `To target x64 you need the MSVC SDK` and offers to download it. A hand-extracted tree works via `--win-sdk` plus three `-L` flags (see the toolchain table above); `--win-vs-dirs` does not accept one. |
| valac | a C compiler and GLib's development files. On Windows both come from MSYS2 `ucrt64` (`mingw-w64-ucrt-x86_64-vala`, which pulls in the GLib/GObject/GTK dependency chain and about 2.2 GB of tree). `valac` has to run inside that shell so `pkg-config` resolves. |
| cim | a C compiler and Cygwin. The compiler and runtime are built once under Cygwin, and `cim.exe` then drives the system `gcc` on every build, so `C:\cygwin64\bin` must be on `PATH` when it runs. |
| gpcp | the .NET runtime, and `RTS.dll` copied next to every executable (plus `RealStr.dll` for the row that formats reals, and the `GP*Files.dll` pair for the file tasks). `CPSYM` must be set or no symbol file is found. |
| a68g, for task 11 only | a source build with `--enable-parallel`. The prebuilt Windows binary is configured without the parallel clause and cannot run task 11 at all. It also needs `C:\cygwin64\bin` on `PATH` when built under Cygwin. |

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
