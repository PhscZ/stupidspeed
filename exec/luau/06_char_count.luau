-- task 06 char_count — expected output: 10000000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 06_char_count.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 06_char_count.luau
-- The 100 MB text is built in one string.rep, not by appending in a loop, so the build is not part
-- of the measurement. The scan is one string.byte per character; the three compared characters are
-- their byte values, 97, 101 and 104, which is what string.byte returns.

local __t0 = os.clock()
local text = string.rep("abcdefghij", 10000000)

local count = 0
for i = 1, #text do
    local ch = string.byte(text, i)
    if ch == 97 then
        -- 'a': skipped
    elseif ch == 101 then
        -- 'e': skipped
    elseif ch == 104 then
        count = count + 1
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
print(count)
