-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 01_branches.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 01_branches.luau
-- note: the four counters are printed with explicit spaces, not by print's argument separator,
--       which is a tab in Luau.
-- note: Luau numbers are IEEE doubles, so these counters are exact up to 2^53; 33333334 and
--       45714285 are well inside that.

local __t0 = os.clock()
local a, b, c, d = 0, 0, 0, 0

for i = 0, 99999999 do
    if i % 3 == 0 then
        a = a + 1
    elseif i % 5 == 0 then
        b = b + 1
    elseif i % 7 == 0 then
        c = c + 1
    else
        d = d + 1
    end
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
print(a .. " " .. b .. " " .. c .. " " .. d)
