-- task 13 matrix_mul — expected output: 599995000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 13_matrix_mul.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 13_matrix_mul.luau
-- Plain i, j, k triple loop in that order, 125 million multiply-adds, flat tables indexed
-- i * n + j + 1. Reordering the loops would be faster; that is the point of the task.

local n = 500
local size = n * n
local A = table.create(size, 0)
local B = table.create(size, 0)
local C = table.create(size, 0)

for i = 0, n - 1 do
    local row = i * n
    for j = 0, n - 1 do
        A[row + j + 1] = (i + j) % 7
        B[row + j + 1] = (i * j) % 5
    end
end

for i = 0, n - 1 do
    local row = i * n
    for j = 0, n - 1 do
        local sum = 0
        for k = 0, n - 1 do
            sum = sum + A[row + k + 1] * B[k * n + j + 1]
        end
        C[row + j + 1] = sum
    end
end

local total = 0
for p = 1, size do
    total = total + C[p]
end

print(total)
