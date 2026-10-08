# Build requirements

What has to be installed to turn each task's source into something runnable.
For what has to be installed to *run* the result, see `RUN.md`.

Convention below: `<task>` is the task's own name, so the source for task 01 in C is
`sources/c/01_branches.c`, and the output is `prog`. Add the thread flag where a language
needs one, because task 11 uses four threads.

Fourteen things do not follow the flat `<task>.<ext>` layout, and each says why. A toolchain
that needs a directory of its own rather than a differently named file is a separate case and is
described after the list:

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
- **Scheme, Prolog (SWI), Janet, Ring, JScript, AutoHotkey and Seed7 task 03** each keep the
  helper in a second file beside the task — `03_func_sum_add_one.ss`, `.pl`, `.janet`, `.ring`,
  `.js`, `.ahk` and `.s7i` — which is the same shape as the Fortran, Tcl, Vala and
  Oberon-07 entries above, so it is one case here and not seven. Two of the seven are shape
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
- **Unicon task 03** is two files, `03_func_sum.icn` and `03_func_sum_add_one.icn`, and both are
  named on the command line; the icode file takes its name from the first. The split is the
  row's cross-file convention rather than a way to defeat an inliner — Unicon compiles to icode
  for a virtual machine, so a procedure call is a real VM call that nothing can fold away.
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

Most toolchain rows share their language's main source directory — `sources/c/` is built by
`gcc`, `clang`, `msvc` and `tcc`, `sources/d/` by `dmd`, `ldc2` and `gdc`, and so on. A row
whose source cannot be shared gets a directory of its own, holding **all fifteen tasks** and
duplicating the files it has in common with the main row. Twenty rows are in that position:

| Row | Directory | What differs from the main row |
|---|---|---|
| Kotlin native | `sources/kotlin-native/` | tasks 11, 14, 15: the stdlib `Worker` and `kotlinx.io` replace `java.lang.Thread` and `java.io` |
| Java openj9 | `sources/java-openj9/` | nothing — same fifteen files, a different VM executes them |
| Java graalvm jit | `sources/java-graalvm-jit/` | nothing — same fifteen files, GraalVM's JIT compiles them |
| Java graalvm native-image | `sources/java-graalvm-native/` | nothing — same fifteen files, compiled ahead of time |
| Java loom | `sources/java-loom/` | task 11: `Thread.ofVirtual()` replaces `new Thread(...)` |
| Scala native | `sources/scala-native/` | nothing — same fifteen files, built to LLVM IR by Scala Native |
| Common Lisp ecl | `sources/commonlisp-ecl/` | the bodies, not just the header: ECL is a different implementation, so the declarations are `fixnum` where SBCL's are `(signed-byte 64)`, the case clauses end in `t` where SBCL's end in `otherwise`, tasks 11 and 14 use ECL's own thread and stream forms, and task 03 uses `(declaim (notinline add-one))` instead of the separate `03_func_sum_add_one.lisp` the SBCL row needs |
| Erlang compiled | `sources/erlang-compiled/` | the module form: `-module`/`-export` and `main/0` replace the escript row's shebang and `main/1`, because `erlc` cannot compile a script that has no module declaration |
| Go tinygo | `sources/tinygo/` | task 15: flushes by closing, because TinyGo's Windows target implements no fsync |
| Python cython | `sources/python-cython/` | nothing — same fifteen files, `cython --embed` compiles them |
| Python wasip1 | `sources/python-wasm/` | nothing — same fifteen files, run by the WASI build of CPython |
| Ruby wasip1 | `sources/ruby-wasm/` | task 11: Fibers, because CRuby's wasip1 build is `THREAD_MODEL=none` |
| Lua wasip1 | `sources/lua-wasm/` | task 11: coroutines, because Lanes has no wasm build |
| C wasm32-wasip1 | `sources/c-wasm/` | nothing — the same sources build for both targets |
| C++ wasm32-wasip1 | `sources/cpp-wasm/` | nothing |
| Rust wasm32-wasip1 | `sources/rust-wasm/` | nothing |
| Go wasip1 | `sources/go-wasm/` | nothing |
| Assembly masm | `sources/masm/` | the whole source: the same fifteen tasks in MASM syntax, because the two assembly rows differ in assembler and the syntax is the toolchain |
| TinyGo wasip1 | `sources/tinygo-wasm/` | task 15: keeps the real `f.Sync()`, which wasip1 implements and TinyGo's Windows target stubs out; the rest is the same TinyGo-compatible Go |
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

- **Processor-time clocks** — `a68g`, `ring` and `mercury` read CPU time (`clock()`,
  `time.clock`) rather than elapsed time. All three are single-threaded interpreters, so CPU
  time and elapsed time are the same quantity there.
- **Time-of-day clocks** — readings of the system clock, which a time sync can move:
  `unicon` (`&time`, ms since midnight), `vbscript` (`Timer()`, seconds since midnight),
  `freebasic` (same), `cobol` (`ACCEPT ... FROM TIME`, `hhmmsscc`), `eiffel` (`TIME.make_now`
  plus its millisecond fields), `modula3` (`Time.Now`, seconds since the epoch as a REAL),
  `hashlink` (`Sys.time()`), `sqlite` (`julianday('now')`), `duckdb` (`epoch_ms(now())`),
  `haskell` (`getPOSIXTime`), `ocaml` (`Unix.gettimeofday`), `swift` (`Date()`),
  `seed7` (`GET_TIME (TIM_NOW)`, local time of day) and `jscript` (`new Date().getTime()`,
  the Windows system timer).
