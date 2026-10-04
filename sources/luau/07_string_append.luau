-- task 07 string_append — expected output: 250000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 07_string_append.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 07_string_append.luau
-- One character appended per iteration, 250000 times. Luau strings are immutable and there is no
-- growable string type, so each append copies the whole string and the task is quadratic; a string
-- buffer would have to be an explicit table of chunks, which is a different program.

local __t0 = os.clock()
local text = ""
for _ = 1, 250000 do
    text = text .. "x"
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
print(#text)
