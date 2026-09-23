# Build requirements

What has to be installed to turn each task's source into something runnable.
For what has to be installed to *run* the result, see `RUN.md`.

Convention below: the source is `main.<ext>` and the output is `prog`. Add the thread
flag where a language needs one, because task 11 uses four threads.

Versions are the current stable release as of September 2026. Anything reasonably recent
works; the minimum column is what the task actually needs, not what happens to be newest.

## Host

Builds assume **Linux x86-64**. That is not arbitrary - `nvfortran` and `hhvm` do not exist
on Windows, so the matrix cannot be completed anywhere else. Windows is usable through
WSL2. See `RUN.md` for the full platform breakdown.

Disk: roughly **25 GB** for all 59 toolchains, dominated by MSVC, the NVIDIA HPC SDK,
GraalVM and the JDK. A single-language install is usually under 1 GB.

## Toolchains

### Compiled to native code

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| C | gcc | 9 (C11 + pthreads) | distro package | `gcc -O2 -pthread -o prog main.c` |
| C | clang | 10 | releases.llvm.org | `clang -O2 -pthread -o prog main.c` |
| C | msvc | VS 2019 | Visual Studio Build Tools, C++ workload | `cl /O2 /Fe:prog main.c` |
| C | tcc | 0.9.27 | bellard.org/tcc | `tcc -o prog main.c` |
| C++ | g++ | 9 | distro package | `g++ -O2 -pthread -o prog main.cpp` |
| C++ | clang++ | 10 | releases.llvm.org | `clang++ -O2 -pthread -o prog main.cpp` |
| C++ | msvc | VS 2019 | as above | `cl /O2 /EHsc /Fe:prog main.cpp` |
| Rust | rustc | 1.70 (1.63 for scoped threads) | rustup.rs | `rustc -O -o prog main.rs` |
| Zig | zig | 0.16 | ziglang.org/download | `zig build-exe -O ReleaseFast main.zig` |
| Go | gc | 1.20 | go.dev/dl | `go build -o prog main.go` |
| Go | gccgo | GCC 11 | `apt install gccgo` | `gccgo -O3 -o prog main.go` |
| D | dmd | 2.100 | dlang.org/install.sh | `dmd -O -release -of=prog main.d` |
| D | ldc2 | 1.30 | dlang.org/install.sh | `ldc2 -O3 -release -of=prog main.d` |
| D | gdc | GCC 11 | `apt install gdc` | `gdc -O3 -o prog main.d` |
| Swift | swiftc | 5.8 | swift.org/install | `swiftc -O -o prog main.swift` |
| Fortran | gfortran | 9 | distro package | `gfortran -O3 -o prog main.f90` |
| Fortran | flang | LLVM 17 | part of LLVM | `flang -O3 -o prog main.f90` (older LLVM: `flang-new`) |
| Fortran | nvfortran | 23.5 | NVIDIA HPC SDK | `nvfortran -O3 -o prog main.f90` |
| Ada | gnat | 12 | alire.ada.dev | `gnatmake -O3 main.adb` |
| Pascal | fpc | 3.2 | freepascal.org | `fpc -O3 -oprogram main.pas` |
| Delphi | dcc | 11 | embarcadero.com | `dcc64 main.pas` (optimization flag is `-$O+`, not `-O2`) |
| Nim | nim | 2.0 | nim-lang.org | `nim c -d:release -o:prog main.nim` |
| Odin | odin | dev-2024 | odin-lang.org | `odin build . -o:speed` |
| Kotlin | kotlin/native | 1.9 | kotlinlang.org | `kotlinc-native -opt -o prog main.kt` |
| Assembly | nasm | 2.15 | nasm.us | `nasm -f elf64 main.asm && ld -o prog main.o` |

### Compiled to bytecode or an intermediate form

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| Java | openjdk | 17 | jdk.java.net or Adoptium | `javac Main.java` |
| Java | graalvm native-image | 21 | graalvm.org | `native-image -O2 Main` |
| Kotlin | jvm | 1.9 | kotlinlang.org | `kotlinc main.kt -include-runtime -d prog.jar` |
| C# | coreclr | .NET 8 | dotnet.microsoft.com | `dotnet build -c Release` |
| C# | nativeaot | .NET 8 | as above | `dotnet publish -c Release -p:PublishAot=true` |
| C# | mono | 6.12 | mono-project.com | `mcs -optimize+ main.cs` |
| F# | dotnet | .NET 8 | as above | `dotnet build -c Release` |
| Scala | jvm | 3.3 | scala-lang.org | `scalac -release 17 main.scala` |
| Mojo | mojo | 24.4 | modular.com | `mojo build -O3 main.mojo` |
| Dart | aot | 3.3 | dart.dev | `dart compile exe -o prog main.dart` |

### No build step

These are interpreted or JIT-compiled, so there is nothing to compile and their compile
time is zero. Everything is paid at run time.

| Language | Toolchain |
|---|---|
| JavaScript | node, bun, deno |
| PHP | zend, zend + jit, hhvm |
| Python | cpython, pypy, graalpy |
| Ruby | cruby + yjit, jruby, truffleruby |
| Lua | puc-lua, luajit |
| Perl | perl |
| R | gnu-r, fastr |
| Julia | julia |
| Dart | jit |
| GDScript | godot --headless |
| Nushell | nu |
| PowerShell | powershell, pwsh |

Two exceptions that look interpreted but are not:

- **Python / nuitka** compiles to C and then to a binary, so it needs a working C compiler
  in addition to Python. `nuitka --standalone --lto=yes main.py`
- **Ruby / truffleruby** and **Python / graalpy** need a full GraalVM install, which is a
  several-hundred-megabyte download and the slowest thing on this page to set up.

## Toolchains that need something else first

| Toolchain | Also needs |
|---|---|
| nuitka | a C compiler (gcc or clang) |
| graalvm native-image | a C toolchain, `zlib` headers, and several GB of RAM |
| kotlin/native | an LLVM toolchain and a C toolchain |
| swiftc | the Swift toolchain ships its own LLVM, needs `libcurl` and `libxml2` |
| gdscript | a Godot build, run with `--headless` |
| lua, for task 11 only | the Lanes C extension: `luarocks install lanes`. Needs a C compiler. Stock Lua has no threads. |
| hhvm | none, but see below |

## Things that are hard or not really possible

Worth knowing before starting, because these will eat a day each:

- **hhvm** dropped PHP support in 2018 and is a Hack-only runtime now. There is no current
  PHP mode. Expect this cell to be `SKIPPED` or to need an old 3.x release.
- **fastr** was an experimental GraalVM R implementation that never reached production.
  It is not in current GraalVM releases. Expect `SKIPPED`.
- **nvfortran** is free but requires an NVIDIA developer account and EULA acceptance to
  download, and it is a multi-gigabyte SDK.
- **delphi** `dcc` is commercial. The free Community Edition is Windows-only and has
  revenue restrictions on use.
- **msvc** only exists on Windows. Use WSL2 plus a Windows-side install, or drop the two
  msvc columns.
- **tcc** is unmaintained and only implements C99. It will not handle everything the other
  C compilers do.
- **gdscript** threads exist but are awkward, and Godot headless startup alone is on the
  order of a second, which will dominate every short task.
- **mojo** is Linux and macOS only, and changes quickly.

## Reference implementations

Task 14 and task 15 share a 100 MiB fixture, and every expected output was computed with a
trusted implementation. Keeping those reproducible needs:

- a C compiler, for the reference implementations
- Python 3.10 or newer, for the fixture generator

Both are already covered above.
