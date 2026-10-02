-- task 12 matrix_add — expected output: 999000000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 12_matrix_add.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 12_matrix_add.luau
-- Three flat tables of 1000000 numbers instead of nested tables, indexed i * n + j + 1, so each
-- matrix is one contiguous block of the array part and the walk is sequential. The three are 24 MB
-- together, well past cache.

local n = 1000
local size = n * n
local A = table.create(size, 0)
local B = table.create(size, 0)
local C = table.create(size, 0)

for i = 0, n - 1 do
    local row = i * n
    for j = 0, n - 1 do
        A[row + j + 1] = i + j
        B[row + j + 1] = i - j
    end
end

for p = 1, size do
    C[p] = A[p] + B[p]
end

local total = 0
for p = 1, size do
    total = total + C[p]
end

print(total)
