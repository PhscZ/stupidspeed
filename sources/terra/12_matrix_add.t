-- task 12 matrix_add — expected output: 999000000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 12_matrix_add.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: three arrays of 8 MB each (1000 * 1000 int64), allocated with terralib.new, indexed
--       `i * n + j` rather than as a 2-D array. That is the same flat layout the Eiffel row
--       uses for the same reason — it is the layout a C array has anyway, and the index
--       arithmetic is what the compiler would generate regardless.
-- note: 24 MB of fresh allocation means the FIRST pass pays first-touch page faults. Measured
--       on this host: 0.116 s cold against 0.0053 s warm, and RUN.md times separate processes,
--       so the row's cell will be the cold number. That is a property of the benchmark, not
--       of Terra, but it is why this cell is not the 5 ms its steady state suggests.
--       temp/terra-doc.md §12.
-- note: int64 rather than int32 because the spec says "integers"; the values here would fit
--       in 32 bits (the largest is 999), but the same three arrays feed task 13's products and
--       every row in this matrix that has a 64-bit type uses it.

terra matrix_add(a : &int64, b : &int64, c : &int64, n : int64) : int64
    for i = 0, n do
        for j = 0, n do
            a[i * n + j] = i + j
            b[i * n + j] = i - j
        end
    end
    for i = 0, n do
        for j = 0, n do
            c[i * n + j] = a[i * n + j] + b[i * n + j]
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

local n = 1000
local a = terralib.new(int64[n * n])
local b = terralib.new(int64[n * n])
local c = terralib.new(int64[n * n])

print(string.format("%d", matrix_add(a, b, c, n)))
