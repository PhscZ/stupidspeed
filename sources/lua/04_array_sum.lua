-- task 04 array_sum — expected output: 499999500000
-- build: none (interpreted)    run: lua 04_array_sum.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 04_array_sum.lua

local n = 1000000
local array = {}

for i = 1, n do
    array[i] = i - 1
end

local total = 0
for i = 1, n do
    total = total + array[i]
end

print(total)
