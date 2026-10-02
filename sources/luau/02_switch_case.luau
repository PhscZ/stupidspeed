-- task 02 switch_case — expected output: 7500000075000000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 02_switch_case.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 02_switch_case.luau
-- Luau has no switch statement, so the four cases are an if/elseif chain on i % 4, the closest
-- thing to a switch the language has (a dispatch table of closures would add a function call per
-- iteration and measure task 03 instead).
-- The total is 7500000075000000, which is under 2^53, so the double accumulator is exact. Luau
-- prints an integral double in full rather than as 7.5e+15, so no string.format is needed.

local acc = 0

for i = 0, 99999999 do
    local c = i % 4
    if c == 0 then
        acc = acc + 1
    elseif c == 1 then
        acc = acc + i
    elseif c == 2 then
        acc = acc + 2 * i
    else
        acc = acc + 3 * i
    end
end

print(acc)
