-- task 12 matrix_add — expected output: 999000000
-- build: none (interpreted)    run: lua 12_matrix_add.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 12_matrix_add.lua
-- Flat tables with index i*n+j+1 instead of nested tables.

local n = 1000
local size = n * n
local A, B, C = {}, {}, {}

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
