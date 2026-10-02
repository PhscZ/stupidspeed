-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 01_branches.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 01_branches.luau
-- note: the four counters are printed with explicit spaces, not by print's argument separator,
--       which is a tab in Luau.
-- note: Luau numbers are IEEE doubles, so these counters are exact up to 2^53; 33333334 and
--       45714285 are well inside that.

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

print(a .. " " .. b .. " " .. c .. " " .. d)
