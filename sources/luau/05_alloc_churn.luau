-- task 05 alloc_churn — expected output: 1274991808
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 05_alloc_churn.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 05_alloc_churn.luau
-- Luau's buffer library is the language's byte buffer: buffer.create(64) allocates one,
-- buffer.writeu8/readu8 are its byte accessors. Ten million of them are created and dropped; the
-- line storing into slots is what keeps one in every 256 alive, so the collector has real work and
-- the allocation is not dead code. slots is indexed (i % 256) + 1 because Luau tables start at 1,
-- so all 256 slots stay in the array part and the store does not become a hash insert.

local __t0 = os.clock()
local slots = table.create(256, 0)
local total = 0

for i = 0, 9999999 do
    local buf = buffer.create(64)
    buffer.writeu8(buf, 0, i % 256)
    total = total + buffer.readu8(buf, 0)
    slots[(i % 256) + 1] = buf
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
