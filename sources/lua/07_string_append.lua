-- task 07 string_append — expected output: 1000000
-- build: none (interpreted)    run: lua 07_string_append.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 07_string_append.lua
-- Lua strings are immutable, so every append copies the whole string.

local text = ""
for _ = 1, 1000000 do
    text = text .. "x"
end

print(#text)
