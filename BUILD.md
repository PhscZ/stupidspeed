# Build requirements

What has to be installed to turn each task's source into something runnable.
For what has to be installed to *run* the result, see `RUN.md`.

Convention below: `<task>` is the task's own name, so the source for task 01 in C is
`sources/c/01_branches.c`, and the output is `prog`. Add the thread flag where a language
needs one, because task 11 uses four threads.

The bullets below do not follow the flat `<task>.<ext>` layout, and each says why. A toolchain
that needs a directory of its own rather than a differently named file is a separate case and is
described after the list:

- **C#, F# and VB.NET** keep a folder per task (`01_branches/01_branches.csproj`) because the
  .NET SDK does not support several projects in one directory: `dotnet build` with no project
  argument fails when the folder holds more than one `.csproj`, and the projects would share
  one `obj/` and `bin/`.
- **Fortran task 03** is two files, `03_func_sum.f90` and `03_func_sum_add_one.f90`, because
  the no-inline requirement needs a second translation unit. **Task 06 builds its 250 MB text
  from a runtime repeat count, not a literal** (`reps = 25000000` then
  `repeat(block, reps)`): gfortran and LFortran both constant-fold a literal count into a
  250 MB static initializer, which lands in `.rdata` and produces a 250 MB `prog.exe` — over
  GitHub's 100 MB file limit, and a compile-time fold of the task rather than a measurement of
  it. With the count in a variable the library call builds the string at run time, as the C row
  does, and the executable is about 100 KB.
- **Modula-2 task 03** is three files, `03_func_sum.mod`, `Func.def` and `Func.mod`, for the
  same reason: the caller only sees the declaration, so the 400000000 calls cannot be
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
- **Beef** keeps a directory per task (`01_branches/01_branches.bf`) because BeefBuild builds
  *projects*, not files: a workspace is a `BeefSpace.toml` naming its projects, a project is a
  `BeefProj.toml` naming its sources and its `StartupObject`, and `-proddir=` points at the task
  directory. Each task therefore carries a two-file wrapper beside its source. Task 03 is three
  files: `03_func_sum.bf`, `03_func_sum_add_one.bf` and the wrapper that lists both.
- **Haxe** needs `T01_branches.hx` … `T15_file_write.hx`, because a Haxe module's type name must
  equal its file name and start with an uppercase letter — the lexer's `idtype` is
  `'_'* 'A'..'Z' (alnum|'_')*` — so neither `01_branches.hx` nor `_01_branches.hx` is a legal
  module.
- **Scheme and Prolog (SWI) task 03** each keep the helper in a second file beside the task —
  `03_func_sum_add_one.ss` and `.pl` — which is the same shape as the Fortran, Tcl and Vala
  entries above, so it is one case here and not two. **Standard ML task 03** joins this group
  with `03_func_sum_add_one.sml`: it has no per-function marker at all and needs
  `PolyML.Compiler.maxInlineSize := 0` set before the helper is loaded, because a separate
  file alone is not enough there. **Mercury task 03** is two modules, `03_func_sum.m` and `03_func_sum_add_one.m`: `no_inline` emits no C
  attribute, and the recurrence is affine with a loop-invariant trip count, so GCC otherwise
  computes `start + (N - I)` in closed form and deletes the loop and the call together. The
  second module puts `add_one`'s body in its own translation unit, the same barrier the
  Fortran, Tcl and Vala rows use.
- **Standard ML** keeps a build driver per task, `build/<task>.ML`, holding
  `use "<task>.sml"; PolyML.export ("<task>", main);`, because the MSI ships no `polyc` and the
  two steps it would have driven are run by hand (see the toolchain table). The task sources
  themselves are flat: `01_branches.sml` … `15_file_write.sml`.

Swift is flat like everything else: `swiftc -O -o prog <task>.swift`. The rule that top-level
code needs a file called `main.swift` only applies when several files are passed in one
invocation, where `swiftc` has to pick which one holds `main`; with a single file there is
nothing to pick, so the name is free.

Java, D, Nim, Ada and Haxe prefix the name
(`_01_branches.java`, `_01_branches.d`, `_01_branches.nim`, `t01_branches.adb`,
`T01_branches.hx`), because those languages tie the file name to an identifier and a digit
cannot start one — in Haxe's case the identifier must additionally start with an uppercase
letter, which is why its prefix is `T` and not `_`.

Most toolchain rows share their language's main source directory — `sources/c/` is built by
`gcc`, `clang`, `msvc` and `tcc`, `sources/d/` by `dmd` and `ldc2`, `sources/java/` is compiled
once and run by all four HotSpot configurations, `sources/rust/` by `rustc` and
`rustc (cranelift)`, and the eight WebAssembly modules under `exec/*-wasm/` are each run by six
runtimes. Those are the rows where the front end is held fixed and the backend is the only
variable, so the sources being shared is the point, not an economy. A row
whose source cannot be shared gets a directory of its own, holding **all fifteen tasks** and
duplicating the files it has in common with the main row. Eighteen rows are in that position:

| Row | Directory | What differs from the main row |
|---|---|---|
| Kotlin native | `sources/kotlin-native/` | tasks 11, 14, 15: the stdlib `Worker` and `kotlinx.io` replace `java.lang.Thread` and `java.io` |
| Java openj9 | `sources/java-openj9/` | nothing — same fifteen files, a different VM executes them |
| Java graalvm jit | `sources/java-graalvm-jit/` | nothing — same fifteen files, GraalVM's JIT compiles them |
| Java graalvm native-image | `sources/java-graalvm-native/` | nothing — same fifteen files, compiled ahead of time |
| Scala native | `sources/scala-native/` | nothing — same fifteen files, built to LLVM IR by Scala Native |
| Common Lisp ecl | `sources/commonlisp-ecl/` | the bodies, not just the header: ECL is a different implementation, so the declarations are `fixnum` where SBCL's are `(signed-byte 64)`, the case clauses end in `t` where SBCL's end in `otherwise`, tasks 11 and 14 use ECL's own thread and stream forms, and task 03 uses `(declaim (notinline add-one))` instead of the separate `03_func_sum_add_one.lisp` the SBCL row needs |
| Erlang compiled | `sources/erlang-compiled/` | the module form: `-module`/`-export` and `main/0` replace the escript row's shebang and `main/1`, because `erlc` cannot compile a script that has no module declaration |
| Python cython | `sources/python-cython/` | nothing — same fifteen files, `cython --embed` compiles them |
| Lua wasip1 | `sources/lua-wasm/` | task 11: coroutines, because Lanes has no wasm build |
| C wasm32-wasip1 | `sources/c-wasm/` | nothing — the same sources build for both targets |
| C++ wasm32-wasip1 | `sources/cpp-wasm/` | nothing |
| Rust wasm32-wasip1 | `sources/rust-wasm/` | nothing |

| Assembly masm | `sources/masm/` | the whole source: the same fifteen tasks in MASM syntax, because the two assembly rows differ in assembler and the syntax is the toolchain |
| Zig wasm32-wasip1 | `sources/zig-wasm/` | task 11: raw WASI `clock_time_get` and `fd_write` imports, because the threads+atomics build instantiates no `std.Io`; the other fourteen differ only in the header |

The duplication is deliberate: a row's directory holds the whole program it builds, so reading
one folder tells you what that toolchain runs and no file has to be traced across two
directories. Where a file is a byte-for-byte copy of the main row's, the row's entry in the
toolchain table below says so.

The version column is the **minimum** that works, not the newest release. Anything
reasonably recent works; it is what the task actually needs, not what happens to be current.

## Timing

Every task program times its own work and prints one line, `TIME_MS=<milliseconds>`, on
**stderr**; the answer still goes to **stdout**, unchanged, and the expected-output check
compares stdout only. `RUN.md` defines the contract — the timer starts at the entry of the
program's own body and stops immediately before the final output statement. What follows is
the part that belongs here: the clock each row uses, and the rows that cannot meet the
contract exactly.

**The clock.** Rows use their language's own monotonic clock, so the reported number is elapsed
time and not a wall-clock reading that a time sync can move. Three kinds of clock deviate, and
each is recorded in the source's own `timing:` comment:

- **Processor-time clocks** — `mercury` reads CPU time (`clock()`) rather than elapsed time.
  It is a single-threaded program, so CPU time and elapsed time are the same quantity there.
- **Time-of-day clocks** — readings of the system clock, which a time sync can move:
  `cobol` (`ACCEPT ... FROM TIME`, `hhmmsscc`), `hashlink` (`Sys.time()`),
  `haskell` (`getPOSIXTime`), `ocaml` (`Unix.gettimeofday`) and `swift` (`Date()`).
- **VM-relative counters** — `actionscript` (`getTimer()`, ms since the VM started).
  These do not move with the system clock, but they are not monotonic clocks either.

**Coarse clocks.** Two rows cannot resolve better than the work they bracket: `cobol`
(10 ms) and `modula2` (whole seconds plus `SysClock.fractions`). Their cells are read with
that granularity in mind; `RUN.md` says so again where the row is discussed.

**The `time.txt` fallback.** A row whose language exposes no standard-error stream writes the
same line to a file `time.txt` in the working directory instead, exactly as `RUN.md` describes:
`actionscript`, `luau`, `modula2` and `scheme`.

**No row is inspection-only any more.** Five rows — `cobol`, `modula2` and `swift` — were
instrumented by inspection, because their toolchains were absent at the time, and the same was
true of `beef` and `swipl`. All five toolchains are installed on this machine now, and every one
of those rows has been verified end to end (15/15 each). This is a statement about this machine,
not about the rows.

Every row also has a **row verifier** at `exec/<row>/verify.py` that runs the fifteen tasks and
checks the answer, the timing line and task 15's file — the convention is described in
`RUN.md`'s Measurement tooling section. The four rows that had none (`actionscript`, `ada`,
`assembly`, `assemblyscript`) have one now, so no row is checked
by hand.

## Host

Builds assume **x86-64**, on Linux, macOS or Windows. `msvc` is the Windows-only
toolchain, and the two `assembly`
rows are Windows x64 only: each is a freestanding PE program built with `nasm -f win64` or
`ml64.exe` and linked with `link.exe` against `kernel32.dll`. Every other row builds on Windows
too, including `flang` and `luajit`. See `RUN.md` for the full platform breakdown.

