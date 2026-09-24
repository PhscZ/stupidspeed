-- task 05 alloc_churn — expected output: 1274991808
-- build: none (interpreted)    run: lua main.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit main.lua
-- Lua strings are immutable, so each iteration builds a fresh 64-byte string; the slots
-- table keeps it reachable and drops the buffer it replaces.

local slots = {}
local total = 0

for i = 0, 9999999 do
    local buf = string.char(i % 256) .. string.rep("\0", 63)
    total = total + string.byte(buf)
    slots[(i % 256) + 1] = buf
end

print(total)
