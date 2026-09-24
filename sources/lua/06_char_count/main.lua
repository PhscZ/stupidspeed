-- task 06 char_count — expected output: 10000000
-- build: none (interpreted)    run: lua main.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit main.lua
-- The 100 MB text is built once with string.rep, then scanned one character at a time.

local text = string.rep("abcdefghij", 10000000)

local count = 0
for i = 1, #text do
    local ch = string.byte(text, i)
    if ch == 97 then          -- 'a': skip
    elseif ch == 101 then     -- 'e': skip
    elseif ch == 104 then     -- 'h': count
        count = count + 1
    end
end

print(count)
