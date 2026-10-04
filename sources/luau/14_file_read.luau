-- task 14 file_read — expected output: 2389704704
-- build: none (interpreted)    run: C:\stupidspeed\tools\lute\lute.exe run 14_file_read.luau
-- note: THIS FILE NEEDS LUTE, NOT luau.exe, because the plain Luau CLI has no file I/O at all - no
--       io library, no dofile, no loadfile; its only file access is require() of Luau source. Lute
--       (the Luau team's own runtime, tools/lute/lute.exe, release v1.0.0) provides @lute/fs, which
--       opens a file in binary mode and reads it through a buffer.
-- note: data.bin must be in the working directory: 52428800 bytes, the bytes 0..255 repeating.
--       It is a generated fixture, not a committed file; copy temp/verify/data.bin here before the
--       run, the way the R and Octave rows do.
-- note: one pass, byte at a time, in one fs.read call rather than 1 MiB chunks. Lute 1.0.0's
--       @lute/fs exposes only whole-file read - there is no readIntoBuffer in the shipped
--       library, only in its type definitions - so a chunked read is not available. The call is
--       still one pass over the file: libuv's FSRead callback refills a 1 MiB chunk until EOF and
--       only then hands back the string. The scan itself is one buffer.readu8 per byte, which
--       returns 0..255, over buffer.fromstring of that 50 MiB string.
-- note: the accumulator is a double and the running total 6684672000 is exact, so the final
--       mod 4294967296 is exact.

local __t0 = os.clock()
local fs = require("@lute/fs")

local f = fs.open("data.bin", "r")
local data = fs.read(f)
fs.close(f)

local buf = buffer.fromstring(data)

local total = 0
for i = 0, #data - 1 do
    total = total + buffer.readu8(buf, i)
end

local __t1 = os.clock()
-- Luau exposes no stderr and the plain luau.exe CLI no file I/O, so the timing line is
-- the contract's time.txt fallback, written through Lute's @lute/fs. Under `lute run <file>`
-- it is written; under luau.exe the require fails, the guard skips the write and the run is
-- otherwise unchanged. stdout is never touched.
local __hasfs, __fs = pcall(require, "@lute/fs")
if __hasfs then
    local __h = __fs.open("time.txt", "w")
    __fs.write(__h, string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
    __fs.close(__h)
end
print(total % 4294967296)