Disk: the installs measured on one Windows x64 host run to tens of gigabytes, and the heavy
terms are LLVM (4.0 GB), Swift (3.2 GB), the AIR SDK (1.6 GB), GNAT with its MSYS2
runtime (1.8 GB, which also supplies `flang`), MSVC (1.2 GB once reassembled from a 2.5 GB
layout), Julia (1.1 GB), Perl (1.0 GB), the .NET SDK (0.7 GB) and GraalVM (0.7 GB); most other
rows are 0.1-0.6 GB.
An earlier batch of four rows added about 2.2 GB between them, and one term dominates: an MSYS2
tree with the UCRT64 toolchain and the GLib/GObject/GTK build dependencies the `tcl`, `ocaml`,
`objectivec` and `vala` rows need from it (**2.2 GB**; `valac` is one package inside that same
tree, so restoring the Vala row adds a few tens of MB to a tree already counted).
The rest are small — Cim at a few MB. The AIR SDK is large because it carries a runtime for every
target it supports; the packaging step copies only the one it needs, so each built bundle is
about 60 MB of runtime plus the program.
The four rows after that are small: OCaml (the MSYS2 `ocaml` and `flexdll` packages, a few
hundred MB inside the MSYS2 tree already counted above), SBCL (54 MB, extracted from
its MSI), Racket Minimal (74 MB extracted), and the three Clojure jars (4.7 MB).
The batch after that adds about 2.1 GB. The terms are moderate or small —
Beef 845 MB, the Scala Native pair (scala-cli 131 MB plus the portable llvm-mingw 675 MB, and
27 MB of Scala Native artifacts in the package cache), the SWI-Prolog tree 133 MB, Haxe with
Neko and hxcpp 112 MB, J 16 MB and Chez Scheme 7 MB.
**Poly/ML** adds 11 MB: the MSI's whole
payload is three files, plus the tarball's stub and a 187 KB import library.
**GraalVM JIT** adds nothing at all: it
is the same GraalVM JDK the `graalpy` and `graalvm native-image` rows already install (measured
here: 771 MB extracted). The Go SDK (264 MB, measured) drives both the `gc` and `go-wasm` rows.
The newest batch adds about **0.4 GB**: the two hardware-description rows are gone, and in
their place come **OpenJ9 at 388 MB** — the IBM Semeru JDK zip, extracted, with its own `javac`
and `java` — and **MASM**, which installs nothing, because `ml64.exe` and `link.exe` come from
the MSVC tree the `msvc` row already has. The `nasm` row's Windows build likewise reuses the
assembler already on the host. The rows after it add about **4.2 GB**, almost all of it one
term: **GHC at 4.1 GB**, extracted from a 452 MB `.tar.xz`, because the bindist carries a
complete MinGW toolchain and the libraries for every package that ships with it. **gforth** is
about 100 MB.
**Three restored rows** add about **0.2 GB**: **Mercury** 112 MB from a source
build, **Kotlin** (jvm) 94 MB for the compiler zip, and **Cython** a 15 MB `pip install`.
The 23 removed rows take their installs with them, so the totals this file used to quote no
longer apply. `tinygo` is back on the `go` row and its
1.3 GB tree was never deleted, so it is counted here again. Nineteen dead trees were deleted --
**gdc** (556 MB, the 2015 build RUN.md records as dropped), **emacs** (210 MB), **jython**
(50 MB), **ironpython** (45 MB), **duckdb** (37 MB), **j9.7** (16 MB, the removed J row),
**sqlite** (15 MB), **cim**/**cim-src** (6 MB, the removed Simula row), **arc** (1.3 MB), **alire** (45 MB -- just
`alr.exe`; the `ada` row uses `alire_home/`), **a68g** (6.4 MB), **autohotkey** (4.4 MB), **groovy** (33 MB) and
**euphoria** (52 MB), **python-wasm** (173 MB), **ruby-wasm** (101 MB) and **mlton** (18 MB),
the last seven dropped from the matrix, about **1.4 GB** in all. Each was either a row the
matrix no longer has or a toolchain it never had. **TinyGo** (1.3 GB, the biggest tree any single
toolchain here needs) is *not* in that list: its `tinygo-wasm` row was removed on 2026-10-14 but
the tree stayed, and on 2026-10-15 the native `tinygo` toolchain came back on the `go` row, so
the install it already had is what builds it. Four toolchains were added on 2026-10-10 and each is
cheap except one: **CompCert** 10 MB for the compiler plus **277 MB** for the build recipe and its
pinned sources, and **LFortran**, which is a package inside the MSYS2 tree the
`fortran` row already installs and adds no new tree at all (the two new front ends that need no
tree — `zig c++` and `nim (clang)` — reuse the Zig and LLVM trees and add nothing). The **wasm3**
toolchain was added and then removed again the same day (348 KiB for the runtime plus 216 MB for
`tools/wasm3-src/`), so it is not in the count; `tools/wasm3/` and `tools/wasm3-src/` are gone.
**`gnat llvm` is built here** and adds about **190 MB** (its `bin` and `lib`, the Ada runtime
included) under `tools/gnat-llvm/llvm-interface/`; the source tree that produced it is
`tools/gnat-llvm-src/` (about 700 MB with GCC's Ada sources, LLVM's Ada bindings and the build
objects). It links against **MSYS2 UCRT64's own LLVM 22.1.8 and GCC 16.2**, not the separate
LLVM tree the `c`/`cpp`/`llvm-ir` rows use, because the Ada compiler has to share a C runtime
with the LLVM libraries it links — see the toolchain table below.
The expensive term is the **Cygwin tree, now 2.1 GB and inside `tools/`** rather than outside it:
CompCert's only Windows target is `x86_64-cygwin`, and building it needs Cygwin's gcc 14.4.0,
OCaml 4.14.2, dune 3.18.1, findlib 1.9.6, zarith 1.14, menhir 20250903 and a from-source
**Coq 8.20.1**. Unlike the host-only Cygwin tree this file counted before, this one is **needed
at run time by one row** — `c`/`compcert` — because its programs import
`cygwin1.dll`; see RUN.md. `tools/compcert_build/src/` (256 MB of pinned sources) can be deleted
if space is tight, since it is only needed to rebuild.
The Lua row adds almost nothing on top of the others: its build reuses the `wasi-sdk` tree the
C row already installs and adds only a 716 KB `lua.wasm`.
Budget another 2-3 GB of scratch space while reassembling MSVC and Swift, since both go
through a multi-gigabyte download that is deleted afterwards. Package caches do not count and
can be far larger than the toolchains themselves.

Beware one installer that quietly pulls in more than the toolchain: Alire's `alr toolchain`
bootstraps a full MSYS2 (about 450 MB) plus the GNAT release, and the `alr` assistant runs
that download as a side effect of `--help`. That MSYS2 is not wasted: its `ucrt64` repository
is the practical way to get a working `flang` on Windows.

## The compilation pipeline

The four sections below group the rows by what the **artifact** is — a native executable, a
WebAssembly module, a bytecode file, or nothing at all. This section groups them by what happens
to get there, because that is what decides whether a cell's number contains compilation.

**The backend, and why it is the axis that matters.** Each of the seven shapes below is a
different *kind* of execution; the **backend** is the specific component doing it. `exec/cells.json`
carries a `backend` id on every toolchain entry and a `backends` table naming what each one is,
and `exec/harness.py` groups its tables by it. The other axis is the **front end**: a language and
the toolchain that builds or runs it, which is what a row of the results table is. There are 147
of those over 58 languages and only 63 backends — 148 placements, because Luau's one toolchain
runs its tasks on two engines — and the counts are not spread evenly:

| Backend | Front ends | The rows |
|---|---|---|
| LLVM | 21 | `c`/`cpp` (clang), `rust`, `swift`, `zig`, `d` (ldc2), `fortran` (flang), `fortran` (ifx), `fortran` (lfortran), `llvm-ir` (llc), `crystal`, `odin`, `beef`, `pony`, `lean4`, `kotlin` (native), `scala` (native), `objectivec`, `nim` (clang), `ada` (gnat llvm), `go` (tinygo) |
| GCC | 12 | `ada` (gnat), `fortran` (gfortran), `c` (gcc), `cpp` (g++), `cobol`, `vala`, `nim`, `mercury`, `python` (cython), `python` (nuitka), `haxe` (hxcpp), `nim` (cpp) |
| V8 | 11 | six of those same modules under node's WASI shim, plus `javascript` (deno), `scala-js`, `clojurescript`, `haxe` (js) and `kotlin` (js) |
| wasmtime (Cranelift) | 8 | seven of the `wasm32-wasip1` modules, plus `lua-wasm` |
| wasmtime (Winch) | 7 | the same compiled modules under wasmtime's baseline compiler |
| Wasmer (Cranelift) | 6 | the same modules under Wasmer's Cranelift compiler |
| Wasmer (LLVM) | 6 | the same modules under Wasmer's LLVM compiler |
| WAMR (iwasm) | 6 | the same modules under a fourth runtime |
| HotSpot (tiered C1 + C2) | 5 | `java` (openjdk), `kotlin` (jvm), `scala` (jvm), `clojure`, `haxe` (jvm) |
| CoreCLR | 3 | `csharp`, `fsharp`, `vbnet` |
| MSVC | 3 | `c`/`cpp` (msvc), `commonlisp` (ecl) |
| BEAM | 3 | `erlang` (escript), `erlang` (erlc), `elixir` — one VM, three front ends, and a compile-once/compile-every-run pair inside it |
| none — hand-written machine code | 3 | `assembly` (nasm, masm, fasm) |
| Chez Scheme | 2 | `racket` (CS), `scheme` |
| GraalVM JIT | 2 | `java` (graalvm jit), `python` (graalpy) |
| Mono | 2 | `csharp` (mono), `haxe` (cs) |
| zig cc / zig c++ | 2 | `c` (zig cc), `cpp` (zig c++) |
| 47 more | 1 each | backends only one front end here uses |

Three more HotSpot configurations sit beside the default: `openjdk (interp)` (`-Xint`, kind
`bytecode-vm`), `openjdk (c1)` (`-XX:TieredStopAtLevel=1`) and `openjdk (c2)`
(`-XX:-TieredCompilation`), which run the *same* class files on one code generator each.

`exec/harness.py --backends` prints this table from the registry, with every backend's kind and
the languages its front ends are written in.

**Twelve front ends share one code generator.** Ada, C, C++, COBOL, Fortran, Haxe, Mercury,
Nim's two C and C++ back ends, Python's Cython and Nuitka rows, and Vala all hand their output
to GCC; the only thing the cell measures about "the language" is what the front end emitted before gcc
started. That is not a defect in the matrix — the front end's output quality is a real property
of the language — but it does mean a reader comparing `ada` against `c` is comparing two GCC
front ends, not two compilers, and a reader comparing `ada` against `rust` is comparing GCC
against LLVM with each language's front end folded in.

**Three front ends share the BEAM**, and they are the axis's cleanest illustration after GCC:
`erlang` and `elixir` are two languages on one VM, and `erlang`'s two toolchains differ only in
when the compile happens. All three land in the same `native-jit` kind, so their numbers are
comparable, and the differences between them are exactly what the front end and the compile
timing cost.

**The WebAssembly runtimes are the other clean group.** Seven modules are plain
`wasm32-wasip1`, so the same bytes run under wasmtime's two code generators, Wasmer's two,
perfectly fixed. That is the strongest form of the comparison this axis enables, and it is why
`cranelift`/`winch` and Wasmer's two are separate backends rather than one each: the compiler
is the variable. The Wasmer rows are the sharpest — one binary, one command line, two code
generators, and a measured spread of 172 ms (Cranelift) against 109 ms (LLVM) on `c-wasm`
task 01. Wasmer's third generator, `--singlepass`, and the `wasm3` interpreter were removed
on 2026-10-10; RUN.md records what each could not run.
**`kind` is the coarse version of the same idea** and is what makes two cells comparable at all:
`native-aot`, `native-jit`, `wasm-runtime`, `bytecode-vm`, `interpreter`, `assembler`. Two rows
with the same kind measure the same *sort* of thing; two rows with different kinds do not, which
is the point made under [What this means for reading a row](#what-this-means-for-reading-a-row)
below.

**Why it matters.** The self-timing contract in `RUN.md` starts the clock at the first statement
of the program's own body. A row that compiles ahead of time has already finished parsing, type
checking, optimising and generating code by then. A row that compiles on every run has not, and
that work lands either inside the measured number or just before it, depending on where the
compiler puts it. `java`/`openjdk` against `java`/`graalvm native-image` is the cleanest
surviving illustration in the matrix: the same class files, JIT-compiled at run time in one row
and turned into a native image ahead of time in the other, with nothing else changed. `dart`
`jit` against `dart` `aot` makes the same point. The split runs through the whole table, so a
row is only comparable with another row of the same shape.

Seven shapes appear below. Each entry names the stages the toolchain actually runs.

### 1. One compiler, source to machine code

The compiler parses, type-checks, optimises and emits machine code, then a linker produces the
executable. Nothing between the source and the CPU survives to run time, so the measured cell is
the program alone.

| Rows | Stages |
|---|---|
| `c` (gcc, clang, msvc) | preprocess → compile → assemble → link |
| `c` (tcc) | one pass, compile and link together, no optimisation |
| `cpp` (g++, clang++, msvc) | preprocess → compile → assemble → link |
| `rust` | parse → HIR → MIR → LLVM IR → object → link |
| `zig` | AST → ZIR → LLVM IR → object → link (ships its own LLVM and lld) |
| `go` | parse → type check → SSA → object → link, with its own backend and linker, no LLVM |
| `d` (dmd) | direct to object with its own backend; (ldc2) LLVM IR |
| `fortran` (gfortran) | the GCC pipeline; (flang) LLVM IR |
| `swift` | parse → SIL → LLVM IR → object → link |
| `ada` | the GCC pipeline (`gnatmake` drives `gcc`); `gnat llvm` is the same front end lowered to LLVM IR (`llvm-gnatmake`) |
| `pascal` | `fpc` direct to object, its own backend |
| `crystal` | type inference → LLVM IR → object → link |
| `odin` | LLVM IR → object → link |
| `beef` | LLVM IR → object → link |
| `objectivec` | clang: preprocess → compile → assemble → link |
| `haskell` | parse → Core → STG → Cmm → native code (its own code generator) |
| `ocaml` (`ocamlopt`) | typed lambda → Cmm → assembly → assemble → link |
| `pony` | type check → LLVM IR → object → link |
| `scala-native` | scalac → NIR → LLVM IR → clang → link |
| `standardml` | Poly/ML compiles to native code with its own code generator, then gcc links its `.obj` with `polystub.obj` |
| `modula2` | a small self-contained compiler, direct to object |
| `assembly` (nasm, masm, fasm) | assemble to object → link; see shape 5 |

### 2. Source to C or C++, then the C compiler

The toolchain translates the language to C or C++, then hands that to a C compiler. Two
compilers are involved, and the C compiler is usually the one doing the optimisation, which is
why several of these rows need an explicit flag to pass optimisation through.

| Rows | Stages |
|---|---|
| `vala` | valac → C → gcc (`-X -O2` is what forwards `-O2`) |
| `nim` | nim → C → gcc (`nim`), → C++ → g++ (`nim` cpp), or → C → clang (`nim` clang, LLVM) |
| `lean4` | `lean -c` → C → `leanc` (Lean's own clang) |
| `haxe` (hxcpp) | Haxe → C++ → hxcpp → g++ |
| `commonlisp` (ecl) | ECL → C → cl.exe (pointed at the MSVC tree by `c::*cc*`) |
| `mercury` | `mmc` → C → gcc |
| `python` (cython) | Cython → C → gcc, with CPython's headers |
| `python` (nuitka) | Nuitka → C → the C compiler, plus the CPython runtime it links in |
| `cobol` | `cobc -x` generates C, then the C compiler builds it |

### 3. Source to bytecode, then a virtual machine

The front end emits bytecode for a VM that is not the CPU. The VM may then interpret that
bytecode, JIT it, or both — so the row's number depends on the VM's strategy as much as on the
language. Where a row has several VMs, that is the point of the row.

| Rows | Stages |
|---|---|
| `java` (openjdk, openj9) | javac → `.class` → HotSpot or OpenJ9 at run time. The `openjdk` toolchain is the default tiered pipeline (C1, then C2); `openjdk (interp)`, `(c1)` and `(c2)` run the *same* class files on one code generator each, so the four are a controlled comparison of HotSpot's own backends |
| `java` (graalvm jit) | javac → `.class` → GraalVM's JIT |
| `java` (graalvm native-image) | javac → `.class` → ahead-of-time native image |
| `kotlin` | kotlinc → JVM bytecode (jvm row) or native (native row) |
| `csharp` | Roslyn → IL → CoreCLR JIT, NativeAOT, or Mono |
| `fsharp`, `vbnet` | their compiler → IL → the same runtime |
| `scala` | scalac → JVM bytecode |
| `clojure` | clojure.main → JVM bytecode on every run |
| `scala-js` | scalac → **JavaScript** → V8 — Scala's third backend beside the JVM and Scala Native |
| `clojurescript` | ClojureScript → **JavaScript** → V8 — Clojure's fourth runtime, after the JVM and a GraalVM native image |
| `elixir` | Elixir → BEAM bytecode |
| `erlang` (erlc) | erlc → `.beam` once, then the BEAM runs it |
| `hashlink` | Haxe → `.hl` bytecode → the HashLink VM |
| `dart` (jit) | Dart → kernel bytecode; (aot) ahead-of-time native |
| `php` | Zend compiles to opcodes; the `+ jit` row then JITs them |
| `lua`, `lua-wasm` | PUC Lua compiles to its own bytecode, then a register VM runs it |
| `luau` | Luau → bytecode, then its VM; the `lute` row runs the same files on the Lute runtime |
| `ruby` | CRuby → ISeq bytecode; the `+ yjit` row JITs it |
| `python` (cpython, pypy, graalpy) | CPython → bytecode; PyPy JITs; GraalPy runs on GraalVM |
| `quickjs` | QuickJS compiles to bytecode, then its own VM |
| `r` | R's byte-code compiler, on by default |
| `racket` | Racket compiles the module on every run |
| `scheme` | Chez compiles the script on every run |
| `pharo` | a prebuilt image, compiled ahead of time by someone else |
| `actionscript` | `amxmlc` compiles AS3 to SWF bytecode, then `adt` packages it into a standalone exe with the captive AIR runtime beside it |

### 4. Source to WebAssembly, then a runtime

The compiler targets wasm32 and the module is executed by `wasmtime`, which is a JIT for wasm.
The measured number therefore includes the runtime's own translation of the module.

| Rows | Stages |
|---|---|
| `c-wasm`, `cpp-wasm` | wasi-sdk clang → wasm object → wasm-ld |
| `rust-wasm` | rustc with the `wasm32-wasip1` target |

| `zig-wasm` | `zig build-exe -target wasm32-wasi` |
| `assemblyscript` | `asc` → wasm directly |
| `wasm` | hand-written WAT; `wasmtime` parses the text form itself |
| `lua-wasm` | the interpreter is itself compiled to wasm, and the source file is data |

### 5. Assembled directly

No compiler and no C runtime: the source is assembly, and an assembler turns it into an object
file that the linker turns into a PE executable. The only library either row imports is
`kernel32.dll`, and output goes through `WriteFile` on a handle `GetStdHandle` returns.

| Rows | Stages |
|---|---|
| `assembly` (nasm) | `nasm -f win64` → object → `link.exe` |
| `masm` | `ml64.exe /c` → object → `link.exe` |
| `fasm` | flat assembler emits the PE itself, with no separate link step |

### 6. No compilation step at all

The interpreter reads the source and executes it. There is no artifact, so the whole cost is at
run time and the measured cell is the entire program. Several of these still build an internal
bytecode representation on the way — that is noted in the shape-3 table where it applies — but
nothing is written to disk and nothing is reused between runs.

| Rows | Notes |
|---|---|
| `perl`, `tcl` | parse and execute on each run |
| `swipl` | SWI-Prolog compiles to its own clause representation in memory |
| `gforth` | gforth interprets the file; the accumulator lives on the data stack |
| `gdscript` | Godot parses and runs the script |

### 7. Compiled at run time

These rows do compile — to machine code — but they do it while the program is running, so the
compile is inside the measured cell by construction. Julia is the clearest case, and it is also
the reason the matrix has a second Julia row: `--compile=min -O0` turns this off, and the pair
exists to show what it costs.

| Rows | Stages |
|---|---|
| `julia` | parse → typed IR → LLVM IR → machine code, per method, on first call |
| `lua` (luajit) | trace compilation |
| `python` (pypy) | trace compilation |
| `php` (`+ jit`) | opcode JIT |
| `ruby` (`+ yjit`) | method JIT |
| `javascript` (bun, deno, spidermonkey, quickjs) | tiered JIT, except QuickJS, which is bytecode only |
| `csharp` (coreclr, mono llvm), `java` (openjdk, openjdk c1, openjdk c2, openj9, graalvm jit), `fsharp`, `vbnet`, `scala`, `clojure` | the VM JITs on first execution |

### What this means for reading a row

Three consequences are worth stating, because they are easy to get wrong:

- **A compiled row and an interpreted row are not the same measurement.** The first excludes the
  compile entirely; the second includes it, or includes the interpreter's per-statement
  dispatch. Comparing them across shapes says something about the toolchain, not about the
  language.
- **A JIT row's number depends on how long it ran.** A trace or method that compiles on first
  call needs enough iterations to pay for itself, which is why the loop counts are in the
  hundreds of millions and why a task's count is never lowered.
- **A row with two toolchains is usually a pipeline comparison.** `julia` against
  `julia --compile=min`, `ocamlopt` against `ocamlc`,
  and the native/wasm pairs all exist to hold the language
  fixed and move one stage of the pipeline.

## Toolchains

### Compiled to native code — nothing needed at run time

The output is a native executable in every row below, and for most of them that executable needs
nothing but the operating system. Five rows are exceptions and say so in their own entry: Vala's
binary imports `libglib-2.0-0.dll` whenever the code touches GLib, COBOL's imports `libcob-4.dll`,
Cython's imports `python3xx.dll` because CPython on Windows ships no static library to link
against, Objective-C's imports `libobjc-4.6.dll`, `gnustep-base-1_31.dll` and
`libwinpthread-1.dll` from MSYS2, and
Standard ML's needs `PolyLib.dll` beside it — in that last case the exported `.obj`
is a whole heap image and the DLL is the runtime that loads it, so the pair has to travel
together.

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| C | gcc | 9 (C11 + pthreads) | distro package | `gcc -O2 -pthread -o prog <task>.c` |
| C | clang | 10 | releases.llvm.org | `clang -O2 -pthread -o prog <task>.c` |
| C | msvc | VS 2019 | Visual Studio Build Tools, C++ workload | `cl /O2 /Fe:prog <task>.c`. Works without admin: `--layout` the bootstrapper, then reassemble the packages (see below). |
| C | icx (oneAPI) | DPC++ 7.2.0 (clang 24, nightly) | github.com/intel/llvm nightly `sycl_windows.tar.gz` (568 MB) extracted into `tools/icx/` — no installer and no admin. Intel's downstream LLVM fork; `icx` is its `clang.exe`. It targets `x86_64-pc-windows-msvc`, so it needs the MSVC environment (`tools/msvc_env.py`) for headers and libraries, and it links with `link.exe`. | `clang.exe -O2 -o prog.exe <task>.c`, run with the MSVC `PATH`/`INCLUDE`/`LIB` set. A different build and optimisation pipeline from upstream clang, which is the point of the row. |
| C | tcc | 0.9.27 | bellard.org/tcc | `tcc -o prog <task>.c` |
| C | zig cc | 0.16.0 | ziglang.org/download, the same tree the `zig` row installs | `zig cc -O2 -pthread -mcpu=x86_64_v2 -o prog.exe <task>.c`. **clang's front end on Zig's toolchain and libc**: the same C is parsed by clang and linked against Zig's own libc and compiler-rt, with no MinGW or MSVC installation behind it at all. **`-mcpu` is pinned, not decoration.** Zig's default target CPU is `native`, i.e. the *build* machine's model, so a binary built on an AVX2 host carries AVX2 instructions and dies with exit code `0xC000001D` (illegal instruction) on any x86-64 CPU without them — with no output on either stream. The 2026-10-09 commit of this row was built that way and six of its fifteen cells failed on a host without AVX2; `x86_64_v2` (SSE4.2 + POPCNT) is the floor every x86-64 CPU since 2009 has. Verified 15/15 both ways. On task 01 the four C toolchains measure gcc 80.7 ms, clang 89.7 ms, zig cc 92.2 ms and tcc 500.7 ms, so Zig's toolchain lands within 15% of the row's two compilers while needing neither installed. |
| C | compcert | 3.18 (its `VERSION` file still reads 3.17, so `ccomp -version` prints 3.17 — upstream did not bump it for this tag) | **The only Windows target CompCert has is `x86_64-cygwin`** (`x86_64-linux`, `x86_64-bsd` and `x86_64-macos` are the others), so it needs a portable Cygwin plus a Coq/OCaml toolchain to build: `tools/compcert_build/build_prereqs.sh` installs findlib 1.9.6, zarith 1.14, menhir 20250903 and **Coq 8.20.1** into `tools/cygwin`, then `./configure -prefix ... x86_64-cygwin && make -j all && make install` gives `tools/compcert/bin/ccomp.exe`. Cygwin's own `ocaml-dune` is 2.5.1 (too old for Coq 8.20's `(lang dune 3.6)`) and its `ocaml-findlib` 1.8.1 has stale `.cmi` files, so dune 3.18.1 is unpacked by hand and findlib is built from source. **~2.5 GB installed**, of which `tools/cygwin` (2.1 GB) is needed at *run* time. | `ccomp.exe -O2 -o prog.exe <task>.c` with `tools/cygwin/bin` on `PATH` (that is the preprocessor, assembler and linker CompCert drives). **`-O2` is CompCert's normal level and matches the row's other toolchains.** The sources take the **POSIX** timer branch: Cygwin's gcc defines `__CYGWIN__` but not `_WIN32`, and `_MSC_VER` is undefined, so `clock_gettime(CLOCK_MONOTONIC)` is used and resolves in Cygwin's libc; the same branch also supplies `pthread_create` for task 11 and `fsync` for task 15. **Linking the objects with MinGW instead does not work** — `undefined reference to '__getreent'` on all fifteen, because CompCert preprocesses against Cygwin's headers so the objects carry Cygwin-libc references (`struct _reent` accessors behind Cygwin's stdio macros). ABI compatibility is not libc compatibility: the generated code is Win64-ABI, but there is no native-Windows CompCert target, so **the row's programs import `cygwin1.dll`** — see RUN.md. **No source change was needed**: all fifteen are inside the CompCert C subset at `-O2`, including `__attribute__((noinline))` in task 03, which configure neutralises with `-D__attribute__(x)=`. 15/15 verified. |
| C++ | g++ | 9 | distro package | `g++ -O2 -pthread -o prog <task>.cpp` |
| C++ | clang++ | 10 | releases.llvm.org | `clang++ -O2 -pthread -o prog <task>.cpp` |
| C++ | msvc | VS 2019 | as above | `cl /O2 /EHsc /Fe:prog <task>.cpp` |
| C++ | zig c++ | 0.16.0 | the same tree the `zig` row installs | `zig c++ -O2 -o prog.exe <task>.cpp`, built by `exec/cpp/build_zigcpp.bat`. **The C++ counterpart of the `c` row's `zig cc`**: clang++'s front end on Zig's toolchain and libc, so the two rows are a matched pair and the `zig cc / zig c++` backend carries one front end from each. 15/15 verified. |
| Rust | rustc | 1.70 (1.63 for `std::array::from_fn`) | rustup.rs | `rustc -O -o prog <task>.rs` |
| Rust | rustc (cranelift) | nightly 1.101.0 (2026-10-08) | rustup.rs — `rustup toolchain install nightly` then `rustup component add rustc-codegen-cranelift --toolchain nightly` | `rustc +nightly -Zcodegen-backend=cranelift -O -o prog.exe <task>.rs`, run with the MSVC environment (`tools/msvc_env.py` sets `PATH`/`INCLUDE`/`LIB`) because the nightly host is `x86_64-pc-windows-msvc` and links with `link.exe`. Same fifteen sources as the row above: rustc's front end and MIR are identical, and the code generator behind MIR is the variable. No `+crt-static` and no target override are needed. |
| Zig | zig | 0.16 | ziglang.org/download | `zig build-exe -O ReleaseFast -mcpu=x86_64_v2 <task>.zig -femit-bin=prog`. `-mcpu` is pinned and is the whole reason the row runs anywhere but the build machine: Zig's default target CPU model is the *build* host's, so the binaries committed on 2026-10-09 carry AVX2 and die with `0xC000001D` (illegal instruction, no output on either stream) on an x86-64 CPU that lacks it. `x86_64_v2` is SSE4.2 + POPCNT. Task 01 measures 476 ms at `-mcpu=default` and 426 ms at `x86_64_v2` on the development machine, so the pin costs a few percent of the self-hosted row's numbers and buys a binary that runs at all. |
| LLVM IR | llc | 23.1.2 | releases.llvm.org — the same `tools/llvm/` tree the `c` row's clang, the `cpp` row's clang++ and the `fortran` row's flang come from; nothing new to install | `llc -O2 -filetype=obj -o prog.obj <task>.ll`, then `clang -O2 -fuse-ld=lld prog.obj -o prog.exe`. **The `.ll` text is the source and the compiler input; there is no front end in front of it**, so this row is the native counterpart of the `wasm` row, whose front end is `hand-written WAT`. `llc` lowers the IR to a COFF object and clang drives `lld-link` against the MSVC libraries, so only `LIB` from `tools/msvc_env.py` is needed — no `INCLUDE`, because no headers are involved. **The fifteen files are hand-written IR, not output from clang**: no file carries a `clang version` module flag, and the row's standing choice, repeated in every file's header, is the C runtime for formatted output, allocation and file I/O, with `kernel32` reached directly only for the `QueryPerformanceCounter` clock and (task 11) for `CreateThread`. Verified 15/15. |
| Zig | zig (self-hosted x86-64) | 0.16 | the same tree | `zig build-exe -O ReleaseFast -fno-llvm -mcpu=x86_64_v2 -femit-bin=prog.exe <task>.zig`. **`-fno-llvm` removes LLVM from the pipeline entirely** and uses Zig's own x86-64 code generator, which is the compiler's default for debug builds but still experimental at `-O ReleaseFast`. The same fifteen sources on the same front end, so the pair is a clean code-generator comparison: task 01 measures 511.5 ms self-hosted against 104.2 ms through LLVM, and the self-hosted backend is 15/15. `-mcpu` is pinned for the reason given under `zig cc` above — Zig's default CPU model is the build machine's, and a binary built on an AVX2 host dies with `0xC000001D` on one without; the 2026-10-09 commit of this half of the row was built that way and all fifteen cells failed on a host without AVX2. |
| Go | gc | 1.20 | go.dev/dl | `go build -o prog <task>.go` |
| Go | tinygo | 0.42 | tinygo.org, `tinygo0.42.0.windows-amd64.zip` (178 MB) extracted into `tools/tinygo/` — no installer, no admin | `tinygo build -o prog.exe <task>.go`, run from `sources/tinygo/`, which holds all fifteen tasks. TinyGo bundles its own LLVM 22.1 and emits a standalone executable, but it still **shells out to `go`** for `go list` and `go env`, so the Go SDK has to be on `PATH` or every build dies with `could not find 'go' command`; `exec/go/build_all.bat` puts `tools/go/bin` (falling back to `C:\Program Files\Go\bin`) in front for both halves of the row. The default target is the host (`windows/amd64` here); there is no `windows` target name in `tinygo targets` to pass explicitly. Fourteen of the fifteen files are byte-identical to `sources/go/`'s and `exec/go/verify.py` asserts that; task 15 differs because TinyGo's Windows target implements no fsync — `os.File.Sync` is a stub returning "operation not implemented" — so that file flushes by closing instead, the same deviation the J, SWI-Prolog, Octave, R, Chez, Haxe, Poly/ML, AutoHotkey and Dyalog rows record. Verified 15/15. |
| D | dmd | 2.100 | dlang.org/install.sh | `dmd -O -release -of=prog _<task>.d` |
| D | ldc2 | 1.30 | dlang.org/install.sh | `ldc2 -O3 -release -of=prog _<task>.d` |
| Swift | swiftc | 5.8 (6.4.0 measured) | swift.org/install; the Windows distribution is a WiX burn bundle, so `tools/get_swift.py` decompiles it and administrative-extracts the MSIs (see below) — no admin | `swiftc -O -sdk <swift>/Platforms/6.4.0/Windows.platform/Developer/SDKs/Windows.sdk -windows-sdk-root <winsdk> -windows-sdk-version 10.0.26100.0 -o prog.exe <task>.swift`, with the MSVC environment on `PATH`/`INCLUDE`/`LIB` for the link step. Two Windows SDK flags are load bearing: without `-windows-sdk-root`/`-windows-sdk-version` the clang importer never injects `ucrt.modulemap` and `winsdk_*.modulemap`, and every `import Foundation` dies with `missing required modules: '_complex', 'ucrt'`. The root has to be a complete header tree — the reassembled MSVC layout's `um` set is missing `CommCtrl.h`, `ShlObj.h` and `DbgHelp.h` — so this row points them at the `Microsoft.Windows.SDK.CPP 10.0.26100.1742` headers from nuget.org, with `Lib` junctioned to the MSVC tree's libraries. |
| Fortran | gfortran | 9 | distro package | `gfortran -O3 -o prog <task>.f90`. Task 03 also compiles `03_func_sum_add_one.f90`; task 11 needs `-fopenmp`. |
| Fortran | flang | LLVM 17 | MSYS2 `ucrt64` on Windows, distro or LLVM release elsewhere | `flang -O3 -o prog <task>.f90` (older LLVM: `flang-new`). Same two extras as gfortran: the second file for task 03 and `-fopenmp` for task 11. The official LLVM Windows tarball has no `flang.exe`; MSYS2's `mingw-w64-ucrt-x86_64-flang` plus `-flang-rt` is the working Windows route, and it pulls in the runtime libraries as well. Task 11 additionally needs `mingw-w64-ucrt-x86_64-llvm-openmp`: without it the link stops with `cannot find -lomp`, which is the only task-11 gap — flang installs the rest of its runtime with the compiler package. |
| Fortran | ifx | 2026.1.1 | Intel's conda channel (`software.repos.intel.com/python/conda/win-64/`), not the oneAPI `.exe` installer — the installer wants admin and the same compiler ships as ordinary conda packages. `temp/fetch_ifx.py` downloads and unpacks `ifx_win-64`, `ifx_impl_win-64`, `compiler_shared`, `intel-cmplr-lib-rt`, `intel-cmplr-lic-rt`, `intel-fortran-rt`, `intel-openmp` and `intel-cmplr-lib-ur` into `tools/ifx/` (**~1.0 GB installed**, and a `.conda` is a zip of zstd tars, so it needs `zstd.exe` and `tar` — no installer runs, no admin, no licence prompt). | `ifx -O3 [-Qopenmp] -o prog.exe <task>.f90`, from the cell, with three things set: `PATH` gets `tools/ifx/Library/bin`, `INCLUDE` gets `tools/ifx/opt/compiler/include/intel64` (without it every `use iso_fortran_env` stops with `error #7002: Error in opening the compiled module file`), `LIB` gets `tools/ifx/Library/lib`, and **the MSVC environment on top** — ifx is clang-based and links with `link.exe`, so it stops with `error #10036: unable to run 'link.exe'` otherwise, exactly like the `clang` and `icx` cells of the `c` row. Two per-task extras, both learned the hard way: task 11 takes `-Qopenmp` and its link needs `libiomp5md.lib`, which only `intel-openmp` ships (`LNK1104: cannot open file 'libiomp5md.lib'`); task 06 takes `-heap-arrays`, or ifx puts the 100 MB `repeat` result on the stack and the program dies with `severe (170): Program Exception - stack overflow` — measured 126 ms with the flag, stack overflow without. Verified 15/15. Same fifteen sources as the row's other two compilers, so the row is now a three-way code-generator comparison: gfortran (GCC), flang (upstream LLVM) and ifx (Intel's LLVM fork). **This is the Intel Fortran compiler — `ifort` is not a second one.** Intel retired the classic `ifort` and `ifx` replaced it in oneAPI 2025; `ifx` is itself LLVM-based, so "Intel Fortran on LLVM" is this row and there is nothing else to add. `tools/ifx/` ships no `ifort.exe`, and no current oneAPI component does. |
| Fortran | ifx | 2026.1.1 | Intel's conda channel (`software.repos.intel.com/python/conda/win-64/`), not the oneAPI `.exe` installer — the installer wants admin and the same compiler ships as ordinary conda packages. `temp/fetch_ifx.py` downloads and unpacks `ifx_win-64`, `ifx_impl_win-64`, `compiler_shared`, `intel-cmplr-lib-rt`, `intel-cmplr-lic-rt`, `intel-fortran-rt`, `intel-openmp` and `intel-cmplr-lib-ur` into `tools/ifx/` (**~1.0 GB installed**, and a `.conda` is a zip of zstd tars, so it needs `zstd.exe` and `tar` — no installer runs, no admin, no licence prompt). | `ifx -O3 [-Qopenmp] -o prog.exe <task>.f90`, from the cell, with three things set: `PATH` gets `tools/ifx/Library/bin`, `INCLUDE` gets `tools/ifx/opt/compiler/include/intel64` (without it every `use iso_fortran_env` stops with `error #7002: Error in opening the compiled module file`), `LIB` gets `tools/ifx/Library/lib`, and **the MSVC environment on top** — ifx is clang-based and links with `link.exe`, so it stops with `error #10036: unable to run 'link.exe'` otherwise, exactly like the `clang` and `icx` cells of the `c` row. Two per-task extras, both learned the hard way: task 11 takes `-Qopenmp` and its link needs `libiomp5md.lib`, which only `intel-openmp` ships (`LNK1104: cannot open file 'libiomp5md.lib'`); task 06 takes `-heap-arrays`, or ifx puts the 100 MB `repeat` result on the stack and the program dies with `severe (170): Program Exception - stack overflow` — measured 126 ms with the flag, stack overflow without. Verified 15/15. Same fifteen sources as the row's other two compilers, so the row is now a three-way code-generator comparison: gfortran (GCC), flang (upstream LLVM) and ifx (Intel's LLVM fork). **This is the Intel Fortran compiler — `ifort` is not a second one.** Intel retired the classic `ifort` and `ifx` replaced it in oneAPI 2025; `ifx` is itself LLVM-based, so "Intel Fortran on LLVM" is this row and there is nothing else to add. `tools/ifx/` ships no `ifort.exe`, and no current oneAPI component does. |
| Fortran | lfortran | 0.67.0 | MSYS2 `ucrt64` (`mingw-w64-ucrt-x86_64-lfortran`) on Windows; conda-forge elsewhere. No installer and no admin. | `lfortran --implicit-interface -O3 -c -o task.o <task>.f90`, then `gcc -o prog.exe task.o tools/lfortran-shim/lfclock_shim.o -llfortran_runtime -lm`, built by `exec/fortran/build_lfortran.bat`. **Three deviations, all recorded in the row's own notes.** (1) `--implicit-interface` is required: LFortran refuses `integer(kind=8), external :: add_one` (tasks 03 and 09) with *"function interface must be specified explicitly"*. (2) **LFortran's `SYSTEM_CLOCK` is a stub** — its runtime's `_lfortran_i64sys_clock_count` and `_lfortran_i64sys_clock_count_rate` both return 0, so every task's `TIME_MS` line divides by the zero rate and the process dies with `0xC0000094` (`EXCEPTION_INT_DIVIDE_BY_ZERO`) before printing anything. `tools/lfortran-shim/lfclock_shim.c` defines both symbols on top of `QueryPerformanceCounter` and is linked **before** the runtime, so the shared sources need no change and gfortran, flang and ifx are untouched; `GetTickCount64` was tried first and rejected because its ~15.6 ms granularity made task 04 read 0.00 ms. (3) **Both file tasks need `tools/lfortran-shim/patch_runtime.py`.** LFortran's `_lfortran_open` picks the fopen mode from the OPEN statement's `status` alone — `r+` for `old`/`unknown`, `w+` for `new`/`replace`/`scratch` — and never passes the `b` flag, so on Windows **every unit file the runtime opens is a text stream**; only its own implicit-unit path passes it (`is_unformatted ? "w+b" : "w+"`). Two consequences, both measured with this row's own executables against the 0.67.0 runtime: task 14's first 1 MiB read stops at the `0x1A` byte in `data.bin` (byte 26 of the 0..255 cycle), so `ios` is `-1` and the program answers **0** instead of `1937768448`; and task 15's `out.bin` comes out **52633600 bytes instead of 52428800** — 204800 extra, exactly the LF count of the fixture, each LF doubled to CRLF. The patch is **two bytes**: each mode string is followed by a padding NUL and the next literal starts two bytes later, so the NUL after `r+` and the one after `w+` become `b` and the strings grow to `r+b` and `w+b` in place — nothing moves and the DLL keeps its length. With it, task 14 answers `1937768448` and task 15 leaves a 52428800-byte `out.bin`; `python tools/lfortran-shim/patch_runtime.py --check` reports which state a DLL is in, and the pristine copy is kept as `<dll>.orig`. **The recorded task-15 cell predates the patch** and carries its warning (`out.bin is 52633600 bytes, not 52428800`), and task 14 has no measurement yet; re-running this row on a patched install replaces both. `cpu_time` works, `date_and_time` and `time` are not implemented. Task 11's `!$omp` directives are comments to LFortran, so that cell is correct but serial. |
| Ada | gnat | 12 | alire.ada.dev | `gnatmake -O3 t<task>.adb` |
| Ada | gnat llvm | LLVM 22.1.8 + GCC 16.2 (both MSYS2 UCRT64) | **built from source**, `github.com/AdaCore/gnat-llvm` at master, driven by `tools/gnat-llvm-src/gnat-llvm/llvm-interface/build.bat`: clone gnat-llvm, put the gcc Ada front end under `llvm-interface/gnat_src` (`git clone git://gcc.gnu.org/git/gcc.git llvm-interface/gcc`, then `mv llvm-interface/gcc/gcc/ada llvm-interface/gnat_src` on Windows), clone `AdaCore/llvm-bindings` **branch `llvm-21`** beside it, then `make`. **The toolchain has to be MSYS2 UCRT64's own**: its LLVM 22.1.8 is built with GCC 16.2 against the UCRT, so the Ada compiler is that same GCC's `gcc-ada` package (`gnatmake 16.2.0`) — the Alire GNAT 16.1.0 carries a different MinGW CRT and cannot link a single object once `-L<ucrt64>/lib` is on the line (`undefined reference to _gnu_exception_handler`). Three source adjustments are needed and are in `build.bat`/the tree: the sources are checked out **LF** (GNAT's implementation mode reports every CR as an "incorrect line terminator" and promotes it to an error), `gnatlink.adb` needs `with System.CRTL;` and `use type System.CRTL.long;` for a 16.x bootstrap compiler, and `raise-gcc.c` declares `_GCC_specific_handler` because the runtime is compiled with Clang, whose `<unwind.h>` omits it. `llvm-gnatmake -O3 t<task>.adb` with `tools/gnat-llvm/llvm-interface/bin` and the UCRT64 `bin` on `PATH` (it drives `llvm-gcc`, `llvm-gnatbind` and `llvm-gnatlink` by bare name, and `llvm-gcc` links with the `clang` it finds), built by `exec/ada/build_all.bat llvm` into `exec/ada/llvm/<task>/t<task>.exe`. The same fifteen sources as `gnat`, so the pair is one front end over two code generators — the relation `d`'s `dmd`/`ldc2` and `nim`'s three toolchains already have. **Not installed on the machine these numbers came from**: no prebuilt GNAT LLVM exists on any platform, so its fifteen cells are registered and unmeasured until the tree above is built, and `exec/ada/verify.py` reports them as SKIP, not FAIL, until then. |
| Pascal | fpc | 3.2.2 | freepascal.org | `fpc -O3 -oprogram <task>.pas`. On Windows x64 there is no native compiler: install the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, then build with `-Px86_64`. |
| Nim | nim (cpp) | 2.0 (2.2.12 measured) | the same tree | `nim cpp -d:release -o:prog.exe t<task>.nim`, with the same `_<task>.nim` -> `t<task>.nim` copy the C row needs. Nim's C++ backend emits C++ instead of C, so the code generator behind it is g++ rather than gcc: task 01 measures 102.9 ms against 76.6 ms for the C backend. Verified 15/15. |
| Nim | nim (clang) | 2.0 (2.2.12 measured) | the same tree | `nim c -d:release --cc:clang -o:prog.exe t<task>.nim`, built by `exec/nim/build_clang.bat` — the LLVM counterpart of the default C back end, so `Nim` now has three front ends over two backends. **`--cc:clang` needs the MSVC environment**: `tools/llvm/bin/clang.exe` is LLVM 23 with no headers of its own, so `INCLUDE`/`LIB`/`PATH` come from `tools/msvc_env.py` exactly as the `c` row's clang toolchain does — without it the build stops at `fatal error: 'windows.h' file not found`. 15/15 verified. |
| Nim | nim | 2.0 (2.2.12 measured) | nim-lang.org, `nim-<v>_x64.zip` extracted — no installer and no admin | `nim c -d:release -o:prog <task>.nim`. **The source file name matters**: Nim rejects a module name that is not a valid identifier, and the sources are `_01_branches.nim` … `_15_file_write.nim`, so each is copied to `t<task>.nim` (no leading underscore) before the build — `Error: invalid module name: '_01_branches'` otherwise. `-d:release` is the optimisation; without it Nim emits a debug build with the runtime checks on. The C backend needs `gcc` on `PATH`. |
| Odin | odin | dev-2026-09-nightly:a2fb372 | odin-lang.org | `odin build <task>.odin -file -o:speed -out:prog.exe`. Two additions to the bare `odin build` form are required by this compiler: **`-file`**, without which it stops with *takes a package/directory as its first argument*, and an explicit **`.exe` extension on `-out`**, without which it stops with *Output path ... must have an appropriate extension*. Odin also links through MSVC, so it needs the hand-extracted tree's environment (`tools/msvc_env.py`) plus `WindowsSdkDir`, `WindowsSDKVersion=10.0.26100.0` and `VCToolsInstallDir` set, or it cannot find the SDK. |
| Kotlin | kotlin/native | 1.9 (2.4.20 measured) | kotlinlang.org, `kotlin-native-prebuilt-windows-x86_64-<v>.zip` (209 MB) extracted — no installer and no admin. The first build downloads its LLVM and libffi dependencies (about 1.4 GB) into `%USERPROFILE%\.konan`, so the first cell takes minutes | `kotlinc-native -opt -o prog <task>.kt`, run from `sources/kotlin-native/`, which holds all fifteen tasks. `-opt` is the optimiser. Tasks 11, 14 and 15 differ from the jvm row's files: Native has no `java.lang` and no `java.io`, so task 11 uses the stdlib `Worker` and the two file tasks use `platform.posix` (`fopen`/`fread`/`fwrite`) through `kotlinx.cinterop`. The other twelve are byte-identical to `sources/kotlin/`'s. The launcher wants a JDK via `JAVA_HOME`; see the caveat below. |
| Java | graalvm native-image | 21 | graalvm.org | `native-image -O2 _<task>`, run from `sources/java-graalvm-native/`, which holds the same fifteen files as the `openjdk` row. Emits a standalone native executable, so it belongs here and not with the bytecode rows. **Task 03 adds `-H:NeverInline=_03_func_sum.addOne`**: the JVM has no source-level no-inline attribute, and with a constant bound and a constant start native-image constant-folds the whole hundred-million-iteration loop at build time, so the cell measured nothing (TIME_MS 0.0001, against 31 ms for the same source built `-O0`). `-H:NeverInline` is native-image's own no-inline lever and the counterpart of the C row's `__attribute__((noinline))`; with it the cell measures a real call, 75 ms. |
| C# | nativeaot | .NET 8 | dotnet.microsoft.com | `dotnet publish -c Release -p:PublishAot=true`. Emits a native executable. |
| Dart | aot | 3.3 | dart.dev | `dart compile exe -o prog <task>.dart`. Emits a native executable. |
| Python | nuitka | 4.0 | nuitka.net | `nuitka --standalone <task>.py`. Compiles to C and then to a binary. |
| Python | cython | 3.3 (3.3.0 measured) | pypi.org/project/Cython | Two steps: `cython --embed -3 --module-name _<task> -o _<task>.c <task>.py`, then `gcc -O2 -DMS_WIN64 -municode -I <python>/include -o prog.exe _<task>.c -L <python>/libs -lpython3xx`. `--embed` makes Cython emit a `main` that starts the interpreter and runs the module, so the source file is used **unchanged** — the same fifteen files as the `cpython` row, held in `sources/python-cython/`. Three flags are load-bearing on Windows. `--module-name` is required because every file's name starts with a digit, which is not a legal Python module name (`'01_branches' is not a valid module name`). `-DMS_WIN64` is required because CPython's hand-maintained `pyconfig.h` only defines `MS_WIN64` inside an `#ifdef _MSC_VER` block, so under MinGW `SIZEOF_VOID_P` is 4 and Cython's own `sizeof(void*)` assertion fails to compile. `-municode` is required because `--embed` generates a `wmain`, not a `main`. Cython **3.3 or newer** is the floor, because tasks 02 and 11 use `match` and PEP-634 support only landed there. |
| Assembly | nasm | 2.15 | nasm.us | `nasm -f win64 <task>.asm -o prog.obj`, then `link /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib`, run from `sources/assembly/`. A Windows x64 console program with no C runtime: the only imports are from `kernel32.dll`. Task 11 issues `CreateThread` and `WaitForSingleObject` itself, since there is no thread library to call. |
| Assembly | masm | VS 2019 (`ml64.exe`) | the MSVC tree the `msvc` row already installs — nothing extra | `ml64.exe /nologo /c /Fo prog.obj <task>.asm`, then `link /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib`, run from `sources/masm/`. Same shape as the `nasm` row — freestanding, `kernel32.dll` only — in MASM syntax instead of NASM's, so the two rows differ in assembler and syntax and in nothing else. Task 11 issues `CreateThread` and `WaitForSingleObject` itself. One trap: `ml64.exe` reads an environment variable named `ML`, and `link.exe` reads `LINK`, as default command-line options — so naming a script's tool-path variables `ML`/`LINK` makes ml64 try to assemble its own executable and stop with `A2044`. Name them anything else (`ML64EXE`/`LINKEXE`). |
| Assembly | fasm | 1.73.35 | flatassembler.net — `fasmw17335.zip` (1 MB). **The `fasmw` archive is the Windows one**: the plain `fasm17335.zip` download is the DOS build, whose `FASM.EXE` is a raw MZ image with no PE header, and Windows refuses it with "not compatible with the version of Windows". Extract `fasmw` and use its `FASM.EXE`, not the `FASMW.EXE` beside it — that one is the GUI IDE and blocks waiting for a window. | `fasm <task>.asm <out>.exe`, **run with `tools/fasm/INCLUDE` as the working directory**, because the standard includes (`win64a.inc`) are resolved relative to the current directory and FASM has no `-I` option. Third assembler syntax beside `nasm` and `masm`, and the same freestanding shape: `format PE64 console` + `include 'win64a.inc'` + an explicit `.idata` import list, `kernel32.dll` only. Two things are load-bearing. `format` must come **before** the include, or the linker emits a GUI-subsystem binary (subsystem 2) that prints nothing; and the `win64ax.inc` variant's `invoke` macro fails here with `undefined symbol`, so the imports are called directly — `call [WriteFile]`, with handles loaded by `mov ecx, -12` + `call [GetStdHandle]`. Task 11 issues `CreateThread` and `WaitForSingleObject` itself. |
| Crystal | crystal | 1.21 | crystal-lang.org | `crystal build --release -o prog <task>.cr`. Needs the MSVC environment: the compiler shells out to `cl.exe`, which drives `link.exe`. Integer literals default to `Int32`, so task 02 must be written with the `Int64` form or it raises `OverflowError`. |
| Objective-C | clang | 22 | MSYS2 `ucrt64` | `clang -fobjc-runtime=gnustep-2.2 -O2 -o prog <task>.m -lobjc -lgnustep-base`. The runtime flag is required; without it the link fails on `objc_autoreleasePoolPush` and `__objc_load`. `gcc-objc` 16.2.0 is an alternative front end, but the clang path is the one measured. **Two defects in this UCRT64 package set have to be worked around.** (1) GNU ld (binutils 2.47) cannot link tasks 06, 10, 11, 14 and 15: clang emits every typed selector as a COMDAT section all named `.objcrt$SEL$m`, bfd collapses them, and the link stops with `undefined reference to .objc_selector_<name>_<types>`; adding **`-fuse-ld=lld`** (ld.lld ships in the same clang package) fixes all five. (2) `gnustep-base-1_31.dll` fails to load with `STATUS_ENTRYPOINT_NOT_FOUND` (0xC0000139) and no output, because the tree ships `libstdc++-6.dll` from libstdc++-16.2.0-4 while gnustep-base was built against gcc-libs-16.1.0-3 and imports five `std::__format` symbols that 16.2.0-4 does not export. The fix is to vendor `libstdc++-6.dll` from gcc-libs-16.1.0-3 beside the executable, where the Windows loader finds it before `ucrt64\bin`. Only the tasks that actually pull in Foundation are affected, which masks the failure. |
| Modula-2 | adw | 1.6.879 | modula2.org/adwm2, `ADWM2Setup.exe` (18 MB) — an **Inno Setup** archive, unpacked with `innoextract -e -d tools/adwm2/` rather than installed: no admin, no registry. The tree's `app/` is the install root, with the two ASCII-compiler binaries and the runtime libraries in `ASCII/` | Two steps, not one. `m2amd64.exe /sym:.;<ADW>\ASCII\winamd64sym <task>.mod` compiles, then `sblink.exe /machine:amd64 /out:prog.exe <module>.obj <ADW>\ASCII\rtl-win-amd64.lib <ADW>\ASCII\win64api.lib` links. Four things are load-bearing. **The `.` in `/sym:` is required**: the compiler does not search the working directory for symbol files, so a module whose definition module was compiled in the same directory fails with `Could not open SYM file. 2 Func`. `/machine:amd64` is required because the default linker machine type rejects the 64-bit object with `Incorrect Machine Type`. The compiler writes the `.obj` **beside the source file**, named after the `MODULE` rather than the file — and **truncated to the length of the source file's stem**, so `10_pi.mod`'s five characters turn `MODULE Task10` into `Task1.obj`, which is why that file's module is named `T10`. Copy the source into a scratch directory first or the repo fills up with objects. **There is no `<module>.lib` to link**: a program module produces only an `.obj`; the runtime and API libraries are the whole link line. Task 03 compiles `Func.def` to `Func.sym`, then `Func.mod` to `Func.obj`, then itself, and links `Func.obj` as well, because its `AddOne` has to live in a separate module. |
| COBOL | gnucobol | 3.2 | MSYS2 `ucrt64`, or gnucobol.sourceforge.io | `cobc -x -O2 -o prog <task>.cob`. `PIC 9(18) COMP-5` is the exact 64-bit picture, and COMP-5 keeps the full binary range regardless of the PICTURE, so limb arithmetic fits in one COMPUTE. Outside an MSYS2 shell, `cobc` needs `COB_CONFIG_DIR` and `COB_COPY_DIR` set to the package's `share/gnucobol/{config,copy}` or it stops with `configuration error: /ucrt64/share/gnucobol/config/default.conf`. Task 11 needs `CBL_GC_FORK`, which GnuCOBOL documents as unavailable on Windows outside Cygwin: it returns -1 there and the program falls back to four in-process quarters, so the answer is right but the row is single-core on Windows and four-way on Linux. The compiled exe also needs the MSYS2 `ucrt64/bin` on `PATH` to find its runtime DLLs, or it exits 0 with no output. Two fixed-format lines — the `COMPUTE CS0`/`CS1` clock conversions — ran past column 72, which fixed-format silently truncates; they are wrapped. Task 10 had a third defect worth recording: its six `CALL 'BIGMUL' USING ... <literal>` sites passed the multiplier as a numeric literal, which GnuCOBOL materialises as a DISPLAY-format temporary, while BIGMUL's `LINKAGE` declares it `COMP-5` — so the callee read the literal's bytes as a binary value (`5 * 4` came back as `24435220`). The spigot state diverged, grew without bound and the program ran for 80 minutes before dying on an out-of-range limb access; moving each literal into the `COMP-5` variable `S` first makes the row finish in 60 s with the right answer. Three more tasks needed a wider output `PIC`: 07 and 15 printed a leading zero (`9(7)`/`9(9)` for 6- and 8-digit answers) and 14 truncated (1937768448 needs 10 digits, not 9). |
| Vala | valac | 0.56 | MSYS2 `ucrt64` on Windows, distro package elsewhere | `valac -X -O2 -o prog <task>.vala`, run from the MSYS2 UCRT64 shell. `valac` translates to C and drives `gcc`; `-X -O2` is what hands `-O2` to that gcc, and without it the generated C is compiled unoptimised. The build needs `valac` plus GLib's development files (`pkg-config` resolves them). The generated binary imports `libglib-2.0-0.dll` **whenever the Vala code touches GLib**, which is most of these tasks, so those executables need the UCRT64 `bin` directory on `PATH` at run time; the few tasks that call no GLib function at all link nothing extra and run with a bare system `PATH`. Each file's header says which case it is. Static linking (`-X -static`) fails and is not used. Task 03 also compiles `03_func_sum_add_one.vala` on the same command line, because Vala has no no-inline attribute. Task 11 uses `GLib.Thread<int64?>` with a lambda, joined in spawn order; task 10 hand-writes the base-10^9 limbs, since GLib has no big integers. |
| Beef | BeefBuild | 0.43.5 | beeflang.org/setup, `BeefSetup_0_43_5.exe` (259 MB) extracted with 7-Zip, not installed — no admin | `tools/beef/bin/BeefBuild.exe -proddir=sources/beef/<task> -config=Release -platform=Win64`, then `sources/beef/<task>/out/prog.exe`. **`-config=Release` is mandatory**: Beef's Windows Debug toolset is Microsoft's and stops without Visual Studio, while Release links with the bundled `lld-link.exe`. Every project wrapper also sets `CLibType = "SystemMSVCRT"`, because the Release default asks for MSVC's static CRT. `corlib` is recompiled once per project on every build, so a task takes 11-23 s. |
| Haxe | hxcpp | 4.3 | haxe.org win64 zip, plus `neko` for `haxelib` and a 64-bit MinGW `g++` | `haxe -cp sources/haxe -main T01_branches -cpp temp/haxe/01_branches -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs`, then `<outdir>/T01_branches.exe`. `haxe -cpp` writes C++ and runs `haxelib run hxcpp`, which drives `g++` and `windres`; `-D no_shared_libs` is what makes the link static. `MINGW_ROOT` is not optional — hxcpp guesses `c:/MinGW` and otherwise stops with `Could not guess MINGW_ROOT`. |
| JavaScript | spidermonkey | C159.0a1 | archive.mozilla.org — the official Firefox nightly `jsshell-win64.zip` (18 MB), extracted into `tools/spidermonkey/`; no installer and no admin. It is a **shell**, not Node, so `require` and `worker_threads` do not exist. | **No build step**: `tools/spidermonkey/js.exe <task>.js`. `print()` is the output call; there is no `console.log` guarantee. Tasks 14 and 15 need `data.bin` in the working directory. |
| Haxe | haxe (js) | 4.3 | haxe.org win64 zip | `haxe -cp . -main T<NN>_<name> --js js/T<NN>_<name>.js`, run with `node js/T<NN>_<name>.js`. **The js target has no `sys` package at all**, so the row carries one shared shim, `sources/haxe/Out.hx`, whose `line`/`err` use `js.Syntax.code` on js and `Sys.println`/`Sys.stderr()` everywhere else; the task sources call `Out.line` and are otherwise unchanged. Tasks 11, 14 and 15 need node's `worker_threads` and `fs` through `js.Syntax.code`. |
| Haxe | haxe (jvm) | 4.3 | haxe.org win64 zip, plus the hxjava library | `haxe -cp . -main T<NN>_<name> --jvm jvm/T<NN>_<name>.jar`, then `java -jar jvm/T<NN>_<name>.jar`. The target needs **hxjava**, whose haxelib fetch is HTTP 403 here; it is vendored from the GitHub source archive (`hxjava-4.2.0.zip`, which carries `lib/hxjava-std.jar`) into `tools/hxjava/` and registered with `haxelib dev hxjava <dir>`. |
| Haxe | haxe (cs) | 4.3 | haxe.org win64 zip, plus Mono's `csc` and the hxcs library | Two steps, because Haxe's own build tool would want MSBuild: `haxe -cp . -main T<NN>_<name> --cs cs/T<NN>_<name> -D no-compilation` emits C#, then `csc -out:cs/T<NN>_<name>.exe -target:exe @cs/T<NN>_<name>.rsp` compiles it (the response file is the `dir /b /s` of the generated `*.cs`). The `.NET` externs need **hxcs**, vendored the same way as hxjava. Run with `mono cs/T<NN>_<name>.exe`. |
| Haxe | hashlink | 4.3 | haxe.org win64 zip for the compiler, plus the HashLink VM — `hashlink-1.16.0-win64.zip` extracted into `tools/hashlink/` (the `hl.exe` runtime and its `*.hdll` natives). No installer and no admin. | Two steps, unlike the `hxcpp` row: `haxe -cp sources/hashlink -main T<NN>_<name> -hl <out>.hl`, then `hl <out>.hl`. `-hl` emits bytecode for the VM instead of C++, so there is no C toolchain and no hxcpp in the path. The measured run is the `hl` one; both binaries have to be on `PATH`. |
| Scala | native | 0.5 (0.5.12 measured) | scala-cli plus a C toolchain; on Windows the portable llvm-mingw zip, no admin | `scala-cli --power package <task>.scala --native -S 3.9.0 --native-version 0.5.12 --native-mode release-fast --native-clang <llvm-mingw>/bin/clang.exe --native-clangpp <llvm-mingw>/bin/clang++.exe --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe`, then `prog.exe`, run from `sources/scala-native/`, which holds the same fifteen files as the `jvm` row. `--native-mode release-fast` is mandatory: the default `debug` mode compiles with `-O0` and measured 0.270 s against 0.074 s on task 02. |
| Standard ML | Poly/ML | 5.9.1 | github.com/polyml/polyml releases, `PolyML5.9.1-64bit.msi` (3.03 MB), extracted with `msiexec /a <msi> TARGETDIR=<dir> /qn` — no admin. **v5.9.2 is newer but has no Windows asset at all**; 5.9.1 is the one. | Two steps, and they are the two `polyc` would have driven, because the MSI ships no `polyc` and no import library (see below): `PolyML.exe -q --error-exit --script build/<task>.ML` exports a whole heap image to `<task>.obj`, where the driver file contains `use "<task>.sml"; PolyML.export ("<task>", main);`, then `gcc -Wl,-u,WinMain -mconsole -o prog.exe <task>.obj polystub.obj -Ltools/polyml -lpolyml`. **`PolyLib.dll` must sit beside the produced executable** or it dies before `main` with `STATUS_DLL_NOT_FOUND` and no output. Task 03 loads `03_func_sum_add_one.sml` with `use` and sets `PolyML.Compiler.maxInlineSize := 0` **before** it — a separate file alone is not enough. Task 14 reads in 65536-byte chunks. |

| Pony | ponyc | 0.65.0 | `tools/ponyc` — a release build extracted, no installer and no admin. **0.65.0 is deliberate**: ponyc 0.66.0 changed how Pony does networking on Windows and the release now documents Windows 11 / Server 2022 (build 20348) as the minimum, because the networking layer uses an OS readiness API introduced there. This host is Windows 10 19045 and 0.65.0 predates the change, so it is the last release that runs here. | `ponyc` compiles a **directory** as one package and names the executable after that directory, and all fifteen files declare `Main`, so each task is built from a scratch directory named after it: `mkdir -p temp/pony/<task> && cp sources/pony/<task>.pony temp/pony/<task>/ && tools/ponyc/bin/ponyc.exe -o temp/pony/<task> temp/pony/<task>` produces `temp/pony/<task>/<task>.exe`. Every link prints `O sistema não pode encontrar o caminho especificado.` — harmless, the executable is still produced. |
| Lean 4 | lean | 4.34.1 | github.com/leanprover/lean4 releases, `lean-4.34.1-windows.zip` (811 MB), extracted — no installer and no admin. Windows is a **Tier 1** platform for Lean, so the binary release is built and tested by Lean's own CI. | Two steps: `lean -c <task>.c <task>.lean` compiles the module to C, then `leanc -O2 -o prog <task>.c` links it. `leanc` drives the toolchain Lean ships with itself — the `clang`, `lld` and Lean runtime DLLs all live in `tools/lean4/bin/` — so **put `tools/lean4/bin` on `PATH` first**, or `leanc` cannot find its own linker. The interpreter (`lean --run <task>.lean`) also works and is what a quick check uses, but the compiled route is the measured one because the interpreter is far slower on the 100-million-iteration tasks. |
| Common Lisp | ecl | 24.5.10 | conda-forge `ecl-26.5.5` (or 24.5.10) `win-64` build, unpacked from the `.conda` archive — no installer and no admin. ECL has **no Windows binary upstream**: `ecl.common-lisp.dev` publishes source tarballs only, and MSYS2 and Cygwin carry no `ecl` package at all, so conda-forge is the only prebuilt Windows route. | `ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) … (compile-file \"<task>.lisp\" :output-file \"<task>.fas\") (ext:quit))"` then `ecl.exe --norc --eval "(load \"<task>.fas\" :verbose nil)"`, run from `sources/commonlisp-ecl/`. ECL compiles to C and routes it through a C compiler, which has to be pointed at the hand-extracted MSVC tree with `c::*cc*`/`c::*ld*` plus `INCLUDE` and `LIB`; the exact values are in each file's header. |

### Compiled to WebAssembly — the runtime is the VM, and the module is the program

The output is a `.wasm` module, so a WebAssembly runtime starts on every measured run. Eight rows
share one runtime, **wasmtime**, pinned to **46.0.3** for the reason in the `wasi-threads` note
below; the install is the release zip extracted under `tools/wasmtime46/`, no installer and no
admin. Four of the eight — C, C++, Rust and Go — build the same sources as their native
rows, because those source sets were already written for a POSIX target; each still has its own
directory, `sources/c-wasm/`, `sources/cpp-wasm/`, `sources/rust-wasm/` and `sources/go-wasm/`.
Lua is the exception in content rather than in layout: its task 11 cannot use the mechanism the
native row uses, so `sources/lua-wasm/` holds a different file for it.

The C and C++ rows need no source change at all: `11_parallel_sum.c` already selects its
pthread branch under `#else` of `#if defined(_WIN32)`, and wasm32 is not `_WIN32`.

One of these cannot use the concurrency facility its native row uses, and says so in its own
source and entry: **Lua** has no threads at all on wasip1 (Lanes has no wasm build), so its
four workers are coroutines. It is a correct-answer-no-speedup cell.

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| C | wasm32-wasip1 (clang) | wasi-sdk 34 (LLVM 23.1) | wasi-sdk release tarball, `wasi-sdk-34.0-x86_64-windows.tar.gz` (619 MB), extracted into `tools/wasi-sdk/` — no installer, no admin | `clang --target=wasm32-wasip1 -O2 -o prog.wasm <task>.c`, run from `sources/c-wasm/`. Task 11 adds `-pthread --target=wasm32-wasip1-threads -Wl,--import-memory -Wl,--export-memory -Wl,--shared-memory -Wl,--max-memory=2147483648`. |
| C++ | wasm32-wasip1 (clang++) | as above | as above | `clang++ --target=wasm32-wasip1 -O2 -fno-exceptions -o prog.wasm <task>.cpp`, run from `sources/cpp-wasm/`. **`-fno-exceptions` is required**: `libc++abi` is not in the sysroot's default link, so tasks 08 and 10 fail at link with `undefined symbol: __cxa_allocate_exception` without it. Task 11 adds the same four thread flags as the C row. |
| Rust | wasm32-wasip1 (rustc) | 1.90 | `rustup target add wasm32-wasip1` (tier 2, prebuilt std) | `rustc --target wasm32-wasip1 -O -o prog.wasm <task>.rs`, run from `sources/rust-wasm/`. Task 11 uses `--target wasm32-wasip1-threads`, which is a **tier 3** target and has no prebuilt std — `rustup target add` fetches a std it has to build locally. |
| Go | gc (wasip1) | 1.26 | the Go SDK already installed for the native `go` row — `C:\Program Files\Go` | `GOOS=wasip1 GOARCH=wasm CGO_ENABLED=0 go build -o prog.wasm <task>.go`, run from `sources/go-wasm/`. The same fifteen sources as the native row; no task needs a special build, because Go's single-threaded wasip1 runtime multiplexes task 11's goroutines onto one thread and the module imports no shared memory. |
| AssemblyScript | wasip1 (asc) | 0.28 | `npm install assemblyscript` into `tools/assemblyscript/` | `asc <task>.ts -O2 --outFile prog.wasm --runtime incremental --use abort=<task>/abortImpl`. **`asc` must be run with the row's directory as the working directory**, because the `--use abort=…` specifier is resolved relative to the source file. Task 11 adds `--enable threads --importMemory --sharedMemory --maximumMemory 1024`. Task 03 calls `add_one` through a WASM function-table `call_indirect`, not directly: `@noinline` is only a front-end hint, and Wasmer LLVM/WAMR otherwise reduce the 100M calls to a sub-tick or folded-away workload. |
| WebAssembly | hand-written WAT | none | none — the runtime is the whole toolchain, plus **wabt 1.0.42** for the Wasmer cells | **No build step for wasmtime.** `wasmtime run <task>.wat` parses the text on every run; measured, that costs 51 ms against 52 ms for the equivalent binary module, i.e. nothing. **Wasmer cannot read the `.wat` text form**, so `build_all.bat` also assembles each task to a committed `prog.wasm` with `tools/wabt/wabt-1.0.42/bin/wat2wasm.exe` (the `wabt-1.0.42-windows-x64.tar.gz` release from github.com/WebAssembly/wabt, extracted under `tools/wabt/` — no installer, no admin). Task 11 needs `--enable-threads`; **do not use `--enable-all`** there, because it also turns on compact imports and both wasmtime and Wasmer then reject the module with `invalid leading byte (0x7f) for external kind`. |
| Lua | wasip1 (puc-lua) | 5.4.8 | the `lua-5.4.8.tar.gz` source release (374 KB), cross-compiled once with the `wasi-sdk` tree the C row already installs — no new download | Compile the 33 core sources with **`clang++ -fexceptions`**, not `clang`, with the shim directory first on the include path: `clang++ --target=wasm32-wasip1 -O2 -fexceptions -DNDEBUG -D_WASI_EMULATED_SIGNAL -DL_tmpnam=32 -I<shim> -I<src> -c <file>.c`, skipping `luac.c`, which has its own `main`. In C mode `ldo.c` emits real `setjmp`/`longjmp` calls that nothing defines and the link dies with `undefined symbol: longjmp`. Then link them with `clang++ --target=wasm32-wasip1 -O2 -fwasm-exceptions -mllvm -wasm-use-legacy-eh=false -L<wasi-sdk>/share/wasi-sysroot/lib/wasm32-wasip1/eh -lc++abi -lunwind -lwasi-emulated-signal -lwasi-emulated-process-clocks -o lua.wasm *.o wasi_shims.c`. Four things carry the target, and none of them changes a Lua source line. The sources are `sources/lua-wasm/`, a complete fifteen-file set; fourteen are byte-identical to `sources/lua/`'s and task 11 differs. `-D_WASI_EMULATED_SIGNAL`/`-lwasi-emulated-signal` because `lstate.h` uses `sig_atomic_t`; `-lwasi-emulated-process-clocks` because `loslib.c` and `ltablib.c` call `clock()`; `-DL_tmpnam=32` because wasi-libc does not define `L_tmpnam`; and the C++ exception route because wasi-libc turns `<setjmp.h>` into a hard `#error` unless `-mllvm -wasm-enable-sjlj` is set, and that path emits *legacy* `try` instructions that both wasmtime 46 and 49 refuse with `legacy_exceptions feature required`. `ldo.c` already prefers `throw`/`catch` over `setjmp` under `__cplusplus`, so compiling the sources as C++ is Lua's own supported configuration and the only one the runtime can execute. `tools/lua-wasm/wasi_shims.c` supplies `tmpfile`, `tmpnam` and `system`, which wasi-libc omits and no task calls. Run line: `wasmtime -W exceptions=y --dir . lua.wasm <task>.lua`. Task 11 cannot use the Lanes extension the native Lua rows use — Lanes is a pthreads C extension with no wasm build — so the row uses **coroutines**, the language's own cooperative concurrency, and `sources/lua-wasm/11_parallel_sum.lua` says so. |

| Zig | wasm32-wasip1 (zig) | 0.16 | ziglang.org/download, the same tree the native `zig` row installs | `zig build-exe <task>.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm`, run from `sources/zig-wasm/`. Zig 0.16 replaced `std.posix.write` and moved `std.fs` onto `std.Io`, so the entry point is `pub fn main(init: std.process.Init) !void` and output goes through `std.Io.File.stdout().writeStreamingAll(io, …)`; `sources/zig/` is the native sibling with the same shape. Task 11 needs `-fno-single-threaded -mcpu=generic+atomics+bulk_memory --shared-memory --import-memory --export-memory --max-memory=2147483648 -rdynamic`: **`-rdynamic` is load-bearing** — wasm-ld only exports symbols in the dynamic table, and without it wasmtime aborts with `failed to find a wasi-threads entry point function; expected an export with name: wasi_thread_start`. |

**Six runtimes, one artifact.**
unchanged under every runtime below, which makes them a controlled comparison of the runtime
alone — same bytes, same answers, different execution backend:

| Runtime | Install | Run line |
|---|---|---|
| wasmtime 46.0.3, Cranelift | the release zip under `tools/wasmtime46/` | `wasmtime run -C compiler=cranelift prog.wasm` |
| wasmtime 46.0.3, Winch | the *same binary* — only the code generator changes | `wasmtime run -C compiler=winch prog.wasm` |
| WAMR 2.4.5 (`iwasm`) | `iwasm-2.4.5-x86_64-windows-2022.zip` under `tools/wamr/` | `iwasm --dir=. prog.wasm` |
| V8 (node 22) | node under `tools/nodejs/`, plus a 20-line WASI shim | `node --no-warnings tools/nodejs/wasi-run.js prog.wasm .` |
| Wasmer 4.3.7, Cranelift | `wasmer-windows-amd64.tar.gz` (v4.3.7) extracted into `tools/wasmer437/` — no installer, no admin | `wasmer run --cranelift --mapdir /:<dir> prog.wasm` |
| Wasmer 4.3.7, LLVM | the *same binary* — only the code generator changes | `wasmer run --llvm --mapdir /:<dir> prog.wasm` |

**Wasmer is pinned to 4.3.7, not the current 7.x.** Wasmer 7 removed the `--cranelift` and
`--llvm` selectors from `wasmer run` (and deprecated `--dir` in favour of `--volume`), so the
two-code-generator arrangement only exists up to 4.x. `--singlepass`, a third selector in 4.x,
was dropped from the matrix on 2026-10-10: it deadlocked on the `wasi-threads` task.
Tasks 14 and 15 use `--mapdir /:<host dir>` rather than `--dir=.`, because Wasmer's `--dir=.` preopens an
empty root and the relative name does not resolve. Wasmer is a **WASIX** host rather than a
plain WASI one, which is what produces the boundaries below.

Cranelift and Winch are the same runtime with two code generators, so that pair isolates the
compiler: measured on `c-wasm` task 01, Cranelift is **6.3x faster** than Winch on byte-identical
input. Two capability boundaries are worth recording rather than treating as failures:

  `thread-spawn` symbol in any form, and the module dies at instantiation with
  `unknown import: "wasi".thread-spawn`. `--enable-threads` only makes the *loader* accept the
  shared memory — the module is a `-Wl,--import-memory` build, so the host must own the linear
  proposal table lists Threads for interpreter and AOT mode only, with no JIT column.
- **node's WASI shim used to be unable to run the `wasi-threads` task**, because node's `WASI`
  provides no `env` import object and no `wasi.thread-spawn`. That shim is the repository's own
  `exec/wasi-run.js`, not a third-party toolchain, so it now supplies both: it parses the
  `env.memory` import for its shared limits, creates a shared `WebAssembly.Memory`, answers
  `wasi.thread-spawn` with a `node:worker_threads` Worker and enters `wasi_thread_start` there.
  All seven rows answer task 11 through it.
- **Winch does not implement `wasm_exceptions`**, which the Lua and CPython WASI builds need,
  so those three interpreted rows stay on Cranelift only.

Wasmer's own boundaries, all of them consequences of it being a WASIX host:

- **A file the program *creates* never reaches the host filesystem.** WASIX overlays the mapped
  directory, so a new file lives in an in-memory layer that is discarded at exit, while a write
  to a file that *already exists* does reach the host. Verified directly: with the committed
  `out.bin` moved aside, `wasmer run --cranelift --mapdir /:<dir> prog.wasm` on the `wasm` row's
  task 15 prints the right answer and exits 0, and `out.bin` is not there afterwards. The
  registry therefore marks these entries `create_out`, so `exec/harness.py` stages an empty
  `out.bin` after its usual reset and the module truncates and overwrites it, which does reach
  the host. `fopen("wb")` truncates either way, so the measured work is the same 50 MiB write.
  See `RUN.md`.

Wasmer is pinned to the same 4.3.7 release as the rest of the row, and its `--singlepass` third
code generator and the `wasm3` interpreter were both removed from the matrix rather than carried.

Run lines, all eight rows: `wasmtime run prog.wasm`. Task 11 adds
`-S threads=y -W threads=y -W shared-memory=y` for the six compiled rows. Tasks 14 and 15 add
`--dir=.` **from a directory holding `data.bin`**, and the Lua row needs `--dir=.` on
**every** cell, because the script itself is read through the preopen. Go is the exception on
the file tasks: it opens its preopens by the WASI name and expects it to be `/`, so its two
cells take `--dir <host dir>::/` and the plain `--dir=.` panics with
`open data.bin: Bad file number`. Go's wasip1 port is single-threaded, so task 11 imports no
shared memory and needs no thread flag anywhere on this row.

**`wasi-threads` was deleted in wasmtime 47.** The accepted RFC
(`rfcs/accepted/wasmtime-remove-wasi-threads.md`) removes the `wasmtime-wasi-threads` crate in
47 and makes the `-S threads` flag an unconditional error; on 49 the flag still appears in
`-S help` and then errors when used, which is misleading. Task 11 therefore pins the runtime to
46.0.3, the last release that implements the API.

**The one silent failure worth knowing.** A `wasi-threads` module must import its memory from
`env` **and** export it — `(import "env" "memory" (memory … shared))` plus
`(export "memory" (memory 0))`. With only an exported memory the module still instantiates,
`thread-spawn` still returns a valid positive thread id, and `wasi_thread_start` **does** run —
but every store the worker makes is lost, so the parent reads zeros and task 11 prints `0`
instead of `8748000081000000`, with no diagnostic of any kind. The C and C++ rows get the pair
from `-Wl,--import-memory -Wl,--export-memory`; the hand-written row spells it out.

### Compiled to bytecode — the VM is needed on every run

These compile once, but the output is bytecode or an intermediate form, so a virtual machine
has to start on every measured run. That startup is part of the number.

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| Java | openjdk | 17 | jdk.java.net or Adoptium | `javac _<task>.java`, then `java -cp . _<task>` |
| Java | openjdk (interp) | the `openjdk` row's JDK | nothing to install beyond that JDK | **No build step of its own**: the class files are the `openjdk` row's, and this toolchain is the run line `java -Xint -cp . _<task>`. `-Xint` turns off both JIT tiers, so the template interpreter executes every bytecode — the row's `bytecode-vm` cell, against the same class files on C1, C2 and the default tiered pipeline. |
| Java | openjdk (c1) | the `openjdk` row's JDK | nothing beyond that JDK | `java -XX:TieredStopAtLevel=1 -cp . _<task>`: the C1 client compiler compiles the hot methods and the C2 tier is never entered, so the cell is C1's code with C1's profiling still running. |
| Java | openjdk (c2) | the `openjdk` row's JDK | nothing beyond that JDK | `java -XX:-TieredCompilation -cp . _<task>`: C1's profiling tier is off, so C2 — the server compiler — compiles each method on first call. This is the C2 the default row reaches only after C1 has warmed the method up. |
| Java | openj9 | 21 | IBM Semeru Open Edition, `ibm-semeru-open-jdk_x64_windows_21.0.12.15.zip` (230 MB) extracted into `tools/openj9/` — no installer, no admin, and it brings its own `javac` | `tools/openj9/bin/javac.exe -d . _<task>.java`, then `tools/openj9/bin/java.exe -cp . _<task>`. **Eclipse OpenJ9, not HotSpot**: run from `sources/java-openj9/`, which holds the same fifteen files as the `openjdk` row, unchanged, with no OpenJ9-specific flag and no `-X` option. The whole difference is which VM executes the bytecode — OpenJ9's JIT (`openj9-0.61.0`) against HotSpot's C2 — and OpenJ9 maps `java.lang.Thread` onto OS threads, so task 11 is a real four-thread pass. Verified with `java -version`, which reports `Eclipse OpenJ9 VM 21.0.12.15`. |
| Java | graalvm jit | GraalVM 21 (25.0.4 measured) | graalvm.org, the same JDK tarball the `graalvm native-image` row installs | **No separate build step**: `javac _<task>.java` produces the same class files, and the row is the run line `<graalvm>/bin/java -cp . _<task>`. The whole difference from the `openjdk` row is which JIT compiles the bytecode: GraalVM's JDK has `EnableJVMCI`, `EnableJVMCIProduct` and `UseJVMCICompiler` all `true` by default, so the Graal compiler replaces HotSpot's C2 without any flag. Verified with `java -XX:+PrintFlagsFinal -version`. The sources are `sources/java-graalvm-jit/`, the same fifteen files as the `openjdk` row. |
| Kotlin | jvm | 1.9 (2.4.20 measured) | kotlinlang.org, `kotlin-compiler-<v>.zip` (85 MB) extracted — no installer and no admin. Needs a JDK on `PATH`; `JAVA_HOME` selects which | `kotlinc <task>.kt -include-runtime -d prog.jar`, then `java -jar prog.jar`, run from `sources/kotlin/`, which holds all fifteen tasks. `-include-runtime` bundles `kotlin-stdlib` into the jar, so the run line needs a JRE and nothing else. Task 11 uses four `java.lang.Thread` workers. |
| C# | coreclr | .NET 8 | dotnet.microsoft.com | `dotnet build -c Release` |
| C# | mono | 6.12 | mono-project.com | `mcs -optimize+ <task>.cs` |
| C# | mono (aot) | 6.12 | the same `mono.msi` the `mono` row installs, unpacked with `msiexec /a` (no admin) | Two steps on the same assembly: `mcs -optimize+ <task>.cs`, then `mono --aot=full <task>.exe`, which writes `<task>.exe.dll` — a native DLL holding the ahead-of-time code. It is run with `mono --full-aot <task>.exe`, the runtime's aot-only mode, where the JIT is off and only that module may execute. Two extra tools have to be on `PATH`: mono's AOT driver shells out to **`clang.exe`** for the assembler (`--target=x86_64-pc-windows-msvc`) and to **`link.exe`** for the DLL, so the build uses `tools/llvm-mingw/bin` plus the MSVC environment from `tools/msvc_env.py`; without clang it stops with `'"clang.exe"' is not recognized`. The framework assemblies the loader walks before the program starts — `mscorlib`, `System`, `System.Core`, `System.Numerics`, `Mono.Security`, `I18N`, `I18N.West`, `System.Xml`, `System.Configuration`, `System.Security` — each need their own `--aot=full` image as well, and the image has to sit **beside the framework assembly itself** (`lib\mono\4.5\` for mscorlib, the GAC directory for the other nine), never beside the task: a copy next to the task is ignored, because the AOT image is looked up from the path the assembly resolved to, not from the cwd or `MONO_PATH`, and `--full-aot` then still dies with `Failed to load AOT module '…\mscorlib.dll.dll' in aot-only mode` (exit 9). It is a one-time per-machine build step of **about three minutes**, not a per-task one — `build_all.bat` runs it first and skips whatever is already there; `mscorlib` alone is ~40 s of that and `System`, `System.Core` and `System.Xml` ~20-30 s each, so `1.5 s` is only true of the `I18N`/`System.Numerics` end of the range. **`mono --llvm` is not available on Windows**: the official MSI is built without LLVM (`Mono Warning: --llvm not enabled in this runtime.`, and `mono --aot=llvm` answers `requires a runtime compiled with llvm support.`), and enabling it means a from-source Cygwin+MSVC build with `--enable-llvm` — see the note below. |
| F# | dotnet | .NET 8 | as above | `dotnet build -c Release` |
| VB.NET | dotnet | .NET 8 | as above | `dotnet build -c Release`, with a `.vbproj` instead of a `.csproj`. Same SDK as C# and F#, so no extra install. |
| Scala | jvm | 3.3 | scala-lang.org | Two steps: `scalac -release 17 -d out <task>.scala`, then `java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main`, where `<scala>` is the distribution and `<v>` its version. **Scala CLI's `scala` is a subcommand runner, not the classic `scala Main` launcher**, so it rejects `scala Main` with `Main is not a scala sub-command`; running the compiled class through `java -cp` is the equivalent and it also keeps the launcher's own start-up out of the measurement. The compiler needs a JDK 17 or newer on `PATH`. |
| Scala | scala-cli (js) | 3.9.0 (Scala.js 1.22.0) | scala-cli, plus a JDK for the compiler; the Scala.js linker (`scala-js-ld`) downloads itself on first use | `scala-cli --power package <task>.scala --js -o prog.js --force --jvm system`, then `node prog.js`. `--jvm system` is required: without it scala-cli tries to download its own JDK and fails. The same fifteen files as the `jvm` row except tasks 11, 14 and 15 — see the row's own headers. |
| Clojure | cljs.main | 1.11.132 | the official ClojureScript release jar, `tools/clojurescript/cljs.jar` (31 MB) — it bundles the Closure compiler, which the 5 MB Maven artifact does **not** | `java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t<NN>-<name>`, then `node prog.js`. The namespace must match the file name, so the sources are `t01-branches` … `t15-file-write`. Tasks 11, 14 and 15 differ from the `clojure` row's files. |
| OCaml | ocamlopt | 5.0 (5.4.1 measured) | MSYS2 UCRT64 `mingw-w64-ucrt-x86_64-ocaml`, plus `mingw-w64-ucrt-x86_64-flexdll` | `ocamlopt -unsafe -o prog.exe _<task>.ml`. **Version 5 is required**: the 4.14 toolchain that the old "OCaml for Windows" installer ships has no `Domain` module and serialises `Thread`, so task 11 could only be a correct-answer-no-speedup cell there. `-unsafe` drops array and string bounds checks, which is the usual speed knob; `-O3` is accepted but is a **no-op** unless the compiler was built with Flambda, and the MSYS2 package reports `flambda: false`. Two environment details are mandatory and neither is obvious. `OCAMLLIB` must be set to the **Windows** form of the stdlib directory (`C:\...\ucrt64\lib\ocaml`), because `ocamlopt` is a native Win32 binary and the MSYS2-style `/ucrt64/...` path baked into its config resolves to nothing — without it every compile fails with `Unbound module Stdlib`. And `flexdll` is a **separate package**; without it the link step stops with `'flexlink' is not recognized`. Filenames carry the row's `_` prefix because OCaml derives a module name from the file name and a module name must be a valid identifier, so `01_branches.ml` draws `Warning 24: bad source file name`. Task 03 uses `[@inline never]`, OCaml's own no-inline attribute, so it needs only one file. Task 10 hand-writes the base-1e9 limbs in `int64`: the standard library has no bignum, and `zarith` is not in MSYS2's UCRT64 repository. Task 11 uses `Domain.spawn`/`Domain.join`. |
| OCaml | ocamlc (bytecode) | 5.0 (5.4.1 measured) | the same MSYS2 UCRT64 `ocaml` package the `ocamlopt` row installs — nothing extra | Two steps, run from the MSYS2 shell so the OCaml runtime DLLs resolve: `ocamlc -I +unix unix.cma -o prog.exe _<task>.ml`, then `./prog.exe`. The sources are the `ocamlopt` row's own fifteen files, unchanged — this is a backend comparison, not a second program. Three things are load-bearing. **`-I +unix unix.cma` is required**, or the link fails with `No implementation provided for the following modules: Unix`. The build must run **inside the MSYS2 shell** with `OCAMLLIB` set to the Windows form of the stdlib directory, because the produced launcher needs `ocamlrun.exe` and `dllunixbyt.dll` on `PATH`; `-custom` does not work here, since it needs a C compiler and fails with `stdio.h: No such file or directory`. And the source file names keep the row's leading underscore, because OCaml rejects a file whose name starts with a digit (`bad source file name: 01_branches is not a valid module name`). Bytecode is the interpreter half of the pair: measured 5.3 s against the native row's 0.4 s on task 01. |
| ActionScript | AIR | 51.4.1 | AIR SDK from harman.com/developer/air | Two steps. `amxmlc -swf-version=51 -output prog.swf _<task>.as` compiles the AS3 to a SWF, then `adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf` packages it into a standalone `out\prog.exe` with the AIR runtime bundled beside it. Use **`amxmlc`, not `mxmlc`**: only `amxmlc` links against `airglobal.swc`, so the AIR-only APIs this row needs (`System.output`, `flash.filesystem`, `Worker`) do not exist under the plain Flex compiler. A JDK (17 works) has to be on `PATH` for both tools. `adt` refuses to package an unsigned bundle, so one self-signed certificate is generated once with `adt -certificate -cn SelfSigned 2048-RSA test.p12 pass` and reused by every task. **The signing options must precede `-target`**: `adt` scans for them in order and otherwise stops with `Found misplaced signing arguments`, and the application descriptor has to be the literal `app.xml` path rather than the class name or it reports `error 301: Application descriptor missing`. Class names carry the row's `_` prefix because AS3 requires the public class name to equal the file name and a file cannot start with a digit. One shared `app.xml` sits beside the fifteen `.as` files, the way GDScript's `project.godot` does, because every task compiles to `prog.swf` and packages to `prog.exe`; only the `.as` name changes between tasks. Task 11 is two translation units: `_11_parallel_sum_worker.as` compiles separately to `worker.swf`, which the `adt` line passes as an extra file so it lands in the bundle and the main SWF can load its bytes for `createWorker`. Task 14's `data.bin` is passed to `adt` the same way — see the note below on why. |

| Haskell | ghc | 9.14 | downloads.haskell.org — `ghc-9.14.1-x86_64-unknown-mingw32.tar.xz` (452 MB, 4.1 GB extracted) unpacked into `tools/ghc/`. **The bindist bundles its own MinGW**, so no MSVC and no Windows SDK are needed. No installer and no admin. | `ghc -O2 -threaded -o prog <task>.hs`, then `prog`. **`-threaded` is required for task 11** and the row is run as `prog +RTS -N4 -RTS`; without `-threaded` there are no capabilities to schedule onto. `-O2` alone is what the other compiled rows use. |
| Forth | gforth | 0.7.9 | github.com/fukuyori/gforth_for_windows releases — `gforth-native-0.7.9_...-x64-setup.exe` (3.4 MB). It is an Inno Setup archive, so `7z` refuses it and `innoextract` 1.9 cannot read its 6.5 setup-data version; it is run **silently** instead, `gforth-setup.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /DIR=<target>`. Its manifest sets `PrivilegesRequired=lowest` and installs under the user profile, so no admin and no registry. | **No build step** — gforth interprets the file: `gforth <task>.fs`. The interpreter needs its image `gforth.fi` and the working directory's `data.bin` at once; in this layout `gforth.exe` finds the image beside itself, so no `GFORTHPATH` is needed as long as the run directory holds the sources and the fixture (verified 15/15 without it). Output has a trailing space after the numbers, so a byte-exact comparison must trim. |
| Mercury | mmc | 22.01.9 | Built from source: the `mercury-srcdist-22.01.9.tar.gz` release compiled with the MSYS2 UCRT64 gcc the `valac` row already installs, and `mercury_compile.exe` was copied into `tools/mercury/bin/` so the toolchain does not depend on the source tree. No Windows binary is published. The configured grade is **`hlc.gc.pregen`** — the default `hlc.gc` is not installed and every build fails with "the Mercury standard library cannot be found in grade hlc.gc". | `mercury_compile --make <module> --grade hlc.gc.pregen`, with `MERCURY_STDLIB_DIR` pointing at the installed `lib/mercury`, `mkinit.exe` on `PATH`, and UCRT64 `gcc` on `PATH` for the C back end. A Mercury module name cannot start with a digit, so the files are `01_branches.m` and the modules are `m01_branches`; `Mercury.modules` holds the mapping. **Task 11 is compiled with `--grade hlc.par.gc`** instead, because the default grade has no parallelism; the other fourteen use `hlc.gc.pregen`. |

One SDK covers three rows here. C# (`coreclr`), F# and VB.NET are separate compilers and
separate cells, but they all build with the .NET SDK and run on the .NET runtime, so
installing it once fills all three. VB.NET is the only one of the three that needs a
`.vbproj` rather than a `.csproj` or `.fsproj`.

### No build step — the interpreter is the runtime

These are interpreted or JIT-compiled, so there is nothing to compile and their compile
time is zero. Everything is paid at run time.

| Language | Toolchain |
|---|---|
| JavaScript | bun, deno |
| Prolog (GNU) | gplc | 1.5.0 | `setup-gprolog-1.5.0-mingw-x64.exe` (6.7 MB) from gprolog.org, unpacked with `tools/_dl/innoextract.exe -e -s -d tools/gprolog` — **7-Zip cannot read this installer**, innoextract identifies it as `GNU Prolog version 1.5.0 - setup data version 6.1.0 (unicode)` and extracts an `app/` tree that is then moved up to the install root. No admin, no installer. | `gplc --no-top-level -o <task>.exe <task>.pl <shim.c>` — **this is a native compiler, not an interpreter row**: `gplc` runs `pl2wam` (.pl → WAM), `wam2ma` (WAM → mini-assembly), `ma2asm` (mini-assembly → x86-64 assembly), `as` and then `gcc` against the GNU Prolog runtime archives, all at BUILD time, so the whole pipeline is outside the timer and the measured cell is the stand-alone `.exe`. `pl2wam`/`wam2ma`/`ma2asm` must be on `PATH` (they ship in the same `bin/`) and `gcc`/`as` come from the MSYS2 UCRT64 tree. **One shim is required to link**: `tools/gprolog/shim/gpl_ucrt_env.c` is passed to `gplc` as one more input file and supplies the data symbol `__imp__environ` that the prebuilt `lib/libbips_pl.a` expects — that archive was built against an older mingw-w64 whose msvcrt import library exported `environ` as data, while the UCRT-based gcc 16.2.0 here exposes it only through `__p__environ()`, so without the shim the link stops with `undefined reference to __imp__environ`. Tasks 05 and 12 need `--global-size` raised (1048576 and 262144). **Task 11 is four child processes of the same compiled executable** — GNU Prolog 1.5.0 has no thread primitive at all (`error(existence_error(procedure,thread_self/1),main/0)`) — re-invoked via `exec/5` with `argument_value(0, Self)` as the program path, joined with `wait/2`; `spawn/3` cannot be used because it blocks until the child exits and would serialise the quarters. Measured ~2.1x on four cores. Verified 15/15. |
| PHP | zend | 8.5.11 (ZTS) | windows.php.net, `php-8.5.11-Win32-vs17-x64.zip` (36 MB, the non-`nts` name is the thread-safe build), extracted into `tools/php-zts/` — no installer, no admin | **No build step**: `php -d memory_limit=4096M <task>.php`. The row uses the **ZTS** build rather than the NTS one, because task 11 needs the PECL `parallel` extension and that extension only loads into a thread-safe PHP; `php_parallel-1.2.10-8.5-ts-vs17-x64.zip` from the Windows PECL builds goes into `ext/`, with `pthreadVC3.dll` beside `php.exe`, and `php.ini` must set **`extension_dir`** as well as `extension=parallel` — the build's compiled-in default is `C:\php\ext`, so a bare `extension=parallel` fails with `Unable to load dynamic library`. |
| PHP | zend + jit | as above | as above | Same interpreter, with `-d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M -d memory_limit=4096M`. **`-d opcache.jit=tracing` is required**: PHP 8.5 changed the master default of `opcache.jit` to `disable`, so `opcache.jit_buffer_size` alone leaves the JIT off (`opcache_get_status()` reports `jit.on=false`, `buffer_size=0`) and the row would measure only opcache bytecode caching. With the flag set the JIT is on and the effect is large — measured 4.2x on task 01, 6.0x on 09 and 12.3x on 11. |
| Python | cpython, pypy, graalpy |
| Lua | puc-lua, luajit |
| Perl | perl |
| R | gnu-r |
| Ruby | cruby-yjit |
| Julia | julia |
| Dart | jit |
| GDScript | godot --headless | 4.7.2 | godotengine.org, `Godot_v4.7.2-stable_win64.exe` — a single self-contained binary, no installer and no admin | **No build step**: `Godot_v4.7.2-stable_win64_console.exe --headless --script <task>.gd`, run from the directory holding the scripts and `project.godot`. **Use the `_console.exe` build**: the plain `.exe` is a GUI subsystem program whose output never reaches a pipe. Each script `extends SceneTree` and does its work in `_initialize()`. This is the slowest row in the matrix — the 100 M-iteration loops take tens of seconds each. |
| Tcl | tclsh |
| JavaScript | quickjs | 0.11.0 | github.com/quickjs-ng/quickjs releases, `qjs-windows-x86_64.exe` (1.7 MB), a single static binary — no installer and no admin. | **No build step**: `qjs.exe --std <task>.js`. **`--std` is load-bearing**: without it the `std` and `os` modules are not defined and `import * as std from 'std'` fails with `could not load module filename 'std'`. With it they are plain globals — `std.err.puts` writes to fd 2 and `std.out.puts` to fd 1. QuickJS-ng **has BigInt**, so task 10 uses `2n**100n`-style native arithmetic instead of hand-rolled limbs. Binary file I/O is `std.open(path,'rb')` plus `f.read(arraybuffer, offset, len)` — the count returned is the byte count, and NUL bytes survive, which is what task 14 needs. No threads: task 11 uses four child processes. |
| Clojure | clojure.main |
| Racket | racket (CS) |
| Common Lisp | sbcl |
| Elixir | elixir (BEAM) | 8 MB zip on OTP 29.1.1 | Elixir from github.com/elixir-lang/elixir releases — an 8 MB zip, no installer and no admin — on top of the **179 MB Erlang/OTP Windows `.zip`** from erlang.org. The OTP tree is installed for this row alone now that the two Erlang rows are gone, and it is still required: Elixir does not ship a runtime. | **No build step**: `tools/elixir/bin/elixir.bat <task>.exs`, run from the task directory with `tools/erlang/bin` first on `PATH` so the launcher finds `erl.exe`. Elixir compiles the script on every run, so that compile is inside the measured number. |
| Erlang | OTP (escript) | 29.1.1 | the same 179 MB OTP Windows `.zip` the `erlc` row installs — nothing extra | **No build step**: `tools/erlang/bin/escript.exe <task>.erl`. The script carries its own shebang and `main/1`, so `escript` compiles it to BEAM bytecode on **every run**, which is the whole point of this row beside `erlc`: the pair isolates when the compile happens. `%%! -smp enable` is in the file so all schedulers are live for task 11. |
| Erlang | erlc (compiled) | OTP 29.1.1 | the same 179 MB OTP Windows `.zip` the `erlang` row installs — nothing extra | Two steps: `tools/erlang/bin/erlc.exe <task>.erl` writes `<task>.beam`, then `tools/erlang/bin/erl.exe -noshell -s <task> main -s init stop`. The sources are `sources/erlang-compiled/`, module-form rewrites of the escript row's scripts: that row's files carry a shebang and no `-module` declaration, so `erlc` cannot compile them as they stand. The rewrite replaces the shebang and the `%%! -smp enable` emulator line with `-module`/`-export` and `main/0`, and drops `-smp enable` because SMP is on by default in OTP 29 (`erlang:system_info(smp_support)` is true). Algorithms are unchanged, and the compiled row is the one that separates compile time from run time: the escript row charges the per-run compile to every cell, this one pays it once at build time. Task 11 stays a real parallel pass, four workers on the SMP scheduler. |
| Scheme | chez |
| Prolog (SWI) | swipl |
| Pharo | Pharo 13 |
| Luau | luau |

**Pharo** runs a file headlessly with
`PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source <task>.st`,
where `--quit` and `--no-source` keep the image from being saved or the file from being
compiled into it. Give the image as an **absolute path or a path relative to the working
directory you actually run from**: Pharo writes its `.changes` log and a `PharoDebug.log`
into the process working directory, so invoking it from the repository root drops two
untracked files there that do not belong to the benchmark. Run from `sources/pharo/` (or any
scratch directory) and they land in `tools/pharo/` beside the image instead.
**Luau** is one toolchain over two runtimes: tasks 01–10, 12 and 13 are plain Luau under
`luau.exe`, while tasks 11, 14 and 15 need **Lute**, the Luau team's own runtime, because the
plain Luau CLI exposes no file I/O and no process API at all — its `os` is
`{clock, date, difftime, time}`, it has no `io`, no `os.execute` and no `package`, so `data.bin`,
`out.bin` and the four child processes of task 11 are unreachable under it. The registry
registers the one toolchain and each cell names the engine that ran it, because the two are not
the same backend and their numbers are not comparable: Lute enables Luau's native code generator
for the state it runs the script in (`Luau::CodeGen::create` in its `setupRunState`), which
compiles a function once it has been called enough times to be hot. So a task whose hot code is a
*called function* runs natively under Lute — task 03 measures **3.17 s under Lute against 9.35 s
under `luau.exe` and 7.66 s under `luau.exe --codegen`** — while a task whose whole cost is one
long loop in the main chunk is never compiled, because the chunk itself is entered once — task
02 measures **6.57 s under Lute against 8.11 s under `luau.exe` and 1.89 s under
`luau.exe --codegen`**. That is why the engine field reads `lute`, a `native-jit` backend, on
those three cells and `luau`, a `bytecode-vm`, on the other twelve.

Several of these need more than a run command.

**Tcl** needs the `Thread` package for task 11,
which is not in the core distribution. MSYS2's `mingw-w64-ucrt-x86_64-tcl` **does** bundle it —
`ucrt64/lib/thread2.8.13/thread2813.dll` plus its `pkgIndex.tcl`, so `package require Thread`
resolves with no extra install and the row runs on the same `ucrt64/bin/tclsh.exe` as every
other task. A Tcl from a source build without `--enable-threads` (or a distribution that omits
the extension) still needs a distribution that bundles it, such as Magicsplat's Windows
installer, or `tcltk/thread` built against the local Tcl. Task 03 also sources
`03_func_sum_add_one.tcl`.

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

**Elixir** installs without admin: an 8 MB zip that sits on top of the 179 MB Erlang OTP
Windows `.zip`, which the `erlang` and `erlang-compiled` rows install too — one OTP tree serves
all three BEAM rows. It has no build step: `elixir <task>.exs` compiles the file as it runs, so
that compile time is inside the measured number. It has arbitrary-precision integers built in,
so task 10 is a fast cell rather than a hand-rolled one, and it has real OS threads, so task 11
is a genuine pass.

The caveat is task 07: BEAM has an explicit optimisation for repeatedly appending the same
value, which turns the natural expression into an amortised O(1) in-place extend. Its
writable-binary optimisation does this for `<<Acc/binary, "x">>`, so the row runs **linear**, not
quadratic, and the cell measures the optimised append instead of the quadratic copy the task is
about. The row records this rather than forcing a copy, because forcing one would mean writing
the source artificially.

Elixir also needs a style note that the other rows do not. It has no
mutable variables and no loop syntax — there is no assignment statement — so every loop in that
row is tail recursion with explicit accumulators, which the compiler turns into a jump, plus
`case`/`cond` for the branches. The row deliberately avoids the functional style (no
`map`/`foldl`/comprehensions/higher-order functions in any timed path) and uses the language's own
escape hatches for state: the process dictionary, and `:atomics`, a real mutable array of 64-bit
integers. That is the most procedural register the language has; it cannot honestly be called
imperative and the row does not claim to be. The `erlang` and `erlang-compiled` rows need the
same note and carry it.

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
copies the whole string per append — and it is the row's slowest cell. Task 15 has
no fsync, since 10.0.2 exposes `flush_output/1` and `close/1` and nothing lower, so it is flush
plus close. Task 11 is real OS threads with no global interpreter lock, measured at 3.4x on
four workers, and it needs message queues rather than shared variables: `thread_create/3`
**copies** the goal, so each worker sends its partial with `thread_send_message/2` and the
parent collects four times before joining.



Note that four of these are JITs rather than plain interpreters, and the distinction matters
for the numbers: `luajit`, `php zend + jit`, `dart jit` and `julia` all
start out interpreting and compile hot code as they run, so their first seconds are slower
than their steady state. A short task therefore measures the warm-up, not the JIT.

`Python / graalpy` needs a full GraalVM install, which is a several-hundred-megabyte download
and the slowest thing on this page to set up.

## Toolchains that need something else first

| Toolchain | Also needs |
|---|---|
| graalvm native-image | a C toolchain, `zlib` headers, and several GB of RAM. On Windows, the MSVC linker (`link.exe`) on `PATH` plus `INCLUDE`/`LIB`. |
| kotlin/native | a JDK for the launcher. The 1.9-era launcher parsed `java -version` with `delims=-.` and broke on JDK 24, which prints `24` with no dot, leaving a stray quote in `if %_java_major_version% geq 24` — a batch syntax error rather than a clear message; the 2.4.20 prebuilt drives JDK 25.0.2 without trouble, so this is a launcher-version question, not a JDK ceiling. The first build also downloads its LLVM and libffi dependencies (about 1.4 GB) into `%USERPROFILE%\.konan`. |
| swiftc | the Swift toolchain ships its own LLVM, needs `libcurl` and `libxml2`. On Windows it needs the MSVC toolchain to link, and `-sdk` pointing at the bundled Windows SDK. The Windows distribution is a WiX burn bundle, so a plain `--layout` copy is not enough: a `get_swift.py` (not committed, see the `tools/` note below) decompiles it with WiX's `dark.exe`, reads the burn manifest to recover the real package names (the extracted files are `a0`, `a1`, ...), stages each MSI next to its `.cab`, and administrative-extracts them. |
| nuitka | in principle a C compiler, but in practice nothing on Python 3.13: Nuitka downloads its own zig-based backend and ignores a system MinGW. `--mingw64` is rejected on 3.13 and later. |
| cython | a C compiler, CPython's development files (`include/` and `libs/`), and the interpreter's `python3xx.dll` beside the built executable — CPython on Windows ships no static library. MinGW needs the three flags in the build line above, and one of them is a genuine trap: CPython's `pyconfig.h` defines `MS_WIN64` **inside `#ifdef _MSC_VER`**, so under MinGW `SIZEOF_VOID_P` stays 4 while `sizeof(void*)` is 8, and Cython's own consistency check fails to compile with `enumerator value for '__pyx_check_sizeof_voidp' is not an integer constant`. |
| gdscript | a Godot build, run with `--headless` |
| lua, for task 11 only | the Lanes C extension, built by `exec/lua/build_lanes.bat`. Needs a MinGW `gcc` on `PATH` — `C:\mingw64\bin\gcc.exe` builds it in about 20 s per flavour. Stock Lua has no threads. **LuaLanes publishes no prebuilt Windows binaries** — every release is source only — so this is a hand build, not the `luarocks install lanes` the LuaRocks route would give you, and the Windows Lua install this row uses (`lua.org` 5.4.8 binaries) ships no `luarocks.exe` to do it with anyway. Two flavours are required because the row has two interpreters on different ABIs: `lanes.dll` built against Lua 5.4.8 headers into `tools/lua-rocks/lib/lua/5.4/` for `puc-lua`, and one built against **LuaJIT's own headers** into `.../lib/lua/5.1/` for `luajit`, with `lanes.lua` in each matching `share/lua/<ver>/`. They are not interchangeable: lanes refuses across ABIs in both directions, and a DLL built against plain PUC 5.1 headers loads under LuaJIT only to die on every call with *"Lanes is built for PUC-Lua, don't run from LuaJIT"* — lanes' `compat.h` takes its LuaJIT branch only when `LUA_JITLIBNAME` is defined, which comes from LuaJIT's build-generated `luajit.h`, so the script writes a three-line shim that defines it. The rock lands **outside** the interpreter trees, so `LUA_PATH`/`LUA_CPATH` must point at it or `require("lanes")` fails with `module 'lanes' not found`; the row's registry entries and `exec/lua/verify.py` both set them per interpreter. |
| clang, clang++ (Windows) | the LLVM Windows tarball ships no C headers. Either add a MinGW sysroot (`--target=x86_64-w64-windows-gnu -isystem <mingw>/include`) or install the MSVC SDK. |
| scala | a modern `JAVA_HOME`. A Java 8 shim earlier on `PATH` (Oracle's `java8path`) makes `scalac` die with `UnsupportedClassVersionError` on class file 61.0. |
| scala/native | a C toolchain that Scala Native can drive. On Windows the documented route is LLVM/clang 16+ plus Visual Studio's C++ workload (the "C++ Clang tools for Windows" package does not work); without admin the portable llvm-mingw zip is the route, and it needs the two flags in the build line above. `--native-compile=-D_PID_T_` suppresses mingw's own `pid_t` typedef through its `#ifndef _PID_T_` guard, because Scala Native's `gc/shared/ThreadUtil.h` does `typedef int pid_t` under `#ifdef _WIN32` and clang rejects the redefinition; without it every build fails. `--native-linking=-static` is needed because Scala Native forces C++ exceptions on Windows, so a default link produces an executable importing `libc++.dll` from the llvm-mingw tree and only runs with that directory on the DLL search path. The mingw codegen path ships in the released compiler (`scala/scalanative/codegen/llvm/compat/os/WindowsGnuCompat.class` beside `WindowsCompat.class`), but upstream CI does not cover it, so it can break on a Scala Native upgrade. |
| C# nativeaot | the MSVC linker. With a hand-extracted MSVC tree, `dotnet publish` cannot find `vcvarsall` and reports `Platform linker not found`; pass `-p:IlcUseEnvironmentalTools=true` so it uses `PATH`/`INCLUDE`/`LIB` instead. |
| java/graalvm native-image | the MSVC toolchain, and there is **no `IlcUseEnvironmentalTools` equivalent**: native-image looks for `vswhere.exe` under `%ProgramFiles(x86)%\Microsoft Visual Studio\Installer` and then runs the `VC\Auxiliary\Build\vcvarsall.bat` that the tool reports, taking the environment delta as its build environment. A hand-extracted tree therefore needs a `vswhere.exe` that prints the tree's VS root and a `vcvarsall.bat` under it that sets `PATH`/`INCLUDE`/`LIB`; **`-H:-CheckToolchain` does not skip the lookup**, it only defers the `cl.exe` check. Three things bite after that: `cl.exe` needs the `1033\clui.dll` resources copied beside it or it dies with `C1510`, the linker needs `lib\x64\setargv.obj`, which ships in the **Store** CRT package rather than the Desktop one, and `OLDNAMES.lib` no longer ships at all — build an empty one with `lib.exe /OUT:OLDNAMES.lib <any>.obj`. |
| nim | a C compiler on `PATH` for the C backend. **The module name rule bites**: Nim rejects a source file whose name is not a valid identifier, so `_01_branches.nim` stops with `Error: invalid module name: '_01_branches'; a module name must be a valid Nim identifier` and the file has to be copied to a name such as `t01_branches.nim` first. Nim 2.x enables thread support by default, so task 11's `std/typedthreads` needs no extra flag. |
| masm | nothing extra: `ml64.exe` and `link.exe` come from the same hand-extracted MSVC tree the `msvc` row installs, driven through `tools/msvc_env.py` so `INCLUDE`/`LIB` resolve. The link line is `link /subsystem:console /entry:main /out:<task>.exe <task>.obj kernel32.lib` — `kernel32.lib` is the only import library the row needs, because the programs are freestanding PE64 with no C runtime. |
| adw (Modula-2) | nothing beyond the unpacked tree, but the compiler is fussier than ISO Modula-2 in three ways. **`TYPE (expr)` conversion is not accepted** — `LONGCARD (dt.hour)` fails with `error: { expected`, and only `VAL (LONGCARD, dt.hour)` compiles; `VAL` is what ADW's own library sources use. **`ADR` is not exported by default** — a module that passes a buffer to `IOChan.RawWrite` must name it in the `FROM SYSTEM IMPORT` list, or the call is `Undeclared symbol`. **A procedure heading that precedes other procedures must carry its own body**, not just a forward declaration: `PROCEDURE fib (n : CARDINAL) : LONGCARD;` followed by a nested `PROCEDURE` and then a bare `BEGIN … END fib;` fails with `Undeclared symbol` or a parser error on the declaration, because ADW reads the heading plus the next `BEGIN` as one unit. The heading has to be repeated immediately before its body. |
| fpc (Windows x64) | the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, since there is no native x64 compiler. |
| odin (Windows) | `WindowsSdkDir`, `WindowsSDKVersion` and `VCToolsInstallDir` in the environment. Odin does not discover the SDK on its own; without them it fails with `Windows SDK not found`. |
| valac | a C compiler and GLib's development files. On Windows both come from MSYS2 `ucrt64` (`mingw-w64-ucrt-x86_64-vala`, which pulls in the GLib/GObject/GTK dependency chain and about 2.2 GB of tree). `valac` has to run inside that shell so `pkg-config` resolves. |
| cim | a C compiler and Cygwin. The compiler and runtime are built once under Cygwin, and `cim.exe` then drives the system `gcc` on every build, so `C:\cygwin64\bin` must be on `PATH` when it runs. |
| beef (Windows) | a `shell32.lib` from outside the distribution. `bin/lib/x64` ships eleven import libraries and the Release link line asks for `shell32.lib` anyway, so the link stops with `lld-link: error: could not open 'shell32.lib'`; any Windows SDK copy works, as does a MinGW import library renamed to it. `BeefConfig.toml` also has to be copied from the installer's `__user/bin/` into `bin/`, or BeefBuild stops with `ERROR: Unable to load project 'corlib'` — its `UnversionedLibDirs` is resolved against the config file's own directory. |
| haxe | Neko for `haxelib`, and the hxcpp backend. `haxelib.exe` ships without `neko.dll` and dies with `error while loading shared libraries: neko.dll`, and copying just that DLL is not enough — Neko then wants `gcmt-dll.dll`, `std.ndll`, `regexp.ndll` and the MSVC runtime, so the whole official `neko-2.4.1-win64.zip` is unpacked, put on `PATH` and named by `NEKOPATH`. `haxelib install hxcpp` is unusable where `lib.haxe.org` answers HTTP 403, so `hxcpp-4.3.171.zip` is unpacked and registered with `haxelib dev hxcpp <dir>` — dropping the tree in as a *version* fails, because haxelib parses the directory name as a version and rejects a three-part one. hxcpp 4.3.171 then does not compile with MinGW's libstdc++ as shipped: `src/hx/gc/GcCommon.cpp` calls `std::sscanf` without including `<cstdio>`, which MSVC pulls in transitively and libstdc++ does not, so one `#include <cstdio>` line has to be added to the installed copy. hxcpp also needs its own tool built once — `haxe compile.hxml` run from `tools/hxcpp/hxcpp-4.3.171/tools/hxcpp/`, which leaves `hxcpp.n` at the tree root; without it the first `haxe -cpp` stops at `Can't continue without hxcpp.n` after prompting to build it. Every build line also carries `-D mingw -D MINGW_ROOT=<the directory holding bin/g++.exe>`, because hxcpp guesses `c:/MinGW` and otherwise stops with `Could not guess MINGW_ROOT`. |
| chez | a MinGW gcc and GNU Make, because there is no no-admin Windows binary to unpack. The build runs from the MSYS2 UCRT64 shell with `mingw-w64-ucrt-x86_64-gcc` (plus `pacman -S make`) and bootstraps from the bytecode boot files in `boot/pb`, so no existing Chez is needed; zlib has to be built once **serially** in each workarea first, because under `make -j8` both `pb/zlib` and `ta6nt/zlib` die with `collect2.exe: error: ld returned 32 exit status` and `libz.a` is missing at link time. `make install` does not work either — `makefiles/installsh` is a `/bin/sh` script that `zuo` hands to `cmd.exe` — so the four installed files are placed by hand. |
| poly/ml | a C compiler **and three files the MSI does not ship**, all built once from the matching source tarball (`polyml-5.9.1.tar.gz`). The MSI's complete payload is `PolyML.exe`, `PolyLib.dll` and `PolyPerf.dll` — no `polyc`, no `poly` launcher, no import library, no `libpolymain` — so the row builds them: `gcc -c -O2 -o polystub.obj src/polystub.c` (with `winconfig.h` and `polyexports.h` beside it, which `polystub.c` includes) for the `WinMain` start-up stub, and `gendef PolyLib.dll && dlltool -d PolyLib.def -l libpolyml.a -D PolyLib.dll` for the link library (247 exports). `polyc` is a shell script and there is no `sh` in the MSI, which is why the two steps it performs are driven by hand. MinGW gcc is enough; MSVC is not needed. |

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
- **Haxe's Lua target needs `luv`, which will not build here.** The emitted Lua calls
  `require("luv")` at load time — Haxe's Lua `sys` implementation is written on top of the
  libuv bindings — so every cell of that target dies with `no file '.\luv.dll'` before it
  reaches the task. `luarocks --tree tools/lua-rocks install luv` fetches luv 1.52.1 and then
  fails building its bundled libuv with MinGW gcc (`uv__free` takes `void *` where the caller
  passes `const char *`, and the rock builds with warnings as errors). There is no prebuilt
  Windows `luv.dll` for Lua 5.4 in the luv releases, so the `haxe (lua)` toolchain is **not
  registered** rather than registered-and-failing.
- **The Haxe row's php, python and neko targets were dropped on 2026-10-10.** Each passed the
  other fourteen tasks, but task 10 is out of reach on all three: Haxe's `Int` is 32-bit on
  php, python and neko, so `haxe.Int64` is emulated as pairs of 32-bit halves and the
  2000-digit spigot's base-1e9 limbs cost a VM dispatch each. Measured, one run each: **2772 s
  (46 min) under php** and **6212 s (104 min) under neko**; python was abandoned unfinished
  past two hours. For scale, the same cell is **1.0 s under hxcpp** and 2.8 s on the JVM, and
  the slowest cell the matrix keeps is COBOL task 09 at 615 s. php task 06 fails in kind rather
  than degree: Haxe's `Bytes.blit` lowers to `substr` + concatenate there, so filling the 100 MB
  buffer is quadratic — measured at 0.51 s per 10-byte block *into* the 100 MB buffer, about
  eight days for the cell's ten million blocks. Neko was the only front end on the Neko backend,
  so that backend left the matrix with it (64 backends now). The row keeps hxcpp, js, jvm, cs
  and hashlink; `exec/haxe/build_targets.bat` builds the js, jvm and cs artifacts.
- **`mono --llvm` does not exist on Windows.** The official `mono.msi` is built without LLVM,
  so the flag is inert and the AOT driver refuses outright:

  ```
  $ mono --llvm 01_branches.exe
  Mono Warning: --llvm not enabled in this runtime.          <- runs on the ordinary JIT
  $ mono --aot=llvm 01_branches.exe
  --aot=llvm requires a runtime compiled with llvm support.
  AOT of image 01_branches.exe failed.
  ```

  `mono --version` reports `LLVM: supported, not enabled.` — the loader knows the option, the
  build has nothing behind it — and no file in the 168 MB extracted tree is named `llvm`.
  Enabling it means building Mono from source on Windows with `--enable-llvm`, which needs
  Cygwin and Visual Studio and is a multi-hour build; upstream's own docs note that "most
  packages" ship without it. The C# row therefore has no LLVM JIT cell, and its second Mono
  cell is `mono (aot)` instead — `--aot=full`, which does work and gives the row the same
  JIT/AOT pair the matrix draws for `dart` (`jit`/`aot`) and `java` (GraalVM JIT /
  `native-image`). A third C# JIT would also have had nothing to pair against: Mono's LLVM
  backend is an alternative code generator inside the same runtime, not a second runtime.
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
  or it does not build at all, and they are all in the same class as the gccgo entry below:
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
- **gccgo has no Windows build and cannot be given one.** The GCC 16.1.0 tree this repository
  uses is configured `--enable-languages=c,c++,fortran,lto,objc,obj-c++` and answers
  `gcc -x go` with `language go not recognized`; it ships no `libgo`. Neither MSYS2 nor Cygwin
  packages a `gcc-go`, and WinLibs, the standalone Windows GCC, builds C, C++, Objective-C,
  Fortran and D only. Building it is not an option either: `libgo/configure.ac` assigns a
  `GOOS` only for darwin, freebsd, irix6, linux, netbsd, openbsd, dragonfly, rtems, solaris2,
  aix and gnu, so a mingw host dies at `could not determine GOOS from ${host}` before anything
  compiles, and the runtime has no Windows implementation to link against — `libgo/runtime` has
  no Windows file at all. GCC's own `configure.ac` says the same thing in one line — the
  front end is disabled for these targets outright, from the commit that added it (Ian Lance
  Taylor, 2014):

  ```
  # Disable the go frontend on systems where it is known to not work.
  case "${target}" in
  *-*-darwin* | *-*-cygwin* | *-*-mingw* | *-*-aix*)
      unsupported_languages="$unsupported_languages go"
  ```

  `README.md` carries the full evidence under "Languages that are not here, and why". Go is
  represented by the `gc` and `go-wasm` rows instead.

## Reference implementations

Task 14 and task 15 use a 50 MiB fixture, and every expected output in this benchmark was
computed independently. Keeping those reproducible needs:

- a C compiler, for the reference implementations
- Python 3.10 or newer, for the fixture generator

Both are already covered above. The fixture itself **is** committed, as `data.bin` in the
repository root, so a fresh clone can run tasks 14 and 15 without generating anything:
52428800 bytes, 204800 copies of the byte cycle 0..255, which is the whole specification.
The reference implementations are not committed, but nothing depends on them — every expected
output is written down in `README.md`.

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
