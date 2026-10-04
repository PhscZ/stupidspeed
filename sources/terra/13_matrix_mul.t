-- task 13 matrix_mul — expected output: 599995000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 13_matrix_mul.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: the triple loop is written in the spec's order — i, then j, then k — and NOT
--       reordered to i, k, j. The reordering would be much faster because it turns the inner
--       access into a sequential walk, which is exactly the trick the task exists to catch,
--       so it is deliberately not done. The `B[k * n + j]` access in the inner loop strides by
--       n and is the reason this cell costs what it does.
-- note: 125 million multiply-adds in 0.0756 s measured (best of five, steady state), i.e.
--       about 1.65 G multiply-adds per second. That is native speed; nothing here needs a
--       caveat. temp/terra-doc.md §12.
-- note: `(i + j) % 7` and `(i * j) % 5` use C's `%` on non-negative values, so the results
--       are the same as a floor-mod. The products in the inner loop are bounded by
--       499 * 6 * 4 = 11976 per term and by 500 * 11976 in the accumulation, so int64 has
--       enormous headroom and the final 599995000 is exact.
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

terra matrix_mul(a : &int64, b : &int64, c : &int64, n : int64) : int64
    for i = 0, n do
        for j = 0, n do
            a[i * n + j] = (i + j) % 7
            b[i * n + j] = (i * j) % 5
        end
    end
    for i = 0, n do
        for j = 0, n do
            var sum : int64 = 0
            for k = 0, n do
                sum = sum + a[i * n + k] * b[k * n + j]
            end
            c[i * n + j] = sum
        end
    end
    var total : int64 = 0
    for i = 0, n do
        for j = 0, n do
            total = total + c[i * n + j]
        end
    end
    return total
end

local n = 500
local a = terralib.new(int64[n * n])
local b = terralib.new(int64[n * n])
local c = terralib.new(int64[n * n])

local ssV = matrix_mul(a, b, c, n)
ssReport(ssT0)
print(string.format("%d", ssV))
