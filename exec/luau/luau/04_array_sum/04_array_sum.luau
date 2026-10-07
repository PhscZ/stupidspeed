-- task 04 array_sum — expected output: 499999500000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 04_array_sum.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 04_array_sum.luau
-- One flat table of 1000000 numbers, allocated up front with table.create so the fill loop does not
-- pay for table growth. Luau tables index from 1, so array[i + 1] holds the value the spec calls
-- array[i].

local __t0 = os.clock()
local size = 1000000
local array = table.create(size, 0)

for i = 0, size - 1 do
    array[i + 1] = i
end

local total = 0
for i = 0, size - 1 do
    total = total + array[i + 1]
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
print(total)
