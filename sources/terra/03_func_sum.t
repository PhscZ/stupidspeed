-- task 03 func_sum — expected output: 100000000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 03_func_sum.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: the spec offers two routes — the function in its own file, or a no-inline marker.
--       Terra has both and this row uses both. The helper is in 03_func_sum_add_one.t and is
--       loaded with terralib.loadfile; the separate file alone is NOT enough, because Terra
--       compiles every terra function it can see into one module and LLVM inlines across the
--       file boundary. Measured: with no marker the call is inlined and the whole loop is
--       deleted (0.0000 s, and the disassembly is `smax(n, 0)`); with
--       `add_one:setinlined(false)` the loop survives with one real call per iteration and
--       runs in 0.0895 s. Both disassemblies are in temp/terra-doc.md §10.
-- note: `setinlined(false)` is Terra's own no-inline facility, so unlike the Beef, Haxe,
--       Seed7 and Octave rows this one is not a deviation — it is the spec's preferred route.
-- note: the 100000000 calls cost 0.0914 s measured, i.e. 0.914 ns per call. LLVM still marks
--       the call `tail`, but the result is consumed so the backend emits a real `call`.
-- note: the driver takes its bound as a parameter rather than a literal, because a literal
--       lets LLVM constant-fold the loop bounds — the mistake recorded in temp/terra-doc.md
--       §16.1, which understated a similar probe by 1.7x.
-- timing: GetSystemTimePreciseAsFileTime is Windows' 100-nanosecond clock, imported
--         with terralib.externfunction; TIME_MS goes to time.txt, the contract's
--         fallback, because Terra's stdio has no stderr handle. stdout is unchanged.
local C = terralib.includec("stdio.h")
local GetSystemTimePreciseAsFileTime = terralib.externfunction("GetSystemTimePreciseAsFileTime", &int64 -> {})
terra ssNow() : int64
    var ft : int64
    GetSystemTimePreciseAsFileTime(&ft)
    return ft / 10000LL
end
terra ssReport(t0 : int64) : int64
    var f = C.fopen("time.txt", "w")
    C.fprintf(f, "TIME_MS=%lld\n", ssNow() - t0)
    C.fclose(f)
    return 0
end
local ssT0 = ssNow()

local add_one = terralib.loadfile("03_func_sum_add_one.t")()
add_one:setinlined(false)

terra func_sum(n : int64) : int64
    var value : int64 = 0
    for i = 0, n do
        value = add_one(value)
    end
    return value
end

local ssV = func_sum(100000000LL)
ssReport(ssT0)
print(string.format("%d", ssV))
