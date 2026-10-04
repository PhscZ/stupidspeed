-- task 08 average — expected output: 0.498046875
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 08_average.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 08_average.luau
-- Every reading is a multiple of 1/256, which is exact in binary, and the running total stays well
-- under 2^53, so the sum is exact whatever the order. Luau has one number type, the IEEE double.

local __t0 = os.clock()
local total = 0.0
for i = 0, 99999999 do
    local reading = (i % 256) / 256.0
    total = total + reading
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
print(total / 100000000)
