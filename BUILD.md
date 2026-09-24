# Build requirements

What has to be installed to turn each task's source into something runnable.
For what has to be installed to *run* the result, see `RUN.md`.

Convention below: the source is `main.<ext>` and the output is `prog`. Add the thread
flag where a language needs one, because task 11 uses four threads.

Versions are the current stable release as of September 2026. Anything reasonably recent
works; the minimum column is what the task actually needs, not what happens to be newest.

## Host

Builds assume **x86-64**, on Linux, macOS or Windows. Nothing in the matrix is unavailable on
Windows: `msvc` is the only Windows-only toolchain, and every other row now builds there,
including `flang` and `luajit`. See `RUN.md` for the full platform breakdown.

Disk: **19 GB measured** for all 51 toolchains, installed and run on one Windows x64 host.
The heavy terms are LLVM (4.0 GB), Swift (3.2 GB), GNAT with its MSYS2 runtime (1.8 GB, which
also supplies `flang`), MSVC (1.2 GB once reassembled from a 2.5 GB layout), Julia (1.1 GB),
Perl (1.0 GB), the .NET SDK (0.7 GB) and GraalVM (0.7 GB); most other rows are 0.1-0.6 GB.
Budget another 2-3 GB of scratch space while reassembling MSVC and Swift, since both go
through a multi-gigabyte download that is deleted afterwards. Package caches do not count and
can be far larger than the toolchains themselves.

Beware two installers that quietly pull in more than the toolchain: Alire's `alr toolchain`
bootstraps a full MSYS2 (about 450 MB) plus the GNAT release, and the `alr` assistant runs
that download as a side effect of `--help`. That MSYS2 is not wasted: its `ucrt64` repository
is the practical way to get a working `flang` on Windows.

## Toolchains

### Compiled to native code — nothing needed at run time

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| C | gcc | 9 (C11 + pthreads) | distro package | `gcc -O2 -pthread -o prog main.c` |
| C | clang | 10 | releases.llvm.org | `clang -O2 -pthread -o prog main.c` |
| C | msvc | VS 2019 | Visual Studio Build Tools, C++ workload | `cl /O2 /Fe:prog main.c`. Works without admin: `--layout` the bootstrapper, then reassemble the packages (see below). |
| C | tcc | 0.9.27 | bellard.org/tcc | `tcc -o prog main.c` |
| C++ | g++ | 9 | distro package | `g++ -O2 -pthread -o prog main.cpp` |
| C++ | clang++ | 10 | releases.llvm.org | `clang++ -O2 -pthread -o prog main.cpp` |
| C++ | msvc | VS 2019 | as above | `cl /O2 /EHsc /Fe:prog main.cpp` |
| Rust | rustc | 1.70 (1.63 for scoped threads) | rustup.rs | `rustc -O -o prog main.rs` |
| Zig | zig | 0.16 | ziglang.org/download | `zig build-exe -O ReleaseFast main.zig` |
| Go | gc | 1.20 | go.dev/dl | `go build -o prog main.go` |
| D | dmd | 2.100 | dlang.org/install.sh | `dmd -O -release -of=prog main.d` |
| D | ldc2 | 1.30 | dlang.org/install.sh | `ldc2 -O3 -release -of=prog main.d` |
| Swift | swiftc | 5.8 | swift.org/install | `swiftc -O -o prog main.swift`. Windows needs `-sdk <swift>/Platforms/6.4.0/Windows.platform/Developer/SDKs/Windows.sdk`, and MSVC on PATH for the link step. |
| Fortran | gfortran | 9 | distro package | `gfortran -O3 -o prog main.f90` |
| Fortran | flang | LLVM 17 | MSYS2 `ucrt64` on Windows, distro or LLVM release elsewhere | `flang -O3 -o prog main.f90` (older LLVM: `flang-new`). The official LLVM Windows tarball has no `flang.exe`; MSYS2's `mingw-w64-ucrt-x86_64-flang` plus `-flang-rt` is the working Windows route, and it pulls in the runtime libraries as well. |
| Ada | gnat | 12 | alire.ada.dev | `gnatmake -O3 main.adb` |
| Pascal | fpc | 3.2.2 | freepascal.org | `fpc -O3 -oprogram main.pas`. On Windows x64 there is no native compiler: install the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, then build with `-Px86_64`. |
| Nim | nim | 2.0 | nim-lang.org | `nim c -d:release -o:prog main.nim` |
| Odin | odin | dev-2024 | odin-lang.org | `odin build . -o:speed` |
| Kotlin | kotlin/native | 1.9 | kotlinlang.org | `kotlinc-native -opt -o prog main.kt` |
| Java | graalvm native-image | 21 | graalvm.org | `native-image -O2 Main`. Emits a standalone native executable, so it belongs here and not with the bytecode rows. |
| C# | nativeaot | .NET 8 | dotnet.microsoft.com | `dotnet publish -c Release -p:PublishAot=true`. Emits a native executable. |
| Dart | aot | 3.3 | dart.dev | `dart compile exe -o prog main.dart`. Emits a native executable. |
| Python | nuitka | 4.0 | nuitka.net | `nuitka --standalone main.py`. Compiles to C and then to a binary. |
| Assembly | nasm | 2.15 | nasm.us | `nasm -f elf64 main.asm && ld -o prog main.o` |

