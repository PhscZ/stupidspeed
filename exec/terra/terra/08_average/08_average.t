-- task 08 average — expected output: 0.498046875
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 08_average.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: the loop is a terra function over `double`, so it is real IEEE-754 double arithmetic
--       in registers. `[double](i % 256) / 256.0` is the explicit cast; Terra has no implicit
--       int-to-double conversion in an expression like this, so the cast is written out.
-- note: every reading is a multiple of 1/256, which is exact in binary, and the running total
--       stays well under 2^53, so the sum is exact and the answer does not depend on the
--       order of the additions. That is why the spec can demand the same digits from every
--       language, and why this cell is allowed to be a plain sequential accumulation.
-- note: `%.9f` and not `%g`: `print(0.498046875)` in Lua 5.1/LuaJIT prints "0.498046875"
--       already, but the format string pins it so a change in LuaJIT's default `%.14g` cannot
--       change the line.
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

terra average() : double
    var total : double = 0.0
    for i = 0, 100000000 do
        var reading : double = [double](i % 256) / 256.0
        total = total + reading
    end
    return total / 100000000.0
end

local ssV = average()
ssReport(ssT0)
print(string.format("%.9f", ssV))
