-- task 08 average — expected output: 0.498046875
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 08_average.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 08_average.luau
-- Every reading is a multiple of 1/256, which is exact in binary, and the running total stays well
-- under 2^53, so the sum is exact whatever the order. Luau has one number type, the IEEE double.

local total = 0.0
for i = 0, 99999999 do
    local reading = (i % 256) / 256.0
    total = total + reading
end

print(total / 100000000)
