-- task 15 file_write — expected output: 104857600
-- build: none (interpreted)    run: lua main.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit main.lua
-- Buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 100 times.
-- Lua's standard library has no fsync; the file is flushed and closed instead.

local part = {}
for i = 0, 255 do
    part[i + 1] = string.char(i)
end
local buf = string.rep(table.concat(part), 4096)

local f = io.open("out.bin", "wb")

local written = 0
for _ = 1, 100 do
    f:write(buf)
    written = written + #buf
end

f:flush()
f:close()
print(written)
