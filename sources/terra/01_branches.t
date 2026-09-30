-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 01_branches.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path. terralib runs a toolchain
--       probe before it opens this file: it wants a Visual Studio developer console or the
--       Windows Kits registry key, and aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 if it finds neither. This
--       host has no MSVC and no SDK, so the first branch is selected by setting VCINSTALLDIR
--       to any non-empty value; the directory it names is never read. INCLUDE is only needed
--       by the files that call terralib.includec. See temp/terra-doc.md §3.
-- note: the loop is a terra function, i.e. native code, so the counter and the if/else chain
--       are machine instructions rather than a LuaJIT trace.
-- note: measured on this host, this cell is about 0.4 ns per iteration, roughly 4x faster
--       than the C row's gcc -O2 build of the same loop. That is codegen, not a shortcut:
--       the LLVM IR and the machine code contain no vector types and no vector instructions
--       (0 xmm/ymm/zmm), LLVM unrolls the body by 2, and a mod-7 control loop costs exactly
--       twice as much, so the modulo really is being computed. temp/terra-doc.md §7.1 has the
--       IR, the disassembly and the C comparison.
-- note: `for i = 0, 100000000 do` in Terra is C-style and half-open, [0, 100000000), which is
--       what the spec's "from 0 to 99999999" means. Lua's own `for` is inclusive, so the two
--       must not be confused inside one file.

struct Counts { a : int64; b : int64; c : int64; d : int64 }

terra branches() : Counts
    var r : Counts
    r.a = 0
    r.b = 0
    r.c = 0
    r.d = 0
    for i = 0, 100000000 do
        if i % 3 == 0 then
            r.a = r.a + 1
        elseif i % 5 == 0 then
            r.b = r.b + 1
        elseif i % 7 == 0 then
            r.c = r.c + 1
        else
            r.d = r.d + 1
        end
    end
    return r
end

local r = branches()
print(string.format("%d %d %d %d", r.a, r.b, r.c, r.d))