- **VM-relative counters** — `dyalog` (`3⊃⎕AI`, the session's elapsed-time counter), `dolphin`
  (the VM's millisecond clock) and `actionscript` (`getTimer()`, ms since the VM started).
  These do not move with the system clock, but they are not monotonic clocks either.

**Coarse clocks.** Six rows cannot resolve better than the work they bracket: `vbscript`
(16 ms, centiseconds), `cobol` (10 ms), `autohotkey` and `jscript` (15 ms — both read
`GetTickCount`/the Windows system timer), `modula2` (whole seconds plus
`SysClock.fractions`) and `modula3` (whole seconds as a REAL). Their cells are read with that
granularity in mind;
`RUN.md` says so again where the row is discussed. `freebasic` reads the same
seconds-since-midnight value as `vbscript` but as a Double, so it is not in this group, and
neither is `oberon07`, which declares `GetSystemTimePreciseAsFileTime` from `kernel32.dll`
itself at 100 ns.

**The `time.txt` fallback.** A row whose language exposes no standard-error stream writes the
same line to a file `time.txt` in the working directory instead, exactly as `RUN.md` describes:
`actionscript`, `dolphin`, `dyalog`, `euphoria`, `lobster`, `luau`, `modula2`, `modula3`,
`ring`, `scheme` and `terra`. For `terra` this is the documented alternative to importing
C's `stderr`, which `terralib.includec` does not expose; for `euphoria` both `printf(2, …)`
and `puts(2, …)` write nothing when stderr is redirected.

**No row is inspection-only any more.** Ten rows — `ats`, `basic`, `cobol`, `dolphin`, `dyalog`,
`eiffel`, `modula2`, `ring`, `seed7` and `swift` — were instrumented by inspection, because their
toolchains were absent at the time, and the same was true of the J row (`j9.7`), `beef`, `swipl`
and `sqlite`. All fourteen toolchains are installed on this machine now, and every one of those
rows has been verified end to end (15/15 each). This is a statement about this machine, not about
the rows.

Every row also has a **row verifier** at `exec/<row>/verify.py` that runs the fifteen tasks and
checks the answer, the timing line and task 15's file — the convention is described in
`RUN.md`'s Measurement tooling section. The seven rows that had none (`actionscript`, `ada`,
`algol68`, `arc`, `assembly`, `assemblyscript`, `autohotkey`) have one now, so no row is checked
by hand.

## Host

Builds assume **x86-64**, on Linux, macOS or Windows. `msvc`, `jscript` and `autohotkey` are
the Windows-only toolchains — the last two because `cscript.exe` and the AutoHotkey interpreter
are Windows components and there is no other platform's build of them — and the two `assembly`
rows are Windows x64 only: each is a freestanding PE program built with `nasm -f win64` or
`ml64.exe` and linked with `link.exe` against `kernel32.dll`. Every other row builds on Windows
too, including `flang` and `luajit`. See `RUN.md` for the full platform breakdown.

Disk: **31 GB measured** for all 96 toolchains, installed and run on one Windows x64 host, and
about **44 GB for the 141** rows the tables below now list.
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
The fourteen newest rows add about 3.3 GB, and most of it is **Eiffel at 1.14 GB**, extracted from a 139 MB `.7z` with a
further 32 MB per target of `EIFGENs` once built. The rest are moderate or small —
Beef 845 MB, the Scala Native pair (scala-cli 131 MB plus the portable llvm-mingw 675 MB, and
27 MB of Scala Native artifacts in the package cache), the SWI-Prolog tree 133 MB, Haxe with
Neko and hxcpp 112 MB, the Seed7 tree 65 MB (from a 47 MB source tree, once its
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
The four newest rows add about **1.3 GB**, and one term is all of it: **TinyGo at 1.3 GB**,
unpacked from a 178 MB zip, because the compiler ships a whole LLVM 22.1 tree inside it.
**Cython** is a 15 MB `pip install`. **GraalVM JIT** and **Loom** add nothing at all — the first
is the same GraalVM JDK the `graalpy` and `graalvm native-image` rows already install (measured
here: 771 MB extracted), and the second is the JDK the `openjdk` row already has. The Go SDK
(264 MB, measured) is needed by `tinygo` as well as by the `gc` row, so it is counted once.
The newest batch adds about **0.3 GB**: the two hardware-description rows are gone, and in
their place come **OpenJ9 at 388 MB** — the IBM Semeru JDK zip, extracted, with its own `javac`
and `java` — and **MASM**, which installs nothing, because `ml64.exe` and `link.exe` come from
the MSVC tree the `msvc` row already has. The `nasm` row's Windows build likewise reuses the
assembler already on the host. **Unicon** adds 84 MB, unpacked from a 15 MB installer, and the four rows after it add about **4.4 GB**, almost all of it one term: **GHC at 4.1 GB**, extracted from a 452 MB `.tar.xz`, because the bindist carries a complete MinGW toolchain and the libraries for every package that ships with it. **gforth** is about 100 MB, **Lobster** about 30 MB and **Mercury** about 200 MB installed from a source build.
That puts the current total at about **41 GB for all 137 toolchains**.
The three interpreted WebAssembly rows add about **0.14 GB** on top of the six that already
existed: the single-file `ruby.wasm` is 99 MB, the Lua build reuses the `wasi-sdk` tree the C
row already installs and adds only a 716 KB `lua.wasm`, and the CPython WASI build is a 28 MB
`python.wasm` with an 11 MB stdlib tree beside it.
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

**Why it matters.** The self-timing contract in `RUN.md` starts the clock at the first statement
of the program's own body. A row that compiles ahead of time has already finished parsing, type
checking, optimising and generating code by then. A row that compiles on every run has not, and
that work lands either inside the measured number or just before it, depending on where the
compiler puts it. The two Erlang rows are the cleanest illustration in the matrix: `escript`
compiles the script on every run and `erlc` compiles it once, and the only difference between
the two cells is when the compile happens. The same split runs through the whole table, so a row
is only comparable with another row of the same shape.

Six shapes appear below. Each entry names the stages the toolchain actually runs.

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
| `d` (dmd) | direct to object with its own backend; (ldc2) LLVM IR; (gdc) the GCC pipeline |
| `swift` | parse → SIL → LLVM IR → object → link |
| `fortran` (gfortran) | the GCC pipeline; (flang) LLVM IR |
| `ada` | the GCC pipeline (`gnatmake` drives `gcc`) |
| `pascal` | `fpc` direct to object, its own backend |
| `crystal` | type inference → LLVM IR → object → link |
| `odin` | LLVM IR → object → link |
| `c3` | LLVM IR → object → link |
| `beef` | LLVM IR → object → link |
| `objectivec` | clang: preprocess → compile → assemble → link |
| `haskell` | parse → Core → STG → Cmm → native code (its own code generator) |
| `ocaml` (`ocamlopt`) | typed lambda → Cmm → assembly → assemble → link |
| `pony` | type check → LLVM IR → object → link |
| `scala-native` | scalac → NIR → LLVM IR → clang → link |
| `standardml` | Poly/ML compiles to native code with its own code generator, then gcc links its `.obj` with `polystub.obj` |
| `modula2`, `modula3`, `oberon07`, `componentpascal` | small self-contained compilers, direct to object |
| `basic` | `fbc` builds the executable in one command, `fbc -O 2 -x prog.exe <task>.bas` — no separate link step in the row's build line |
| `assembly` (nasm, masm, fasm) | assemble to object → link; see shape 5 |

### 2. Source to C or C++, then the C compiler

The toolchain translates the language to C or C++, then hands that to a C compiler. Two
compilers are involved, and the C compiler is usually the one doing the optimisation, which is
why several of these rows need an explicit flag to pass optimisation through.

| Rows | Stages |
|---|---|
| `vala` | valac → C → gcc (`-X -O2` is what forwards `-O2`) |
| `nim` | nim → C → gcc or clang |
| `nelua` | nelua → C → gcc |
| `lean4` | `lean -c` → C → `leanc` (Lean's own clang) |
| `haxe` (hxcpp) | Haxe → C++ → hxcpp → g++ |
| `qb64` | QB64 → C++ → the C++ compiler shipped inside the QB64 tree |
| `commonlisp` (ecl) | ECL → C → cl.exe (pointed at the MSVC tree by `c::*cc*`) |
| `seed7` | `s7c` → C → gcc |
| `mercury` | `mmc` → C → gcc |
| `ats` | `patscc` → C → gcc |
| `v` | V → C → gcc (`-cc gcc` names the backend) |
| `python` (cython) | Cython → C → gcc, with CPython's headers |
| `python` (nuitka) | Nuitka → C → the C compiler, plus the CPython runtime it links in |
| `cobol` | `cobc -x` generates C, then the C compiler builds it |
| `eiffel` | `ec -finalize -c_compile` translates Eiffel to C, then compiles the C |
| `euphoria` | interpreted; no translation step (see shape 6) |

### 3. Source to bytecode, then a virtual machine

The front end emits bytecode for a VM that is not the CPU. The VM may then interpret that
bytecode, JIT it, or both — so the row's number depends on the VM's strategy as much as on the
language. Where a row has several VMs, that is the point of the row.

| Rows | Stages |
|---|---|
| `java` (openjdk, openj9, loom) | javac → `.class` → HotSpot C2 or OpenJ9 JIT at run time |
| `java` (graalvm jit) | javac → `.class` → GraalVM's JIT |
| `java` (graalvm native-image) | javac → `.class` → ahead-of-time native image |
| `kotlin` | kotlinc → JVM bytecode (jvm row) or native (native row) |
| `csharp` | Roslyn → IL → CoreCLR JIT, NativeAOT, or Mono |
| `fsharp`, `vbnet`, `boo` | their compiler → IL → the same runtime |
| `scala` | scalac → JVM bytecode |
| `clojure` | clojure.main → JVM bytecode on every run |
| `groovy` | Groovy → JVM bytecode |
| `jython` | Jython → Java bytecode (Python 2 source) |
| `ironpython` | IronPython → IL |
| `erlang` (escript) | escript → BEAM bytecode on every run |
| `erlang-compiled` (erlc) | erlc → `.beam` once, then the BEAM runs it |
| `elixir` | Elixir → BEAM bytecode |
| `gleam` | `gleam build` → BEAM |
| `hashlink` | Haxe → `.hl` bytecode → the HashLink VM |
| `unicon` | icont → icode, appended to a self-contained `.exe` |
| `janet` | Janet → bytecode on every run |
| `lobster` | Lobster → bytecode, then run |
| `dart` (jit) | Dart → kernel bytecode; (aot) ahead-of-time native |
| `php` | Zend compiles to opcodes; the `+ jit` row then JITs them |
| `lua`, `lua-wasm` | PUC Lua compiles to its own bytecode, then a register VM runs it |
| `luau` | Luau → bytecode, then its VM; the `lute` row runs the same files on the Lute runtime |
| `ruby` | CRuby → ISeq bytecode; the `+ yjit` row JITs it; JRuby → JVM bytecode |
| `python` (cpython, pypy, graalpy) | CPython → bytecode; PyPy JITs; GraalPy runs on GraalVM |
| `raku` | Rakudo → MoarVM bytecode |
| `ring` | Ring → bytecode |
| `quickjs` | QuickJS compiles to bytecode, then its own VM |
| `r` | R's byte-code compiler, on by default; the `no JIT` row turns it off |
| `racket` | Racket compiles the module on every run |
| `factor` | Factor compiles the script and runs it on every invocation |
| `scheme` | Chez compiles the script on every run |
| `pharo`, `dolphin` | a prebuilt image, compiled ahead of time by someone else |
| `componentpascal` (gpcp) | → .NET IL |
| `actionscript` | `amxmlc` compiles AS3 to SWF bytecode, then `adt` packages it into a standalone exe with the captive AIR runtime beside it |

### 4. Source to WebAssembly, then a runtime

The compiler targets wasm32 and the module is executed by `wasmtime`, which is a JIT for wasm.
The measured number therefore includes the runtime's own translation of the module.

| Rows | Stages |
|---|---|
| `c-wasm`, `cpp-wasm` | wasi-sdk clang → wasm object → wasm-ld |
| `rust-wasm` | rustc with the `wasm32-wasip1` target |
| `go-wasm` | `GOOS=wasip1 GOARCH=wasm` |
| `zig-wasm` | `zig build-exe -target wasm32-wasi` |
| `tinygo-wasm` | TinyGo → LLVM IR → wasm, then `wasm-opt` |
| `assemblyscript` | `asc` → wasm directly |
| `wasm` | hand-written WAT; `wasmtime` parses the text form itself |
| `python-wasm`, `ruby-wasm`, `lua-wasm` | the interpreter is itself compiled to wasm, and the source file is data |

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
| `perl`, `tcl`, `vbscript`, `jscript`, `autohotkey` | parse and execute on each run |
| `euphoria` | a tree-walking interpreter; no bytecode file |
| `babashka` | babashka runs Clojure on SCI, an interpreter, inside a GraalVM native image |
| `j`, `dyalog` | APL interpreters |
| `swipl` | SWI-Prolog compiles to its own clause representation in memory |
| `sqlite`, `duckdb` | SQL is parsed and planned per statement; there is no program |
| `algol68` | `a68g` is a compiler-interpreter: it parses and executes with no build step |
| `gforth` | gforth interprets the file; the accumulator lives on the data stack |
| `gdscript` | Godot parses and runs the script |
| `arc` | Arc is interpreted on Racket, which loads the host on every run |
| `terra` | the source is compiled at run time, in-process, by the JIT it embeds |

### 7. Compiled at run time

These rows do compile — to machine code — but they do it while the program is running, so the
compile is inside the measured cell by construction. Julia is the clearest case, and it is also
the reason the matrix has a second Julia row: `--compile=min -O0` turns this off, and the pair
exists to show what it costs.

| Rows | Stages |
|---|---|
| `julia` | parse → typed IR → LLVM IR → machine code, per method, on first call |
| `julia` (interpreted) | the same pipeline with code generation disabled |
| `terra` | LuaJIT's compiler, driven from the script |
| `lua` (luajit) | trace compilation |
| `python` (pypy) | trace compilation |
| `php` (`+ jit`) | opcode JIT |
| `ruby` (`+ yjit`) | method JIT |
| `javascript` (node, bun, deno, spidermonkey, quickjs) | tiered JIT, except QuickJS which is bytecode only |
| `csharp` (coreclr), `java` (openjdk, openj9, loom, graalvm jit), `fsharp`, `vbnet`, `scala`, `clojure`, `groovy` | the VM JITs on first execution |

### What this means for reading a row

Three consequences are worth stating, because they are easy to get wrong:

- **A compiled row and an interpreted row are not the same measurement.** The first excludes the
  compile entirely; the second includes it, or includes the interpreter's per-statement
  dispatch. Comparing them across shapes says something about the toolchain, not about the
  language.
- **A JIT row's number depends on how long it ran.** A trace or method that compiles on first
  call needs enough iterations to pay for itself, which is why the loop counts are in the
  hundreds of millions and why a task's count is never lowered.
- **A row with two toolchains is usually a pipeline comparison.** `escript` against `erlc`,
  `julia` against `julia --compile=min`, `ocamlopt` against `ocamlc`,
  `gnu-r` against `gnu-r (no JIT)`, and the native/wasm pairs all exist to hold the language
  fixed and move one stage of the pipeline.

## Toolchains

### Compiled to native code — nothing needed at run time

The output is a native executable in every row below, and for most of them that executable needs
nothing but the operating system. Four rows are exceptions and say so in their own entry: Vala's
binary imports `libglib-2.0-0.dll` whenever the code touches GLib, COBOL's imports `libcob-4.dll`,
Cython's imports `python3xx.dll` because CPython on Windows ships no static library to link
against, and Standard ML's needs `PolyLib.dll` beside it — in that last case the exported `.obj`
is a whole heap image and the DLL is the runtime that loads it, so the pair has to travel
together.

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
| Go | tinygo | 0.42 | tinygo.org, `tinygo0.42.0.windows-amd64.zip` (178 MB) extracted into `tools/tinygo/` — no installer, no admin | `tinygo build -o prog.exe <task>.go`, run from `sources/tinygo/`, which holds all fifteen tasks. TinyGo bundles its own LLVM 22.1 and emits a standalone executable, but it still **shells out to `go`** for `go list` and `go env`, so the Go SDK must be on `PATH` or every build dies with `could not find 'go' command`. The default target is the host (`windows/amd64` here); there is no `windows` target name in `tinygo targets` to pass explicitly. Fourteen of the fifteen files are byte-identical to `sources/go/`'s; task 15 differs because TinyGo's Windows target implements no fsync. |
| D | dmd | 2.100 | dlang.org/install.sh | `dmd -O -release -of=prog _<task>.d` |
| D | ldc2 | 1.30 | dlang.org/install.sh | `ldc2 -O3 -release -of=prog _<task>.d` |
| Swift | swiftc | 5.8 (6.4.0 measured) | swift.org/install; the Windows distribution is a WiX burn bundle, so `tools/get_swift.py` decompiles it and administrative-extracts the MSIs (see below) — no admin | `swiftc -O -sdk <swift>/Platforms/6.4.0/Windows.platform/Developer/SDKs/Windows.sdk -windows-sdk-root <winsdk> -windows-sdk-version 10.0.26100.0 -o prog.exe <task>.swift`, with the MSVC environment on `PATH`/`INCLUDE`/`LIB` for the link step. Two Windows SDK flags are load bearing: without `-windows-sdk-root`/`-windows-sdk-version` the clang importer never injects `ucrt.modulemap` and `winsdk_*.modulemap`, and every `import Foundation` dies with `missing required modules: '_complex', 'ucrt'`. The root has to be a complete header tree — the reassembled MSVC layout's `um` set is missing `CommCtrl.h`, `ShlObj.h` and `DbgHelp.h` — so this row points them at the `Microsoft.Windows.SDK.CPP 10.0.26100.1742` headers from nuget.org, with `Lib` junctioned to the MSVC tree's libraries. |
| Fortran | gfortran | 9 | distro package | `gfortran -O3 -o prog <task>.f90`. Task 03 also compiles `03_func_sum_add_one.f90`; task 11 needs `-fopenmp`. |
| Fortran | flang | LLVM 17 | MSYS2 `ucrt64` on Windows, distro or LLVM release elsewhere | `flang -O3 -o prog <task>.f90` (older LLVM: `flang-new`). Same two extras as gfortran: the second file for task 03 and `-fopenmp` for task 11. The official LLVM Windows tarball has no `flang.exe`; MSYS2's `mingw-w64-ucrt-x86_64-flang` plus `-flang-rt` is the working Windows route, and it pulls in the runtime libraries as well. Task 11 additionally needs `mingw-w64-ucrt-x86_64-llvm-openmp`: without it the link stops with `cannot find -lomp`, which is the only task-11 gap — flang installs the rest of its runtime with the compiler package. |
| Ada | gnat | 12 | alire.ada.dev | `gnatmake -O3 t<task>.adb` |
| Pascal | fpc | 3.2.2 | freepascal.org | `fpc -O3 -oprogram <task>.pas`. On Windows x64 there is no native compiler: install the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, then build with `-Px86_64`. |
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
| Modula-3 | cm3 | 5.10.0 | github.com/modula3/cm3 — `cm3-all-AMD64_NT-<v>.zip` (79 MB) extracted, no installer and no admin. **Not the newest release**: `d5.12.0` and `d5.11.x` ship only `cm3-boot-*` and `cm3-dist-*` archives, which are the source and bootstrap trees; `cm3-all-…-VC2019-20210221` is the last prebuilt `AMD64_NT` binary distribution | `cm3 -build -O` in a directory holding `Main.m3` and an `m3makefile`, with `tools/cm3/bin` on `PATH` and `INSTALL_ROOT` pointing at the tree. Needs the MSVC environment (`tools/msvc_env.py`) for its C backend, and writes the binary to `AMD64_NT\prog.exe`. **Three runtime DLLs have to sit beside the produced exe** or it dies with `rc 53` (`STATUS_DLL_NOT_FOUND`) before `main`: `m3.dll` and `m3core.dll` for every task, plus `arithmetic.dll` for task 10, whose `m3makefile` imports `arithmetic` for `BigInteger`. Task 10's source also has to spell the timing constant as a `LONGREAL` literal — `1000.0` alone is an `illegal operand(s) for '*'` against `Time.Now`'s `LONGREAL`, so it is `1000.0D0` — and the text writer is `Wr.PutText`, not `Wr.PutString`, whose `READONLY ARRAY OF CHAR` formal rejects a `TEXT` actual. |
| COBOL | gnucobol | 3.2 | MSYS2 `ucrt64`, or gnucobol.sourceforge.io | `cobc -x -O2 -o prog <task>.cob`. `PIC 9(18) COMP-5` is the exact 64-bit picture, and COMP-5 keeps the full binary range regardless of the PICTURE, so limb arithmetic fits in one COMPUTE. Outside an MSYS2 shell, `cobc` needs `COB_CONFIG_DIR` and `COB_COPY_DIR` set to the package's `share/gnucobol/{config,copy}` or it stops with `configuration error: /ucrt64/share/gnucobol/config/default.conf`. Task 11 needs `CBL_GC_FORK`, which GnuCOBOL documents as unavailable on Windows outside Cygwin: it returns -1 there and the program falls back to four in-process quarters, so the answer is right but the row is single-core on Windows and four-way on Linux. The compiled exe also needs the MSYS2 `ucrt64/bin` on `PATH` to find its runtime DLLs, or it exits 0 with no output. Two fixed-format lines — the `COMPUTE CS0`/`CS1` clock conversions — ran past column 72, which fixed-format silently truncates; they are wrapped. Task 10 had a third defect worth recording: its six `CALL 'BIGMUL' USING ... <literal>` sites passed the multiplier as a numeric literal, which GnuCOBOL materialises as a DISPLAY-format temporary, while BIGMUL's `LINKAGE` declares it `COMP-5` — so the callee read the literal's bytes as a binary value (`5 * 4` came back as `24435220`). The spigot state diverged, grew without bound and the program ran for 80 minutes before dying on an out-of-range limb access; moving each literal into the `COMP-5` variable `S` first makes the row finish in 60 s with the right answer. Three more tasks needed a wider output `PIC`: 07 and 15 printed a leading zero (`9(7)`/`9(9)` for 6- and 8-digit answers) and 14 truncated (2389704704 needs 10 digits, not 9). |
| BASIC | freebasic | 1.10.1 | freebasic.net | `fbc -O 2 -x prog.exe <task>.bas`. `-x` names the output, so the source file name must come after it; `-x <task>.bas` alone would write the executable over the source. `LONGINT` is the 64-bit type; `THREADCREATE` gives real threads for task 11. Task 03 also compiles `03_func_sum_add_one.bas` on the same command line. |
| BASIC | qb64 | QB64-PE 4.7.0 | github.com/QB64-Phoenix-Edition/QB64pe releases, `qb64pe_win-x64-4.7.0-GLFW.7z` (104 MB), extracted into `tools/qb64/` — no installer and no admin. The compiler **translates QB64 to C++ and shells out to a C++ compiler**, which the release zip carries in `internal/`, so the first build is slow (about 6 s per task) and the extracted tree is 814 MB. | `qb64pe.exe -x <task>.bas -o prog.exe`, which compiles without running. QB64-PE is not FreeBASIC: `DECLARE LIBRARY` fails with `LIBRARY not found` and the working form is `DECLARE DYNAMIC LIBRARY "kernel32"`. `PRINT` pads positive numbers, so the answer goes out through `LTRIM$(STR$(x))`. `TIMER` is the clock. `_INTEGER64` is needed for task 02's 7500000075000000, and task 10 hand-rolls base-1e9 limbs in `_INTEGER64` arrays because the language has no bignums. No threads: task 11 is four child processes. Binary file I/O is `OPEN ... FOR BINARY` with `GET`/`PUT`. |
| V | v | 0.5.2 | vlang.io | `v -prod -cc x86_64-w64-mingw32-gcc -o prog <task>.v`. V compiles through a C backend, so it needs a C compiler; `-cc` picks it. Task 03 keeps `add_one` in the same file with `@[noinline]`, V's own no-inline facility, which the generated C carries over as `__attribute__((noinline))`. |
| ATS | ats | 0.4.2 | ats-lang.org, or SourceForge `ats2-lang` | Built from source under Cygwin: `./configure && make -f Makefile_dist all`. GCC 14 rejects the 2014-era bootstrap C, so `src/CBOOT/Makefile` needs `CFLAGS += -fpermissive -Wno-implicit-function-declaration -Wno-int-conversion -Wno-implicit-int` first. That is enough to get `patsopt` and `patscc`; `make all` then fails on `utils/myatscc`, which is a build utility and not needed. `patscc -DATS_MEMALLOC_LIBC -O2 -o prog <task>.dats`. Task 03 needs `ATS_DYNLOADFLAG 0` on the helper unit, or the separate compilation gets optimised away. | The shipped sources needed a syntax pass against 0.4.2, which is now done: all fifteen build and run. Three things were wrong. (1) `val () = $extfcall (void, ...)` is rejected, so the timing-report calls are now bare statements. (2) Two calls sat in the `let` declaration block of tasks 07 and 09, which only takes declarations; they moved into the `in` body. (3) Task 10's bignum kept its counts in dependent-`int` record fields, which the constraint solver widened to `size_t` and could not reconcile — the fields and the index variables are now `llint`, with `$UN.cast{int}` at the `ptr0_get_at_int`/`ptr0_set_at_int` index boundary, and the `if a.n > b.n then a.n else b.n` max is a `var` overwritten conditionally, because an if-expression over dependent fields poisoned every arithmetic use of its result. Verified 15/15 with the expected outputs. | c3c | 0.8.4 | github.com/c3lang/c3c releases | `c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog <task>.c3`. `-O0` is the default and `-O2` is the first level that turns off bounds and null checks, so `-O2` is the flag the task wants; `int` is 32 bits, so the 100-million counters are `i64` and task 02's total does not fit in `int`. On Windows c3c links through `lld-link` and wants the MSVC SDK: it will offer to **download** one if it cannot find one, which needs no admin but is a large fetch. The hand-extracted tree under `tools/msvc` works with `--win-sdk "…/Windows Kits/10"` plus one `-L` per library directory (the MSVC `lib\x64`, the SDK `ucrt\x64` and the SDK `um\x64`); `--win-vs-dirs` does **not** accept that tree. `-o prog` already yields `prog.exe` — passing `-o prog.exe` produces `prog.exe.exe`. Task 11 uses the standard library's `std::thread` module (`Thread.create` / `Thread.join`); task 10 hand-writes the limbs, because the standard library's `std::math::bigint` is 8192 bits (about 2466 decimal digits) and 10000 digits do not fit. |
| Vala | valac | 0.56 | MSYS2 `ucrt64` on Windows, distro package elsewhere | `valac -X -O2 -o prog <task>.vala`, run from the MSYS2 UCRT64 shell. `valac` translates to C and drives `gcc`; `-X -O2` is what hands `-O2` to that gcc, and without it the generated C is compiled unoptimised. The build needs `valac` plus GLib's development files (`pkg-config` resolves them). The generated binary imports `libglib-2.0-0.dll` **whenever the Vala code touches GLib**, which is most of these tasks, so those executables need the UCRT64 `bin` directory on `PATH` at run time; the few tasks that call no GLib function at all link nothing extra and run with a bare system `PATH`. Each file's header says which case it is. Static linking (`-X -static`) fails and is not used. Task 03 also compiles `03_func_sum_add_one.vala` on the same command line, because Vala has no no-inline attribute. Task 11 uses `GLib.Thread<int64?>` with a lambda, joined in spawn order; task 10 hand-writes the base-10^9 limbs, since GLib has no big integers. |
| Oberon-07 | akron | 1.69 | github.com/AntKrotov/oberon-07-compiler | The repository ships a ready 64-bit Windows `Compiler.exe`, no build needed. `Compiler.exe <task>.ob07 win64con -out prog.exe`, run from the directory holding the source with `lib\Windows\` beside it — the compiler resolves BOTH the file name and its import tree against the process working directory, so a build script has to copy `lib\Windows` into each task directory or it stops with `file ...\lib\Windows\RTL.ob07 not found`. It has **no optimisation switch**: its x86-64 code generator has no unoptimised mode, so the plain build line is the whole story, and `-nochk a` is not used because turning off the range and type checks changes what a program means. `INTEGER` is 64 bits. No task 11 problem: the shipped library has no thread module, but the compiler's own `[convention, "dll", "proc"]` foreign declaration imports `CreateThread` and `WaitForSingleObject` from kernel32 directly, which is how its `Out`, `File` and `WINAPI` modules are built — the same hand-rolled route the Assembly row takes with `clone` and `futex`. The start routine must be declared `PROCEDURE [windows]` with a matching `PROCEDURE [windows] (p: INTEGER): INTEGER` type, or the ABI is wrong and the thread never returns. |
| Beef | BeefBuild | 0.43.5 | beeflang.org/setup, `BeefSetup_0_43_5.exe` (259 MB) extracted with 7-Zip, not installed — no admin | `tools/beef/bin/BeefBuild.exe -proddir=sources/beef/<task> -config=Release -platform=Win64`, then `sources/beef/<task>/out/prog.exe`. **`-config=Release` is mandatory**: Beef's Windows Debug toolset is Microsoft's and stops without Visual Studio, while Release links with the bundled `lld-link.exe`. Every project wrapper also sets `CLibType = "SystemMSVCRT"`, because the Release default asks for MSVC's static CRT. `corlib` is recompiled once per project on every build, so a task takes 11-23 s. |
| Haxe | hxcpp | 4.3 | haxe.org win64 zip, plus `neko` for `haxelib` and a 64-bit MinGW `g++` | `haxe -cp sources/haxe -main T01_branches -cpp temp/haxe/01_branches -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs`, then `<outdir>/T01_branches.exe`. `haxe -cpp` writes C++ and runs `haxelib run hxcpp`, which drives `g++` and `windres`; `-D no_shared_libs` is what makes the link static. `MINGW_ROOT` is not optional — hxcpp guesses `c:/MinGW` and otherwise stops with `Could not guess MINGW_ROOT`. |
| JavaScript | spidermonkey | C159.0a1 | archive.mozilla.org — the official Firefox nightly `jsshell-win64.zip` (18 MB), extracted into `tools/spidermonkey/`; no installer and no admin. It is a **shell**, not Node, so `require` and `worker_threads` do not exist. | **No build step**: `tools/spidermonkey/js.exe <task>.js`. `print()` is the output call; there is no `console.log` guarantee. Tasks 14 and 15 need `data.bin` in the working directory. |
| Haxe | hashlink | 4.3 | haxe.org win64 zip for the compiler, plus the HashLink VM — `hashlink-1.16.0-win64.zip` extracted into `tools/hashlink/` (the `hl.exe` runtime and its `*.hdll` natives). No installer and no admin. | Two steps, unlike the `hxcpp` row: `haxe -cp sources/hashlink -main T<NN>_<name> -hl <out>.hl`, then `hl <out>.hl`. `-hl` emits bytecode for the VM instead of C++, so there is no C toolchain and no hxcpp in the path. The measured run is the `hl` one; both binaries have to be on `PATH`. |
| Eiffel | eiffelstudio | 25.12 | ftp.eiffel.com/pub/download, win64 `.7z` (139 MB) extracted — no admin, no activation | `ec -batch -finalize -c_compile -config stupidspeed.ecf -target tNN`, run from `sources/eiffel/`; the executable is `EIFGENs/<tNN>/F_code/prog.exe`. `-finalize` is the optimisation — EiffelStudio has no `-O` level, its knob is the compilation mode (`-melt`, `-freeze`, `-finalize`). The delivery ships its own MinGW gcc 4.4.5, so no MSVC is needed. One ECF carries all 15 targets, and only task 11 sets the concurrency capability to `thread`. Four environment variables are needed: `ISE_EIFFEL` and `ISE_LIBRARY` both point at the tree root (`ISE_LIBRARY` must not be the `library` subdirectory, because the ECF refers to `$ISE_LIBRARY\library\base\base.ecf`), `ISE_PLATFORM=win64`, and **`ISE_C_COMPILER=mingw`** — plain `gcc` leaves the compiler path empty and ec stops with `Cannot start "".`; `mingw` selects the gcc 4.4.5 the delivery ships under `gcc\win64\mingw\bin`. Two source/library fixes were needed for 25.12: the `TIME` class moved out of `base` into the separate `time` library, so the ECF adds `<library name="time" location="$ISE_LIBRARY\library\time\time.ecf"/>` to every target, and its millisecond query is spelled **`milli_second`**, not `millisecond`. A target's `EIFGENs` directory must also be wiped before a rebuild: a partial one makes the generated E2 Makefile stop with `No rule to make target 'big_file_E2_c.obj'`. |
| Seed7 | s7c | 2026-07-11 (interpreter 5.4.10, s7c 3.5.10) | source release `seed7_05_20260711.tgz` (4.5 MB), built with MSYS2's MSVCRT MinGW gcc: `cp mk_msys.mak makefile`, `make -f mk_msys.mak depend`, `make -f mk_msys.mak`, `make -f mk_msys.mak s7c` | `s7c -O2 prog.sd7` -> `prog.exe`. **There is no output-name flag**: s7c names the executable after the source file and writes it beside the source, so the build copies the task to `prog.sd7` in a scratch directory first. `-O2` is required — without `-O` s7c passes no optimisation flag to the C compiler it drives. |
| Scala | native | 0.5 (0.5.12 measured) | scala-cli plus a C toolchain; on Windows the portable llvm-mingw zip, no admin | `scala-cli --power package <task>.scala --native -S 3.9.0 --native-version 0.5.12 --native-mode release-fast --native-clang <llvm-mingw>/bin/clang.exe --native-clangpp <llvm-mingw>/bin/clang++.exe --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe`, then `prog.exe`, run from `sources/scala-native/`, which holds the same fifteen files as the `jvm` row. `--native-mode release-fast` is mandatory: the default `debug` mode compiles with `-O0` and measured 0.270 s against 0.074 s on task 02. |
| Standard ML | Poly/ML | 5.9.1 | github.com/polyml/polyml releases, `PolyML5.9.1-64bit.msi` (3.03 MB), extracted with `msiexec /a <msi> TARGETDIR=<dir> /qn` — no admin. **v5.9.2 is newer but has no Windows asset at all**; 5.9.1 is the one. | Two steps, and they are the two `polyc` would have driven, because the MSI ships no `polyc` and no import library (see below): `PolyML.exe -q --error-exit --script build/<task>.ML` exports a whole heap image to `<task>.obj`, where the driver file contains `use "<task>.sml"; PolyML.export ("<task>", main);`, then `gcc -Wl,-u,WinMain -mconsole -o prog.exe <task>.obj polystub.obj -Ltools/polyml -lpolyml`. **`PolyLib.dll` must sit beside the produced executable** or it dies before `main` with `STATUS_DLL_NOT_FOUND` and no output. Task 03 loads `03_func_sum_add_one.sml` with `use` and sets `PolyML.Compiler.maxInlineSize := 0` **before** it — a separate file alone is not enough. Task 14 reads in 65536-byte chunks. |
| Nelua | nelua | 0.2.0-dev (`a5845056`) | `git clone --depth 1 https://github.com/edubart/nelua-lang tools/nelua` (6 MB, no installer, no admin), then build the repository's own Lua interpreter once: `mingw32-make` in `tools/nelua/`, which compiles `src/onelua.c` with its `lfs`, `hasher` and `lpeglabel` companions into `nelua-lua.exe` (24 s). The host's own Lua cannot run the compiler: `runner.lua` requires those three C modules and there is no `luarocks` here to add them. | `cmd.exe /c tools/nelua/nelua.bat -r -o prog.exe <task>.nelua`, run from `sources/nelua/` — the launcher has to go through `cmd.exe`, and `require` resolves against the **working directory**, not the source file's, so the build must run from the row's directory (`-L sources/nelua` also works). `-r` (`--release`) is this compiler's `-O2` equivalent, literally `gcc ... -fwrapv -fno-strict-aliasing -O2 -DNDEBUG`, and it also turns on the compiler's `nochecks` pragma; `-M`/`--maximum-performance` is deliberately not used because it adds `-Ofast -march=native -flto=auto`. Task 03's helper is in its own file **and** marked `<noinline>`: Nelua concatenates every required module into one C translation unit, so a plain cross-file call is inlined and the loop is deleted. |

| Pony | ponyc | 0.65.0 | `tools/ponyc` — a release build extracted, no installer and no admin. **0.65.0 is deliberate**: ponyc 0.66.0 changed how Pony does networking on Windows and the release now documents Windows 11 / Server 2022 (build 20348) as the minimum, because the networking layer uses an OS readiness API introduced there. This host is Windows 10 19045 and 0.65.0 predates the change, so it is the last release that runs here. | `ponyc` compiles a **directory** as one package and names the executable after that directory, and all fifteen files declare `Main`, so each task is built from a scratch directory named after it: `mkdir -p temp/pony/<task> && cp sources/pony/<task>.pony temp/pony/<task>/ && tools/ponyc/bin/ponyc.exe -o temp/pony/<task> temp/pony/<task>` produces `temp/pony/<task>/<task>.exe`. Every link prints `O sistema não pode encontrar o caminho especificado.` — harmless, the executable is still produced. |
| Lean 4 | lean | 4.34.1 | github.com/leanprover/lean4 releases, `lean-4.34.1-windows.zip` (811 MB), extracted — no installer and no admin. Windows is a **Tier 1** platform for Lean, so the binary release is built and tested by Lean's own CI. | Two steps: `lean -c <task>.c <task>.lean` compiles the module to C, then `leanc -O2 -o prog <task>.c` links it. `leanc` drives the toolchain Lean ships with itself — the `clang`, `lld` and Lean runtime DLLs all live in `tools/lean4/bin/` — so **put `tools/lean4/bin` on `PATH` first**, or `leanc` cannot find its own linker. The interpreter (`lean --run <task>.lean`) also works and is what a quick check uses, but the compiled route is the measured one because the interpreter is far slower on the 100-million-iteration tasks. |
| Common Lisp | ecl | 24.5.10 | conda-forge `ecl-26.5.5` (or 24.5.10) `win-64` build, unpacked from the `.conda` archive — no installer and no admin. ECL has **no Windows binary upstream**: `ecl.common-lisp.dev` publishes source tarballs only, and MSYS2 and Cygwin carry no `ecl` package at all, so conda-forge is the only prebuilt Windows route. | `ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) … (compile-file \"<task>.lisp\" :output-file \"<task>.fas\") (ext:quit))"` then `ecl.exe --norc --eval "(load \"<task>.fas\" :verbose nil)"`, run from `sources/commonlisp-ecl/`. ECL compiles to C and routes it through a C compiler, which has to be pointed at the hand-extracted MSVC tree with `c::*cc*`/`c::*ld*` plus `INCLUDE` and `LIB`; the exact values are in each file's header. |
| D | gdc | 4.9.2 (D 2.066.1) | **gdcproject.org's own archive, and the only native-Windows GDC there is from 2015.** `gdcproject.org/archive/binaries/x86_64-w64-mingw32/x86_64-w64-mingw32_2.066.1_gcc4.9.2_f378f9ab41_20150413.7z` (35 MB, 556 MB unpacked, 7315 files), a crosstool-NG build of GCC 4.9.2 with D 2.066.1 — extract into `tools/gdc/`, no installer and no admin. Nothing newer exists for Windows: the same archive's `6.3.0`, `5.4.0` and `5.2.0` directories hold **Linux-hosted cross-compilers** (`gdc-6.3.0+2.068.2-x86_64-linux-gnu.7z`), not Windows binaries, and the package route is closed — Cygwin's `gcc-gdc` ships `gdc.exe` and its `d21` backend but **no D runtime at all** (no `object.d`, no phobos, no druntime), so it cannot compile a single program; MSYS2 packages no `gdc`; and WinLibs, the standalone Windows GCC whose front page advertises C, C++, Objective-C, Fortran *and* D, ships no `gdc` binary in any of its archives. **Building it was tried and abandoned**: a full GCC bootstrap with `--enable-languages=d,c` is viable in principle (it needs GMP and MPFR development headers, extracted from their Cygwin packages, and MPC, which Cygwin does not package either and which must be built from source first), but it measured **one object per minute** at `-j4` on this host, which puts the remaining ~1000 objects plus libphobos at 20+ hours; and the shortcut does not exist, because GCC's libphobos cannot be configured standalone against the system `gdc` — `core.stdc.*` needs the D front end that the GCC tree itself builds. So the row is measured on an eleven-year-old compiler, which is a property of GDC on Windows rather than a choice. | `gdc -O2 -o prog _<task>.d` — the same fifteen files as the `dmd` and `ldc2` rows. Fourteen compile unmodified; **task 03 needs the `version(GNU)` branch**, because `pragma(inline, false)` only arrived in D 2.070, so under GDC the call is kept real by going through a reference of abstract base type instead. The branch is in the shared file, so all three D toolchains still build one source. Task 11 uses `core.thread` and is genuinely parallel here — measured 198 ms for task 02 against 123 ms for the same work on four threads. |

### Compiled to WebAssembly — the runtime is the VM, and the module is the program

The output is a `.wasm` module, so a WebAssembly runtime starts on every measured run. Eleven rows
share one runtime, **wasmtime**, pinned to **46.0.3** for the reason in the `wasi-threads` note
below; the install is the release zip extracted under `tools/wasmtime46/`, no installer and no
admin. Five of the eleven — C, C++, Rust, Go and Python — build the same sources as their native
rows, because those source sets were already written for a POSIX target; each still has its own
directory, `sources/c-wasm/`, `sources/cpp-wasm/`, `sources/rust-wasm/`, `sources/go-wasm/` and
`sources/python-wasm/`. Ruby and Lua are the exception in content rather than in layout: their
task 11 cannot use the mechanism the native row uses, so `sources/ruby-wasm/` and
`sources/lua-wasm/` hold a different file for it.

The C and C++ rows need no source change at all: `11_parallel_sum.c` already selects its
pthread branch under `#else` of `#if defined(_WIN32)`, and wasm32 is not `_WIN32`.

Three of the eleven cannot use the concurrency facility their native row uses, and each says so in
its own source and entry: **Ruby** and **Lua** have no threads at all on wasip1 (CRuby is built
`THREAD_MODEL=none`, and Lanes has no wasm build), so their four workers are Fibers and
coroutines; **Go** has no thread support in its `wasip1` port, so its goroutines are multiplexed
onto one thread. All three are correct-answer-no-speedup cells.

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| C | wasm32-wasip1 (clang) | wasi-sdk 34 (LLVM 23.1) | wasi-sdk release tarball, `wasi-sdk-34.0-x86_64-windows.tar.gz` (619 MB), extracted into `tools/wasi-sdk/` — no installer, no admin | `clang --target=wasm32-wasip1 -O2 -o prog.wasm <task>.c`, run from `sources/c-wasm/`. Task 11 adds `-pthread --target=wasm32-wasip1-threads -Wl,--import-memory -Wl,--export-memory -Wl,--shared-memory -Wl,--max-memory=2147483648`. |
| C++ | wasm32-wasip1 (clang++) | as above | as above | `clang++ --target=wasm32-wasip1 -O2 -fno-exceptions -o prog.wasm <task>.cpp`, run from `sources/cpp-wasm/`. **`-fno-exceptions` is required**: `libc++abi` is not in the sysroot's default link, so tasks 08 and 10 fail at link with `undefined symbol: __cxa_allocate_exception` without it. Task 11 adds the same four thread flags as the C row. |
| Rust | wasm32-wasip1 (rustc) | 1.90 | `rustup target add wasm32-wasip1` (tier 2, prebuilt std) | `rustc --target wasm32-wasip1 -O -o prog.wasm <task>.rs`, run from `sources/rust-wasm/`. Task 11 uses `--target wasm32-wasip1-threads`, which is a **tier 3** target and has no prebuilt std — `rustup target add` fetches a std it has to build locally. |
| Go | wasip1 (gc) | 1.26 | none — the installed toolchain has the target | `GOOS=wasip1 GOARCH=wasm go build -o prog.wasm <task>.go`, run from `sources/go-wasm/`. **The file tasks 14 and 15 need the preopen's guest path to be absolute**: Go's own wasip1 runtime resolves a relative name like `data.bin` against a preopen only when that preopen's guest name is a path such as `/`, so `wasmtime --dir . prog.wasm` fails with `open data.bin: Bad file number`; `wasmtime --dir=<hostdir>::/ prog.wasm` works. This is a Go-runtime quirk, not a wasmtime one — the wasi-sdk-built C and C++ rows open the same file happily under plain `--dir .`, because wasi-libc resolves it against the cwd. |
| AssemblyScript | wasip1 (asc) | 0.28 | `npm install assemblyscript` into `tools/assemblyscript/` | `asc <task>.ts -O2 --outFile prog.wasm --runtime incremental --use abort=<task>/abortImpl`. **`asc` must be run with the row's directory as the working directory**, because the `--use abort=…` specifier is resolved relative to the source file. Task 11 adds `--enable threads --importMemory --sharedMemory --maximumMemory 1024`. |
| WebAssembly | hand-written WAT | none | none — the runtime is the whole toolchain | **No build step.** `wasmtime run <task>.wat` parses the text on every run; measured, that costs 51 ms against 52 ms for the equivalent binary module, i.e. nothing. |
| Python | wasip1 (cpython) | 3.12.2 | the `Python-3.12.2.tgz` source release (26 MB), cross-compiled once with the `wasi-sdk` tree the C row already installs — no new download | **Not a prebuilt artifact**, because neither released WASI asset is usable as it stands. The plain build has an owned, growable memory but `threading.Thread` raises `RuntimeError: can't start new thread`; the `-threads` build supports threads but declares its memory as an **import** with `min = max = 160` pages — a hard 10 MB cap — so tasks 04, 06, 12 and 13 die with `MemoryError`. The row's sources are `sources/python-wasm/`, the same fifteen files as the `cpython` row. It therefore builds from source and lifts the cap where it lives, in `configure.ac`'s WASI pthread branch (`configure.ac:2327-2340` in 3.12.2): `-Wl,--max-memory=10485760` becomes `-Wl,--max-memory=1073741824`, and the old target triple `wasm32-wasi-threads` becomes `wasm32-wasip1-threads` because wasi-sdk 34's sysroot has no `wasm32-wasi-threads` tree (`ph.c:1:10: fatal error: 'pthread.h' file not found`). Then: `env WASI_SDK_PATH=<wasi-sdk> sh Tools/wasm/wasi-env sh configure -C --host=wasm32-unknown-wasi --build=x86_64-pc-mingw64 --enable-wasm-pthreads --with-build-python=<python.exe> --prefix=/ CONFIG_SITE=Tools/wasm/config.site-wasm32-wasi`, then `mingw32-make -j12 python.wasm`, then copy `Lib/` to `lib/python3.12/` beside the module plus `_sysconfigdata__wasi_wasm32-wasi.py` from `build/lib.wasi-wasm32-3.12/`. **`--prefix=/` is what makes `--dir .` alone sufficient** — the official recipe leaves `/usr/local` and relies on a `--mapdir /::<srcdir>` mapping plus `PYTHONPATH`. Run line: `wasmtime -S threads=y -W threads=y -W shared-memory=y --dir . python.wasm <task>.py`. The resulting module is 28,012,164 bytes and declares `env.memory flags=3 shared min=160 max=16384`. A binary patch that raises the released asset's declared maximum is **not** a substitute: it yields a module wasmtime rejects with `invalid leading byte (0x80) for external kind`, because the import section's length prefix and its first descriptor overlap. |
| Ruby | wasip1 (ruby.wasm) | 2.10.1 (`ruby.wasm`), CRuby 4.1.0 | github.com/ruby/ruby.wasm releases — the single-file `ruby.wasm` (99 MB) from the `2.10.1` tag, no installer and no admin. The `ruby-*-wasm32-unknown-wasip1-{full,minimal}.tar.gz` assets are the same build with the stdlib tree beside it, and the `-emscripten-` ones are a different target that the wasmtime CLI cannot run. | **No build step.** `wasmtime --dir . ruby.wasm <task>.rb`. The sources are `sources/ruby-wasm/`, a complete fifteen-file set; fourteen are byte-identical to `sources/ruby/`'s and task 11 differs. The module embeds CRuby 4.1.0 and its stdlib, so nothing else is needed. Every cell needs `--dir .` because the script itself is read through a preopen. Task 11 cannot use `Thread`: CRuby's WASI build is configured `THREAD_MODEL=none`, so `Thread.new` raises `initialize() function is unimplemented on this machine`, and `Ractor.new` is stubbed the same way. The row therefore uses **Fibers**, the language's own cooperative concurrency, and `sources/ruby-wasm/11_parallel_sum.rb` says so. |
| Lua | wasip1 (puc-lua) | 5.4.8 | the `lua-5.4.8.tar.gz` source release (374 KB), cross-compiled once with the `wasi-sdk` tree the C row already installs — no new download | Compile the 33 core sources with **`clang++ -fexceptions`**, not `clang`, with the shim directory first on the include path: `clang++ --target=wasm32-wasip1 -O2 -fexceptions -DNDEBUG -D_WASI_EMULATED_SIGNAL -DL_tmpnam=32 -I<shim> -I<src> -c <file>.c`, skipping `luac.c`, which has its own `main`. In C mode `ldo.c` emits real `setjmp`/`longjmp` calls that nothing defines and the link dies with `undefined symbol: longjmp`. Then link them with `clang++ --target=wasm32-wasip1 -O2 -fwasm-exceptions -mllvm -wasm-use-legacy-eh=false -L<wasi-sdk>/share/wasi-sysroot/lib/wasm32-wasip1/eh -lc++abi -lunwind -lwasi-emulated-signal -lwasi-emulated-process-clocks -o lua.wasm *.o wasi_shims.c`. Four things carry the target, and none of them changes a Lua source line. The sources are `sources/lua-wasm/`, a complete fifteen-file set; fourteen are byte-identical to `sources/lua/`'s and task 11 differs. `-D_WASI_EMULATED_SIGNAL`/`-lwasi-emulated-signal` because `lstate.h` uses `sig_atomic_t`; `-lwasi-emulated-process-clocks` because `loslib.c` and `ltablib.c` call `clock()`; `-DL_tmpnam=32` because wasi-libc does not define `L_tmpnam`; and the C++ exception route because wasi-libc turns `<setjmp.h>` into a hard `#error` unless `-mllvm -wasm-enable-sjlj` is set, and that path emits *legacy* `try` instructions that both wasmtime 46 and 49 refuse with `legacy_exceptions feature required`. `ldo.c` already prefers `throw`/`catch` over `setjmp` under `__cplusplus`, so compiling the sources as C++ is Lua's own supported configuration and the only one the runtime can execute. `tools/lua-wasm/wasi_shims.c` supplies `tmpfile`, `tmpnam` and `system`, which wasi-libc omits and no task calls. Run line: `wasmtime -W exceptions=y --dir . lua.wasm <task>.lua`. Task 11 cannot use the Lanes extension the native Lua rows use — Lanes is a pthreads C extension with no wasm build — so the row uses **coroutines**, the language's own cooperative concurrency, and `sources/lua-wasm/11_parallel_sum.lua` says so. |

| Zig | wasm32-wasip1 (zig) | 0.16 | ziglang.org/download, the same tree the native `zig` row installs | `zig build-exe <task>.zig -target wasm32-wasi -O ReleaseFast -femit-bin=prog.wasm`, run from `sources/zig-wasm/`. Zig 0.16 replaced `std.posix.write` and moved `std.fs` onto `std.Io`, so the entry point is `pub fn main(init: std.process.Init) !void` and output goes through `std.Io.File.stdout().writeStreamingAll(io, …)`; `sources/zig/` is the native sibling with the same shape. Task 11 needs `-fno-single-threaded -mcpu=generic+atomics+bulk_memory --shared-memory --import-memory --export-memory --max-memory=2147483648 -rdynamic`: **`-rdynamic` is load-bearing** — wasm-ld only exports symbols in the dynamic table, and without it wasmtime aborts with `failed to find a wasi-threads entry point function; expected an export with name: wasi_thread_start`. |
| TinyGo | wasip1 (tinygo) | 0.42 | tinygo.org, `tinygo0.42.0.windows-amd64.zip` (178 MB), extracted into `tools/tinygo/` — no installer, no admin. Needs `go` on `PATH` for the same reason the native `tinygo` row does. The release zip ships **no `wasm-opt`**, and every wasm target runs it, so `tools/tinygo/bin/wasm-opt.exe` (binaryen) has to be dropped in beside `tinygo.exe`. | `tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm <task>.go`, run from `sources/tinygo-wasm/`. The sources are TinyGo-compatible Go written for this row, not the native `sources/go/` files. Task 11 is a `correct-answer-no-speedup` cell: Go's `wasip1` port has no thread support, so the four goroutines are multiplexed onto the single wasm thread. |

Run lines, all eleven rows: `wasmtime run prog.wasm`. Task 11 adds
`-S threads=y -W threads=y -W shared-memory=y` for the six compiled rows. Tasks 14 and 15 add
`--dir=.` **from a directory holding `data.bin`**, and the three interpreted rows need
`--dir=.` on **every** cell, because the script itself is read through the preopen. Go is the
exception on the file tasks: it opens its preopens by the WASI name and expects it to be `/`,
so its two cells need `--dir=<host dir>::/` and print `Bad file number` with the plain
`--dir=.` every other row uses.

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
instead of `7500000075000000`, with no diagnostic of any kind. The C and C++ rows get the pair
from `-Wl,--import-memory -Wl,--export-memory`; the hand-written row spells it out.

### Compiled to bytecode — the VM is needed on every run

These compile once, but the output is bytecode or an intermediate form, so a virtual machine
has to start on every measured run. That startup is part of the number.

| Language | Toolchain | Minimum | Install | Build |
|---|---|---|---|---|
| Java | openjdk | 17 | jdk.java.net or Adoptium | `javac _<task>.java`, then `java -cp . _<task>` |
| Java | openj9 | 21 | IBM Semeru Open Edition, `ibm-semeru-open-jdk_x64_windows_21.0.12.15.zip` (230 MB) extracted into `tools/openj9/` — no installer, no admin, and it brings its own `javac` | `tools/openj9/bin/javac.exe -d . _<task>.java`, then `tools/openj9/bin/java.exe -cp . _<task>`. **Eclipse OpenJ9, not HotSpot**: run from `sources/java-openj9/`, which holds the same fifteen files as the `openjdk` row, unchanged, with no OpenJ9-specific flag and no `-X` option. The whole difference is which VM executes the bytecode — OpenJ9's JIT (`openj9-0.61.0`) against HotSpot's C2 — and OpenJ9 maps `java.lang.Thread` onto OS threads, so task 11 is a real four-thread pass. Verified with `java -version`, which reports `Eclipse OpenJ9 VM 21.0.12.15`. |
| Java | graalvm jit | GraalVM 21 (25.0.4 measured) | graalvm.org, the same JDK tarball the `graalvm native-image` row installs | **No separate build step**: `javac _<task>.java` produces the same class files, and the row is the run line `<graalvm>/bin/java -cp . _<task>`. The whole difference from the `openjdk` row is which JIT compiles the bytecode: GraalVM's JDK has `EnableJVMCI`, `EnableJVMCIProduct` and `UseJVMCICompiler` all `true` by default, so the Graal compiler replaces HotSpot's C2 without any flag. Verified with `java -XX:+PrintFlagsFinal -version`. The sources are `sources/java-graalvm-jit/`, the same fifteen files as the `openjdk` row. |
| Java | loom | 21 (25 measured) | jdk.java.net or Adoptium — no GraalVM needed | `javac -d . _<task>.java`, then `java -cp . _<task>`, exactly as the `openjdk` row, run from `sources/java-loom/`, which holds all fifteen tasks. **Task 11 differs**: it is the `openjdk` task 11 with `Thread.ofVirtual()` in place of `new Thread(...)` and nothing else changed. Virtual threads are final since 21, so no preview flag is involved. |
| Kotlin | jvm | 1.9 (2.4.20 measured) | kotlinlang.org, `kotlin-compiler-<v>.zip` (85 MB) extracted — no installer and no admin. Needs a JDK on `PATH`; `JAVA_HOME` selects which | `kotlinc <task>.kt -include-runtime -d prog.jar`, then `java -jar prog.jar`, run from `sources/kotlin/`, which holds all fifteen tasks. `-include-runtime` bundles `kotlin-stdlib` into the jar, so the run line needs a JRE and nothing else. Task 11 uses four `java.lang.Thread` workers. |
| C# | coreclr | .NET 8 | dotnet.microsoft.com | `dotnet build -c Release` |
| C# | mono | 6.12 | mono-project.com | `mcs -optimize+ <task>.cs` |
| F# | dotnet | .NET 8 | as above | `dotnet build -c Release` |
| VB.NET | dotnet | .NET 8 | as above | `dotnet build -c Release`, with a `.vbproj` instead of a `.csproj`. Same SDK as C# and F#, so no extra install. |
| Scala | jvm | 3.3 | scala-lang.org | Two steps: `scalac -release 17 -d out <task>.scala`, then `java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main`, where `<scala>` is the distribution and `<v>` its version. **Scala CLI's `scala` is a subcommand runner, not the classic `scala Main` launcher**, so it rejects `scala Main` with `Main is not a scala sub-command`; running the compiled class through `java -cp` is the equivalent and it also keeps the launcher's own start-up out of the measurement. The compiler needs a JDK 17 or newer on `PATH`. |
| Component Pascal | gpcp | 1.4.08b3 | github.com/k-john-gough/gpcp releases | Gardens Point Component Pascal for .NET, `gpcp-NET1.4.08b3.zip`, expanded anywhere. `gpcp /list- _<task>.cp` compiles a module to an assembly named after the `MODULE`; `/list-` only suppresses the `.lst` file and there are no optimisation levels. It needs `CROOT` pointing at the expanded tree, `%CROOT%\bin` on `PATH`, and `CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem` — the leading `.` is not decoration: without it the compiler cannot find the helper module that task 03 builds in the same directory, and without the `NetSystem` entry no `mscorlib` type is visible. The file name must equal the `MODULE` name, so the row uses `_<task>.cp`. The .NET runtime is needed on every run (see `RUN.md`), and `RTS.dll` plus any `GP*Files.dll` the module imports must be copied next to the executable — they are not found on `PATH`. Task 03 is two modules, `_03_func_sum_add_one.cp` and `_03_func_sum.cp`, compiled in that order, because Component Pascal has no no-inline marker and the call has to cross an assembly boundary. Task 11 uses the foreign `mscorlib_System_Threading` module: `Th.ThreadStart` is already a delegate type, so `REGISTER(s, w.Run)` attaches a bound method to it and `Th.Thread.init(s)` / `Start` / `Join` give four real .NET threads. Task 10 hand-writes the base-10^9 limbs with `LONGINT`; nothing in the shipped symbol files is arbitrary-precision. |
| OCaml | ocamlopt | 5.0 (5.4.1 measured) | MSYS2 UCRT64 `mingw-w64-ucrt-x86_64-ocaml`, plus `mingw-w64-ucrt-x86_64-flexdll` | `ocamlopt -unsafe -o prog.exe _<task>.ml`. **Version 5 is required**: the 4.14 toolchain that the old "OCaml for Windows" installer ships has no `Domain` module and serialises `Thread`, so task 11 could only be a correct-answer-no-speedup cell there. `-unsafe` drops array and string bounds checks, which is the usual speed knob; `-O3` is accepted but is a **no-op** unless the compiler was built with Flambda, and the MSYS2 package reports `flambda: false`. Two environment details are mandatory and neither is obvious. `OCAMLLIB` must be set to the **Windows** form of the stdlib directory (`C:\...\ucrt64\lib\ocaml`), because `ocamlopt` is a native Win32 binary and the MSYS2-style `/ucrt64/...` path baked into its config resolves to nothing — without it every compile fails with `Unbound module Stdlib`. And `flexdll` is a **separate package**; without it the link step stops with `'flexlink' is not recognized`. Filenames carry the row's `_` prefix because OCaml derives a module name from the file name and a module name must be a valid identifier, so `01_branches.ml` draws `Warning 24: bad source file name`. Task 03 uses `[@inline never]`, OCaml's own no-inline attribute, so it needs only one file. Task 10 hand-writes the base-1e9 limbs in `int64`: the standard library has no bignum, and `zarith` is not in MSYS2's UCRT64 repository. Task 11 uses `Domain.spawn`/`Domain.join`. |
| OCaml | ocamlc (bytecode) | 5.0 (5.4.1 measured) | the same MSYS2 UCRT64 `ocaml` package the `ocamlopt` row installs — nothing extra | Two steps, run from the MSYS2 shell so the OCaml runtime DLLs resolve: `ocamlc -I +unix unix.cma -o prog.exe _<task>.ml`, then `./prog.exe`. The sources are the `ocamlopt` row's own fifteen files, unchanged — this is a backend comparison, not a second program. Three things are load-bearing. **`-I +unix unix.cma` is required**, or the link fails with `No implementation provided for the following modules: Unix`. The build must run **inside the MSYS2 shell** with `OCAMLLIB` set to the Windows form of the stdlib directory, because the produced launcher needs `ocamlrun.exe` and `dllunixbyt.dll` on `PATH`; `-custom` does not work here, since it needs a C compiler and fails with `stdio.h: No such file or directory`. And the source file names keep the row's leading underscore, because OCaml rejects a file whose name starts with a digit (`bad source file name: 01_branches is not a valid module name`). Bytecode is the interpreter half of the pair: measured 5.3 s against the native row's 0.4 s on task 01. |
| ActionScript | AIR | 51.4.1 | AIR SDK from harman.com/developer/air | Two steps. `amxmlc -swf-version=51 -output prog.swf _<task>.as` compiles the AS3 to a SWF, then `adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf` packages it into a standalone `out\prog.exe` with the AIR runtime bundled beside it. Use **`amxmlc`, not `mxmlc`**: only `amxmlc` links against `airglobal.swc`, so the AIR-only APIs this row needs (`System.output`, `flash.filesystem`, `Worker`) do not exist under the plain Flex compiler. A JDK (17 works) has to be on `PATH` for both tools. `adt` refuses to package an unsigned bundle, so one self-signed certificate is generated once with `adt -certificate -cn SelfSigned 2048-RSA test.p12 pass` and reused by every task. **The signing options must precede `-target`**: `adt` scans for them in order and otherwise stops with `Found misplaced signing arguments`, and the application descriptor has to be the literal `app.xml` path rather than the class name or it reports `error 301: Application descriptor missing`. Class names carry the row's `_` prefix because AS3 requires the public class name to equal the file name and a file cannot start with a digit. One shared `app.xml` sits beside the fifteen `.as` files, the way GDScript's `project.godot` does, because every task compiles to `prog.swf` and packages to `prog.exe`; only the `.as` name changes between tasks. Task 11 is two translation units: `_11_parallel_sum_worker.as` compiles separately to `worker.swf`, which the `adt` line passes as an extra file so it lands in the bundle and the main SWF can load its bytes for `createWorker`. Task 14's `data.bin` is passed to `adt` the same way — see the note below on why. |

| Boo | booc | 0.9.7 | github.com/boo-lang/boo source, built once with the .NET 10 SDK: `dotnet build Boo.slnx -c Release`. The repository ships `booc.cmd`, but it only points at a build output that does not exist until the solution has been built once. | `dotnet tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe <task>.boo` emits a .NET assembly. **Two things must sit beside `prog.exe` or it will not start**: `Boo.Lang.dll` (from `tools/boo/src/Boo.Lang/bin/Release/net10.0/`) and a `prog.runtimeconfig.json` declaring `Microsoft.NETCore.App` version `10.0.0`. Without the DLL it dies with `Could not load file or assembly 'Boo.Lang'`; without the config it dies with `The library 'hostpolicy.dll' … was not found`, because a bare assembly is treated as self-contained. |
| Gleam | gleam | 1.18.1 | github.com/gleam-lang/gleam releases, `gleam-v1.18.1-x86_64-pc-windows-msvc.zip` (8 MB), extracted — no installer and no admin. Runs on the Erlang/OTP tree the `erlang` and `elixir` rows already install. | One Gleam project, fifteen modules: `gleam build` then `gleam run --module <name>`. **The module names cannot start with a digit *or* an underscore** — Gleam rejects both — so the row's files are `t01_branches` … `t15_file_write` in `src/` rather than `01_branches`. There is no per-file run mode, so a single project with `--module` is the only clean way to get fifteen runnable programs out of one row. **`gleam build` fetches `gleam_stdlib` and `gleam_erlang` from hex on the first build**, so this is the one row in the matrix that needs network access before it can run; `manifest.toml` pins the two versions, and a `build/` directory left in place makes later builds offline. `gleam run` also needs `tools/erlang/bin` on `PATH`. |
| IronPython | ipy | 3.4.2 | github.com/IronLanguages/ironpython3 releases, `IronPython.3.4.2.zip` (16 MB), extracted — no installer and no admin. Runs on the .NET 8 runtime the `coreclr` row already installs. | No build step: `tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll <task>.py`. Use the `net8.0` directory rather than `net6.0`, and drive `ipy.dll` through `dotnet` rather than looking for an `ipy.exe`, which the release zip does not contain. |
| Unicon | unicon | 13.3 | unicon.sourceforge.io — `setup-unicon_13.3~BYOPL2e_v0(64-bit).exe` (15 MB), unpacked rather than installed: it is an Inno Setup archive, so `7z` refuses it and `innoextract -e` extracts `app/` into `tools/unicon/`, no admin and no registry. **13.3 and not 13.2 is load-bearing**: the 13.2 Windows release is built without concurrent threads, so `unicon -features` omits the feature and `thread` dies with `function not supported`. | `unicon -s <task>.icn` compiles to icode and writes `<task>.exe`; task 03 also names `03_func_sum_add_one.icn` on the same command line, and the icode file is named after the first file. The measured run is the `.exe`, which is **self-contained** — the runtime is appended to the icode, so nothing from `tools/unicon` is needed at run time (verified with a clean `PATH`). Both the compiler and the executables it produces read their own appended image through `argv[0]`, so they must be invoked with a **Windows-style backslash path**: given `C:/…/prog.exe` they die with `can't read interpreter file header`, and given `C:\…\prog.exe` they run. `tools/unicon/bin` has to be on `PATH` to compile. |
| Haskell | ghc | 9.14 | downloads.haskell.org — `ghc-9.14.1-x86_64-unknown-mingw32.tar.xz` (452 MB, 4.1 GB extracted) unpacked into `tools/ghc/`. **The bindist bundles its own MinGW**, so no MSVC and no Windows SDK are needed. No installer and no admin. | `ghc -O2 -threaded -o prog <task>.hs`, then `prog`. **`-threaded` is required for task 11** and the row is run as `prog +RTS -N4 -RTS`; without `-threaded` there are no capabilities to schedule onto. `-O2` alone is what the other compiled rows use. |
| Lobster | lobster | 2026.8 | github.com/aardappel/lobster releases — `lobster_windows_release.zip` (15 MB) extracted into `tools/lobster/`, no installer and no admin. | **No build step**: `tools/lobster/bin/lobster.exe <task>.lobster` compiles to bytecode and runs it in one go. Tasks 14 and 15 read and write `data.bin`/`out.bin` in the working directory, so run from `sources/lobster/`. |
| Forth | gforth | 0.7.9 | github.com/fukuyori/gforth_for_windows releases — `gforth-native-0.7.9_...-x64-setup.exe` (3.4 MB). It is an Inno Setup archive, so `7z` refuses it and `innoextract` 1.9 cannot read its 6.5 setup-data version; it is run **silently** instead, `gforth-setup.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /DIR=<target>`. Its manifest sets `PrivilegesRequired=lowest` and installs under the user profile, so no admin and no registry. | **No build step** — gforth interprets the file: `gforth <task>.fs`. The interpreter needs its image `gforth.fi` and the working directory's `data.bin` at once; in this layout `gforth.exe` finds the image beside itself, so no `GFORTHPATH` is needed as long as the run directory holds the sources and the fixture (verified 15/15 without it). Output has a trailing space after the numbers, so a byte-exact comparison must trim. |
| Euphoria | eui | 4.1.0 | github.com/OpenEuphoria/euphoria releases, `euphoria-4.1.0-Windows-x64-*.zip` (21 MB), extracted into `tools/euphoria/` — no installer and no admin. | **No build step**: `EUDIR=<install root> eui.exe <task>.ex`, and **`EUDIR` is mandatory** or the interpreter fails to start. Three things shape the row. **There is no reachable stderr**: `printf(2, …)` and `puts(2, …)` both write nothing when stderr is redirected, so the contract's `time.txt` fallback carries `TIME_MS` (the same exception `dyalog`, `ring` and `modula2` record). **There is no high-resolution clock in `std`** — `time()` is whole seconds and the `datetime` fields are second-resolution — so the timer is an FFI call to `QueryPerformanceCounter` through `std/dll.e` and `std/machine.e`. And **`std/task.e` segfaults** on `task_create` in this build (signal 11), so task 11 is four child processes via `system_exec` from `std/os.e` rather than cooperative tasks. `integer` is 64-bit and exact, so task 02 and 04 are exact; there are no bignums in `std`, so task 10 hand-rolls base-1e9 limbs. |
| Mercury | mmc | 22.01.9 | Built from source: the `mercury-srcdist-22.01.9.tar.gz` release compiled with the MSYS2 UCRT64 gcc the `valac` row already installs, and `mercury_compile.exe` was copied into `tools/mercury/bin/` so the toolchain does not depend on the source tree. No Windows binary is published. The configured grade is **`hlc.gc.pregen`** — the default `hlc.gc` is not installed and every build fails with "the Mercury standard library cannot be found in grade hlc.gc". | `mercury_compile --make <module> --grade hlc.gc.pregen`, with `MERCURY_STDLIB_DIR` pointing at the installed `lib/mercury`, `mkinit.exe` on `PATH`, and UCRT64 `gcc` on `PATH` for the C back end. A Mercury module name cannot start with a digit, so the files are `01_branches.m` and the modules are `m01_branches`; `Mercury.modules` holds the mapping. **Task 11 is compiled with `--grade hlc.par.gc`** instead, because the default grade has no parallelism; the other fourteen use `hlc.gc.pregen`. |
| Erlang | erlc (compiled) | OTP 29.1.1 | the same 179 MB OTP Windows `.zip` the `erlang` row installs — nothing extra | Two steps: `tools/erlang/bin/erlc.exe <task>.erl` writes `<task>.beam`, then `tools/erlang/bin/erl.exe -noshell -s <task> main -s init stop`. The sources are `sources/erlang-compiled/`, module-form rewrites of the escript row's scripts: that row's files carry a shebang and no `-module` declaration, so `erlc` cannot compile them as they stand. The rewrite replaces the shebang and the `%%! -smp enable` emulator line with `-module`/`-export` and `main/0`, and drops `-smp enable` because SMP is on by default in OTP 29 (`erlang:system_info(smp_support)` is true). Algorithms are unchanged, and the compiled row is the one that separates compile time from run time: the escript row charges the per-run compile to every cell, this one pays it once at build time. Task 11 stays a real parallel pass, four workers on the SMP scheduler. |

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
| PHP | zend | 8.5.11 (ZTS) | windows.php.net, `php-8.5.11-Win32-vs17-x64.zip` (36 MB, the non-`nts` name is the thread-safe build), extracted into `tools/php-zts/` — no installer, no admin | **No build step**: `php <task>.php`. The row uses the **ZTS** build rather than the NTS one, because task 11 needs the PECL `parallel` extension and that extension only loads into a thread-safe PHP; `php_parallel-1.2.10-8.5-ts-vs17-x64.zip` from the Windows PECL builds goes into `ext/`, with `pthreadVC3.dll` beside `php.exe`, and `php.ini` must set **`extension_dir`** as well as `extension=parallel` — the build's compiled-in default is `C:\php\ext`, so a bare `extension=parallel` fails with `Unable to load dynamic library`. |
| PHP | zend + jit | as above | as above | Same interpreter, with `-d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M`. **`-d opcache.jit=tracing` is required**: PHP 8.5 changed the master default of `opcache.jit` to `disable`, so `opcache.jit_buffer_size` alone leaves the JIT off (`opcache_get_status()` reports `jit.on=false`, `buffer_size=0`) and the row would measure only opcache bytecode caching. With the flag set the JIT is on and the effect is large — measured 4.2x on task 01, 6.0x on 09 and 12.3x on 11. |
| Python | cpython, pypy, graalpy |
| Python | jython | 2.7.4 | github.com/jython/jython releases, `jython-standalone-2.7.4.jar` (48 MB) — a single self-contained jar, no installer and no admin. Needs a JRE on `PATH`; the `openj9` row's JDK runs it. | **No build step**: `java -jar tools/jython/jython-standalone-2.7.4.jar <task>.py`. **Jython 2.7 is Python 2**, not Python 3: `print` is a statement, there are no f-strings, `/` on integers is floor division, and the loop form is `xrange`. The sources are therefore Python-2 rewrites, not the `cpython` row's files. Python 2's `long` is arbitrary precision, so task 10 uses native bignums rather than hand-rolled limbs. `java.lang.Thread` gives real JVM threads, so task 11 is four real threads. `System/nanoTime` is the clock and `sys.stderr` is stderr. |
| Lua | puc-lua, luajit |
| Perl | perl |
| R | gnu-r |
| R | gnu-r (no JIT) | 4.4 | the same R tree the `gnu-r` row installs — nothing extra | **No build step**, and no source change: set **`R_ENABLE_JIT=0`** in the environment and run `Rscript.exe <task>.R` exactly as the `gnu-r` row does. R ships a byte-code compiler that is on by default, so the plain `gnu-r` row measures R with its JIT and this row measures it without; the sources are the `gnu-r` row's own fifteen files, unchanged. The environment variable is the right lever and `compiler::enableJIT(0)` is not: the latter **does not propagate to task 11's PSOCK workers** (they still report level 3), and wrapping the script in `-e 'compiler::enableJIT(0); source(...)'` also auto-prints the old level to stdout. The contrast is clean: measured **3622 ns per iteration against 823 with the JIT on** for task 01, about 4.4x, which makes that cell take 362 s instead of 82 s. |
| Julia | julia |
| Julia | julia (interpreted) | 1.11 | the same tree the `julia` row installs — nothing extra | **No build step**: `julia --compile=min -O0 <task>.jl`. The sources are the `julia` row's own fifteen files, unchanged, so this is a compilation-strategy comparison rather than a second program. `--compile=min` turns off Julia's type-specialised code generation and `-O0` the LLVM optimisation pass, so the loop bodies are interpreted rather than JIT-compiled. The cost is real and large: measured 438 s for task 01 and 535 s for task 02 against about 20 ms and 15 ms under the default JIT. Task 11 must be run with **`-t4`** (`julia --compile=min -O0 -t4`), or its four `Threads.@threads` workers have one thread to share and the cell becomes a correct-answer-no-speedup; with `-t4` it measured 151 s against a 497 s single-thread baseline on the same range, a 3.3x speedup. The worst cells are task 13 at **942 s** and task 14 at **954 s**. That is the honest price of the language's interpreter, not a workaround. |
| Dart | jit |
| GDScript | godot --headless | 4.7.2 | godotengine.org, `Godot_v4.7.2-stable_win64.exe` — a single self-contained binary, no installer and no admin | **No build step**: `Godot_v4.7.2-stable_win64_console.exe --headless --script <task>.gd`, run from the directory holding the scripts and `project.godot`. **Use the `_console.exe` build**: the plain `.exe` is a GUI subsystem program whose output never reaches a pipe, the same trap as Dyalog's `dyalog.exe` and Dolphin's `Dolphin8.exe`. Each script `extends SceneTree` and does its work in `_initialize()`. This is the slowest row in the matrix — the 100 M-iteration loops take tens of seconds each. |
| Groovy | groovy | 4.0.33 | groovy.apache.org / dlcdn.apache.org, `apache-groovy-binary-4.0.33.zip` (30 MB), extracted — no installer and no admin | **No build step**: `groovy <task>.groovy`, with `GROOVY_HOME` set to the extracted tree and its `bin` on `PATH`. Needs a JDK on `PATH` (it runs on the system Java). Groovy's `def` would box the counters into `BigDecimal`, so the loop index and the four counters are declared `long` and the arithmetic stays primitive. `System.nanoTime` is the monotonic clock and `System.err` is stderr. |
| Dolphin Smalltalk | Dolphin 8 | 8.2.3 | github.com/dolphinsmalltalk/Dolphin releases, `Dolphin8Setup.exe` (42 MB), an Inno Setup installer unpacked with `innoextract -e -d tools/dolphin/` — no admin | **No build step**: `Dolphin8.exe DPRO.img8 -u -f <task>.st -q`, run from the directory holding the script. `DPRO.img8` ships in `userdocs/Dolphin Smalltalk 8/` and is copied next to `Dolphin8.exe`; the VM is 32-bit and needs the x86 VC++ runtime, which the installer carries as `tmp/vc_redist.x86.exe`. Scripts write through `SessionManager current stdout` and end with `SessionManager current quit: 0`. Two source fixes were needed: `cr` on a file stream hangs the VM, so the `time.txt` write ends with `nextPut: 10` instead, and task 09 read its clock *before* `fib value: 40` ran (the call sat inside the final output expression), so the call is hoisted above the timing write. |
| Tcl | tclsh |
| Algol 68 | a68g |
| JavaScript | quickjs | 0.11.0 | github.com/quickjs-ng/quickjs releases, `qjs-windows-x86_64.exe` (1.7 MB), a single static binary — no installer and no admin. | **No build step**: `qjs.exe --std <task>.js`. **`--std` is load-bearing**: without it the `std` and `os` modules are not defined and `import * as std from 'std'` fails with `could not load module filename 'std'`. With it they are plain globals — `std.err.puts` writes to fd 2 and `std.out.puts` to fd 1. QuickJS-ng **has BigInt**, so task 10 uses `2n**100n`-style native arithmetic instead of hand-rolled limbs. Binary file I/O is `std.open(path,'rb')` plus `f.read(arraybuffer, offset, len)` — the count returned is the byte count, and NUL bytes survive, which is what task 14 needs. No threads: task 11 uses four child processes. |
| Clojure | clojure.main |
| Clojure | babashka | 1.13.225 | github.com/babashka/babashka releases, `babashka-1.13.225-windows-amd64.zip` (27 MB), a GraalVM native-image binary — no JVM, no installer and no admin. | **No build step**: `bb.exe <task>.clj`. It is **not the JVM**: start-up is milliseconds and there is no Java interop beyond what babashka's reflection allow-list permits — `FileDescriptor.sync()` is rejected, so task 15 flushes with `FileChannel.force(true)`. **Plain `+` and `*` throw on `long` overflow**; the promoting operators `+'` and `*'` are the ones that widen to `BigInt`, which is what task 10 uses. `System/nanoTime` is the monotonic clock and `(.println System/err …)` is stderr. Single-threaded: `future` serialises, so task 11 is four child processes via `babashka.process`. |
| Racket | racket (CS) |
| Common Lisp | sbcl |
| VBScript | cscript |
| Raku | rakudo (MoarVM) |
| Erlang | OTP (escript) |
| Elixir | elixir (BEAM) |
| Scheme | chez |
| Prolog (SWI) | swipl |
| J | jconsole |
| Janet | janet |
| Ring | ring |
| JScript | cscript (WSH) |
| AutoHotkey | v2 |
| Terra | terra |
| Dyalog APL | dyalog |
| Pharo | Pharo 13 |
| Arc | Anarki on Racket 9.3 |
| Factor | factor | 0.100 | factorcode.org, the Windows `.exe` installer unpacked — no admin | **No build step**: `factor.exe <task>.factor`, run from `sources/factor/`. The script is compiled and run on every invocation, so the compile time is inside the measured number. `TIME_MS` goes to stderr and stdout is unchanged. |
| Luau | luau, lute |
| SQLite | sqlite3 |
| DuckDB | duckdb | 1.5.6 | github.com/duckdb/duckdb releases, `duckdb_cli-windows-amd64.zip` (13 MB), extracted into `tools/duckdb/` — a single CLI binary, no installer and no admin. | **No build step**: `duckdb.exe -no-init :memory: ".read <task>.sql"`, run from `sources/duckdb/`. **`-init /dev/null` fails on this Windows build** (`IO Error: Failed to open file /dev/null`), so the run line passes no init file at all. Two CLI traps shape every file: the CLI CRLF-translates everything it writes unless `.binary on` is in force, **including the `.output stderr` target**, and the `.output` switch resets it, so `.binary on` is re-issued after each switch. `epoch_ms(now())` is the millisecond clock. **DuckDB 1.5.6 has an arbitrary-precision `VARINT` but `*`, `/`, `//` and `%` on it all return DOUBLE** — only `+` and `-` are exact — so task 10 is the hand-rolled base-1e9 route despite a bignum type existing, ported from `sources/sqlite/10_pi.sql`. Recursive CTEs allow only one recursive reference, so task 09's two-way recursion is a cross join against a two-row table. `PRAGMA threads=N` parallelises only DuckDB's own operators, never user computation, so task 11 is four child processes with rename-as-join, the SQLite row's shape. |

**Pharo** runs a file headlessly with
`PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source <task>.st`,
where `--quit` and `--no-source` keep the image from being saved or the file from being
compiled into it. Give the image as an **absolute path or a path relative to the working
directory you actually run from**: Pharo writes its `.changes` log and a `PharoDebug.log`
into the process working directory, so invoking it from the repository root drops two
untracked files there that do not belong to the benchmark. Run from `sources/pharo/` (or any
scratch directory) and they land in `tools/pharo/` beside the image instead. **Arc** is Anarki — Arc 3.2 plus its `lib/` tree — hosted on Racket:
`Racket.exe -t tools/arc/boot.rkt -e "(anarki-windows-cli)" -- <task>.arc`, run from
`sources/arc/`, and Racket's own boot (~30 s on this machine) is inside every measured run.
**Factor** is `factor.exe <task>.factor` from `sources/factor/`; each file carries a complete
`USING:` line, and a clean run prints none of the `Restarts were invoked adding vocabularies to
the search path` warning that Factor emits when it has to extend the search path at parse time.
**Luau** is two runtimes: tasks 01–13 are plain Luau under `luau.exe`, while tasks 11, 14 and 15
need **Lute**, the Luau team's own runtime, because the plain Luau CLI exposes no file I/O and no
process API at all — its `os` is `{clock, date, difftime, time}`, it has no `io`, no
`os.execute` and no `package`, so `data.bin`, `out.bin` and the four child processes of task 11
are unreachable under it. `SQLite` is `sqlite3.exe :memory: ".read <task>.sql"`, and every loop
in the row is a recursive CTE, because SQL has no loop statement.

Twenty-three of these need more than a run command.

**Dolphin** is
`Dolphin8 DPRO.img8 -u -f <task>.st -q`, the same form Dolphin's own `TestDPRO.cmd` uses.
`DPRO.img8` ships beside the installer in `userdocs/Dolphin Smalltalk 8/` and has to be
copied next to `Dolphin8.exe`. The VM is 32-bit and needs the x86 VC++ runtime,
which the installer ships as `vc_redist.x86.exe`. The installer is Inno Setup and needs
elevation, so `innoextract -e -d <dir> Dolphin8Setup.exe` unpacks it without admin, which is
how this row was verified. Scripts must write to stdout through `SessionManager current stdout`
and end with `SessionManager current quit: 0`. **Tcl** needs the `Thread` package for task 11,
which is not in the core distribution. MSYS2's `mingw-w64-ucrt-x86_64-tcl` **does** bundle it —
`ucrt64/lib/thread2.8.13/thread2813.dll` plus its `pkgIndex.tcl`, so `package require Thread`
resolves with no extra install and the row runs on the same `ucrt64/bin/tclsh.exe` as every
other task. A Tcl from a source build without `--enable-threads` (or a distribution that omits
the extension) still needs a distribution that bundles it, such as Magicsplat's Windows
installer, or `tcltk/thread` built against the local Tcl. Task 03 also sources
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
optimised append instead of the quadratic copy the task is about. The rows
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
copies the whole string per append — and it is the row's slowest cell. Task 15 has
no fsync, since 10.0.2 exposes `flush_output/1` and `close/1` and nothing lower, so it is flush
plus close. Task 11 is real OS threads with no global interpreter lock, measured at 3.4x on
four workers, and it needs message queues rather than shared variables: `thread_create/3`
**copies** the goal, so each worker sends its partial with `thread_send_message/2` and the
parent collects four times before joining.

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
exists, `file/sync` does not). Task 07 is the row's slowest cell:
`(string acc "x")` copies the accumulator twice per append, about 6.3x10^10 bytes over the
250000 iterations.

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
per iteration — so task 07 uses the spec's form and is honestly quadratic. And a global name
assigned inside a function is the global, not a local: parameters
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

Note that five of these are JITs rather than plain interpreters, and the distinction matters
for the numbers: `luajit`, `php zend + jit`, `dart jit`, `julia` and Dolphin all
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
| tinygo | the Go SDK on `PATH`. TinyGo bundles its own LLVM and its own standard library, but it still calls `go list` and `go env` for module resolution, so without `go` every build stops with `could not find 'go' command: executable file not found in %PATH%`. |
| gdscript | a Godot build, run with `--headless` |
| lua, for task 11 only | the Lanes C extension: `luarocks install lanes`. Needs a C compiler — a MinGW `gcc` on `PATH` is enough, and it builds Lanes 3.17.2 in about 20 s. Stock Lua has no threads. The distribution matters: the official `lua.org` release is source only, and the Windows binaries from LuaBinaries carry no `luarocks`, but the Lua 5.4.6 Windows install this row uses **does** ship `luarocks.exe` 3.9.2, so it is one command rather than a hand build. The rock lands **outside** the interpreter tree (`%APPDATA%\luarocks`, or whatever `--tree` names), so `LUA_PATH`/`LUA_CPATH` must point at it or `require("lanes")` fails with `module 'lanes' not found` — the interpreter does not search the rock tree by default. |
| clang, clang++ (Windows) | the LLVM Windows tarball ships no C headers. Either add a MinGW sysroot (`--target=x86_64-w64-windows-gnu -isystem <mingw>/include`) or install the MSVC SDK. |
| jruby | Java 25. It fails on Java 24 and older with `UnsupportedClassVersionError`; GraalVM 25 satisfies it. |
| scala | a modern `JAVA_HOME`. A Java 8 shim earlier on `PATH` (Oracle's `java8path`) makes `scalac` die with `UnsupportedClassVersionError` on class file 61.0. |
| scala/native | a C toolchain that Scala Native can drive. On Windows the documented route is LLVM/clang 16+ plus Visual Studio's C++ workload (the "C++ Clang tools for Windows" package does not work); without admin the portable llvm-mingw zip is the route, and it needs the two flags in the build line above. `--native-compile=-D_PID_T_` suppresses mingw's own `pid_t` typedef through its `#ifndef _PID_T_` guard, because Scala Native's `gc/shared/ThreadUtil.h` does `typedef int pid_t` under `#ifdef _WIN32` and clang rejects the redefinition; without it every build fails. `--native-linking=-static` is needed because Scala Native forces C++ exceptions on Windows, so a default link produces an executable importing `libc++.dll` from the llvm-mingw tree and only runs with that directory on the DLL search path. The mingw codegen path ships in the released compiler (`scala/scalanative/codegen/llvm/compat/os/WindowsGnuCompat.class` beside `WindowsCompat.class`), but upstream CI does not cover it, so it can break on a Scala Native upgrade. |
| C# nativeaot | the MSVC linker. With a hand-extracted MSVC tree, `dotnet publish` cannot find `vcvarsall` and reports `Platform linker not found`; pass `-p:IlcUseEnvironmentalTools=true` so it uses `PATH`/`INCLUDE`/`LIB` instead. |
| java/graalvm native-image | the MSVC toolchain, and there is **no `IlcUseEnvironmentalTools` equivalent**: native-image looks for `vswhere.exe` under `%ProgramFiles(x86)%\Microsoft Visual Studio\Installer` and then runs the `VC\Auxiliary\Build\vcvarsall.bat` that the tool reports, taking the environment delta as its build environment. A hand-extracted tree therefore needs a `vswhere.exe` that prints the tree's VS root and a `vcvarsall.bat` under it that sets `PATH`/`INCLUDE`/`LIB`; **`-H:-CheckToolchain` does not skip the lookup**, it only defers the `cl.exe` check. Three things bite after that: `cl.exe` needs the `1033\clui.dll` resources copied beside it or it dies with `C1510`, the linker needs `lib\x64\setargv.obj`, which ships in the **Store** CRT package rather than the Desktop one, and `OLDNAMES.lib` no longer ships at all — build an empty one with `lib.exe /OUT:OLDNAMES.lib <any>.obj`. |
| nim | a C compiler on `PATH` for the C backend. **The module name rule bites**: Nim rejects a source file whose name is not a valid identifier, so `_01_branches.nim` stops with `Error: invalid module name: '_01_branches'; a module name must be a valid Nim identifier` and the file has to be copied to a name such as `t01_branches.nim` first. Nim 2.x enables thread support by default, so task 11's `std/typedthreads` needs no extra flag. |
| masm | nothing extra: `ml64.exe` and `link.exe` come from the same hand-extracted MSVC tree the `msvc` row installs, driven through `tools/msvc_env.py` so `INCLUDE`/`LIB` resolve. The link line is `link /subsystem:console /entry:main /out:<task>.exe <task>.obj kernel32.lib` — `kernel32.lib` is the only import library the row needs, because the programs are freestanding PE64 with no C runtime. |
| adw (Modula-2) | nothing beyond the unpacked tree, but the compiler is fussier than ISO Modula-2 in three ways. **`TYPE (expr)` conversion is not accepted** — `LONGCARD (dt.hour)` fails with `error: { expected`, and only `VAL (LONGCARD, dt.hour)` compiles; `VAL` is what ADW's own library sources use. **`ADR` is not exported by default** — a module that passes a buffer to `IOChan.RawWrite` must name it in the `FROM SYSTEM IMPORT` list, or the call is `Undeclared symbol`. **A procedure heading that precedes other procedures must carry its own body**, not just a forward declaration: `PROCEDURE fib (n : CARDINAL) : LONGCARD;` followed by a nested `PROCEDURE` and then a bare `BEGIN … END fib;` fails with `Undeclared symbol` / `Invalid Factor`, because ADW reads the heading plus the next `BEGIN` as one unit. The heading has to be repeated immediately before its body. |
| cm3 (Modula-3) | the C backend, so the MSVC environment (`tools/msvc_env.py`) must be set, and `INSTALL_ROOT` must point at the cm3 tree. `Wr.PutString` takes a `READONLY ARRAY OF CHAR` and **rejects a `TEXT` actual** (`actual not assignable to READONLY formal`), so text goes through `Wr.PutText`. Arithmetic between `Time.Now`'s `LONGREAL` and an untyped `1000.0` is an `illegal operand(s) for '*'` — the literal has to be `1000.0D0`. The runtime is **not** linked in: `m3.dll` and `m3core.dll` must be copied beside the executable, or it exits `53` before `main` with no output at all; a task that imports `arithmetic` needs `arithmetic.dll` as well. |
| fpc (Windows x64) | the i386-win32 native compiler plus the `cross.x86_64-win64` add-on, since there is no native x64 compiler. |
| odin (Windows) | `WindowsSdkDir`, `WindowsSDKVersion` and `VCToolsInstallDir` in the environment. Odin does not discover the SDK on its own; without them it fails with `Windows SDK not found`. |
| c3c (Windows) | the MSVC SDK to link against, because c3c emits object files and hands them to `lld-link`. Without one it prints `To target x64 you need the MSVC SDK` and offers to download it. A hand-extracted tree works via `--win-sdk` plus three `-L` flags (see the toolchain table above); `--win-vs-dirs` does not accept one. |
| valac | a C compiler and GLib's development files. On Windows both come from MSYS2 `ucrt64` (`mingw-w64-ucrt-x86_64-vala`, which pulls in the GLib/GObject/GTK dependency chain and about 2.2 GB of tree). `valac` has to run inside that shell so `pkg-config` resolves. |
| cim | a C compiler and Cygwin. The compiler and runtime are built once under Cygwin, and `cim.exe` then drives the system `gcc` on every build, so `C:\cygwin64\bin` must be on `PATH` when it runs. |
| gpcp | the .NET runtime, and `RTS.dll` copied next to every executable (plus `RealStr.dll` for the row that formats reals, and the `GP*Files.dll` pair for the file tasks). `CPSYM` must be set or no symbol file is found. |
| a68g, for task 11 only | a source build with `--enable-parallel`. The prebuilt Windows binary is configured without the parallel clause and cannot run task 11 at all. It also needs `C:\cygwin64\bin` on `PATH` when built under Cygwin. |
| beef (Windows) | a `shell32.lib` from outside the distribution. `bin/lib/x64` ships eleven import libraries and the Release link line asks for `shell32.lib` anyway, so the link stops with `lld-link: error: could not open 'shell32.lib'`; any Windows SDK copy works, as does a MinGW import library renamed to it. `BeefConfig.toml` also has to be copied from the installer's `__user/bin/` into `bin/`, or BeefBuild stops with `ERROR: Unable to load project 'corlib'` — its `UnversionedLibDirs` is resolved against the config file's own directory. |
| haxe | Neko for `haxelib`, and the hxcpp backend. `haxelib.exe` ships without `neko.dll` and dies with `error while loading shared libraries: neko.dll`, and copying just that DLL is not enough — Neko then wants `gcmt-dll.dll`, `std.ndll`, `regexp.ndll` and the MSVC runtime, so the whole official `neko-2.4.1-win64.zip` is unpacked, put on `PATH` and named by `NEKOPATH`. `haxelib install hxcpp` is unusable where `lib.haxe.org` answers HTTP 403, so `hxcpp-4.3.171.zip` is unpacked and registered with `haxelib dev hxcpp <dir>` — dropping the tree in as a *version* fails, because haxelib parses the directory name as a version and rejects a three-part one. hxcpp 4.3.171 then does not compile with MinGW's libstdc++ as shipped: `src/hx/gc/GcCommon.cpp` calls `std::sscanf` without including `<cstdio>`, which MSVC pulls in transitively and libstdc++ does not, so one `#include <cstdio>` line has to be added to the installed copy. hxcpp also needs its own tool built once — `haxe compile.hxml` run from `tools/hxcpp/hxcpp-4.3.171/tools/hxcpp/`, which leaves `hxcpp.n` at the tree root; without it the first `haxe -cpp` stops at `Can't continue without hxcpp.n` after prompting to build it. Every build line also carries `-D mingw -D MINGW_ROOT=<the directory holding bin/g++.exe>`, because hxcpp guesses `c:/MinGW` and otherwise stops with `Could not guess MINGW_ROOT`. |
| eiffelstudio | four environment variables and a C compiler, which the delivery supplies itself: MinGW gcc 4.4.5 under `gcc/win64/mingw/bin`, selected with `ISE_C_COMPILER=mingw`, so no MSVC is needed. `ISE_EIFFEL` points at the tree, `ISE_PLATFORM` is `win64`, and `ISE_LIBRARY` must be the **root** of the tree rather than its `library` subdirectory — every shipped ECF refers to `$ISE_LIBRARY\library\base\base.ecf`, so pointing it at `library` makes `ec` fail with `Could not open file: …\library\library\base\base.ecf`. The MSYS 1.0 `sh.exe` the generated Makefiles call through also fails intermittently with `*** Couldn't reserve space for cygwin's heap (…) in child, Win32 error 0`, aborting the C compilation partway; re-running the same `ec` command resumes and finishes it, and six of the fifteen targets needed retries, so a build script has to retry and check for `prog.exe`. |
| s7c | the MSYS2 **MSVCRT** MinGW gcc to build the toolchain itself, not the UCRT one this repository already has. `make depend` runs `chkccomp`, which probes the C compiler for a `read_buffer_empty` macro; UCRT's `FILE` is opaque, so none of the candidate struct-member probes compile and the build dies at `fil_win.c:245: implicit declaration of function 'read_buffer_empty'`. MSYS2's `mingw-w64-x86_64-gcc` has the classic `_ptr/_cnt/_base` layout and works. The build must be driven from the MSYS2 MINGW64 shell with `/mingw64/bin` first on `PATH`, because `mk_msys.mak` uses Unix shell commands while its `mk_mingw.mak` counterpart does not work under this workstation's `sh`. `make depend` takes about 31 minutes and is **not** hung — it prints a `#*.+` progress bar and spends minutes on database probes. The same gcc must be on `PATH` for every later `s7c` run too, because `s7c` has no code generator of its own and calls it. |
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
- **gccgo has no Windows build and cannot be given one.** The GCC 16.1.0 tree this repository
  uses is configured `--enable-languages=c,c++,fortran,lto,objc,obj-c++` and answers
  `gcc -x go` with `language go not recognized`; it ships no `libgo`. Neither MSYS2 nor Cygwin
  packages a `gcc-go`, and WinLibs, the standalone Windows GCC, builds C, C++, Objective-C,
  Fortran and D only. Building it is not an option either: `libgo/configure.ac` assigns a
  `GOOS` only for darwin, freebsd, irix6, linux, netbsd, openbsd, dragonfly, rtems, solaris2,
  aix and gnu, so a mingw host dies at `could not determine GOOS from ${host}` before anything
  compiles, and the runtime has no Windows implementation to link against — `libgo/runtime` has
  no Windows file at all. `README.md` carries the full evidence under "Languages that are not
  here, and why". Go is represented by the `gc` and `tinygo` rows instead.

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
