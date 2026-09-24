-- task 13 matrix_mul — expected output: 599995000
-- build: none (interpreted)    run: lua 13_matrix_mul.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 13_matrix_mul.lua
-- Plain i, j, k triple loop in that order, flat tables with index i*n+j+1.

local n = 500
local size = n * n
local A, B, C = {}, {}, {}

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
