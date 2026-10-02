-- task 04 array_sum — expected output: 499999500000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 04_array_sum.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 04_array_sum.luau
-- One flat table of 1000000 numbers, allocated up front with table.create so the fill loop does not
-- pay for table growth. Luau tables index from 1, so array[i + 1] holds the value the spec calls
-- array[i].

local size = 1000000
local array = table.create(size, 0)

for i = 0, size - 1 do
    array[i + 1] = i
end

local total = 0
for i = 0, size - 1 do
    total = total + array[i + 1]
end

print(total)
