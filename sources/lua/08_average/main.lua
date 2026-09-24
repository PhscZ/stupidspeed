-- task 08 average — expected output: 0.498046875
-- build: none (interpreted)    run: lua main.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit main.lua

local total = 0.0
for i = 0, 99999999 do
    local reading = (i % 256) / 256.0
    total = total + reading
end

print(string.format("%.9f", total / 100000000))
