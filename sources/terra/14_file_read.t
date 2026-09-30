-- task 14 file_read — expected output: 2389704704
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 14_file_read.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: data.bin is read from the working directory, so this file is run from sources/terra/
--       with the repo's temp/data.bin copied beside it — the same arrangement the R, Octave
--       and Janet rows use. data.bin is NOT committed.
-- note: the file is opened in "rb", binary mode, and that is load-bearing rather than
--       cosmetic. Measured: a text-mode write of "A\nB\n" produces six bytes (0x41 0x0D 0x0A
--       0x42 0x0D 0x0A) against four in "wb", because the CRT translates LF to CRLF. A
--       text-mode read of the 0..255 cycle would fold every 0x0A into the preceding 0x0D and
--       the sum would be wrong. temp/terra-doc.md §8.
-- note: the read is 1 MiB at a time through the language's own io library, and each chunk is
--       summed by a terra function over its bytes — `terralib.cast(&uint8, chunk)` hands the
--       Lua string's storage to native code with no copy. A per-byte Lua loop would put an
--       interpreter iteration in the inner loop, which is what the spec's "for each byte b"
--       is not meant to measure; every other native row reads a block and sums it natively.
-- note: `f:read(n)` returns up to n bytes — a full chunk, a short final chunk, and nil past
--       EOF — so the loop is `while true` with a nil test, not a count.
-- note: the accumulator is a Lua number, not an int64 cdata. The raw total is 6684672000,
--       which is well under 2^53, so it is exact as a double, and `% 4294967296` then gives
--       the spec's expected 2389704704. Doing it in int64 would also be exact; a double is
--       simpler and the spec's own answer is a mod-2^32 reduction.
-- note: measured on this host: 0.0559 s for the 50 MiB pass, i.e. about 1.1 ns per byte.

local f = assert(io.open("data.bin", "rb"))

terra sum_bytes(p : &uint8, n : int64) : int64
    var total : int64 = 0
    for i = 0, n do
        total = total + [int64](p[i])
    end
    return total
end

local total = 0
while true do
    local chunk = f:read(1048576)
    if not chunk then
        break
    end
    total = total + tonumber(sum_bytes(terralib.cast(&uint8, chunk), #chunk))
end
f:close()

print(string.format("%d", total % 4294967296))
