-- task 03 func_sum — expected output: 100000000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 03_func_sum.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 03_func_sum.luau
-- The plain Luau CLI interprets bytecode with no JIT, so the call happens 100000000 times; the
-- compiler is left at its default -O1, which does not inline this one. Luau has no no-inline
-- directive, so nothing marks the function, the same caveat the Lua row carries.

local __t0 = os.clock()
local function add_one(n)
    return n + 1
end

local value = 0
for _ = 1, 100000000 do
    value = add_one(value)
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
print(value)