### Compiled to bytecode — the VM is needed on every run

These compile once, but the output is bytecode or an intermediate form, so a virtual machine
has to start on every measured run. That startup is part of the number.

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| Java | openjdk | 17 | jdk.java.net or Adoptium | `javac Main.java` |
| Kotlin | jvm | 1.9 | kotlinlang.org | `kotlinc main.kt -include-runtime -d prog.jar` |
| C# | coreclr | .NET 8 | dotnet.microsoft.com | `dotnet build -c Release` |
| C# | mono | 6.12 | mono-project.com | `mcs -optimize+ main.cs` |
| F# | dotnet | .NET 8 | as above | `dotnet build -c Release` |
| Scala | jvm | 3.3 | scala-lang.org | `scalac -release 17 main.scala` |

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
| Nushell | nu |
| PowerShell | powershell, pwsh |

Note that three of these are JITs rather than plain interpreters, and the distinction matters
for the numbers: `luajit`, `php zend + jit` and `cruby + yjit` all start out interpreting
and compile hot loops as they run, so their first seconds are slower than their steady state.
A short task therefore measures the warm-up, not the JIT.

`Python / graalpy` needs a full GraalVM install, which is a several-hundred-megabyte download
and the slowest thing on this page to set up.

## Toolchains that need something else first

| Toolchain | Also needs |
|---|---|
| graalvm native-image | a C toolchain, `zlib` headers, and several GB of RAM. On Windows, the MSVC linker (`link.exe`) on `PATH` plus `INCLUDE`/`LIB`. |
| kotlin/native | an LLVM toolchain and a C toolchain. On Windows, a JDK **17** via `JAVA_HOME`: the launcher parses `java -version` with `delims=-.` and breaks on JDK 24, which prints `24` with no dot, leaving a stray quote in `if %_java_major_version% geq 24`. The result is a batch syntax error rather than a clear message. |
| swiftc | the Swift toolchain ships its own LLVM, needs `libcurl` and `libxml2`. On Windows it needs the MSVC toolchain to link, and `-sdk` pointing at the bundled Windows SDK. The Windows distribution is a WiX burn bundle, so a plain `--layout` copy is not enough: `tools/get_swift.py` decompiles it with WiX's `dark.exe`, reads the burn manifest to recover the real package names (the extracted files are `a0`, `a1`, ...), stages each MSI next to its `.cab`, and administrative-extracts them. |
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
  `tools/get_msvc.py` runs `vs_BuildTools.exe --layout` to download the packages unelevated,
  and `tools/reassemble_msvc.py` rebuilds a working `cl.exe` from them; `tools/msvc_env.py`
  prints the PATH/INCLUDE/LIB it needs. Four things bite during that reassembly:
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

Task 14 and task 15 share a 100 MiB fixture, and every expected output was computed with a
trusted implementation. Keeping those reproducible needs:

- a C compiler, for the reference implementations
- Python 3.10 or newer, for the fixture generator

Both are already covered above.
