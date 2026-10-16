-- task 04 array_sum — expected output: 599999940000000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 04_array_sum.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: the array is a real C array of 10000000 int64, allocated with terralib.new, which is
--       a one-line wrapper over LuaJIT's ffi.new. Eighty megabytes, contiguous, filled once
--       and summed twelve times.
-- note: int64 rather than int32 because the total 599999940000000 does not fit in 32 bits, and
--       because the spec says "integers" without naming a width; every row in this matrix
--       that has a 64-bit type uses it here.
-- note: the fill loop and the twelve summation loops are inside one terra function, so they
--       are native code: a store loop and load-and-add loops over contiguous memory.
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

terra fill_and_sum(a : &int64, n : int64) : int64
    for i = 0, n do
        a[i] = i
    end
    var total : int64 = 0
    for pass = 0, 12 do
        for i = 0, n do
            total = total + a[i]
        end
    end
    return total
end

local n = 10000000
local a = terralib.new(int64[n])

local ssV = fill_and_sum(a, n)
ssReport(ssT0)
print(string.format("%d", ssV))
