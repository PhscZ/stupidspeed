-- task 15 file_write — expected output: 52428800
-- build: none (interpreted)    run: lua 15_file_write.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 15_file_write.lua
-- Buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 50 times.
-- Lua's standard library has no fsync; the file is flushed and closed instead.

local part = {}
for i = 0, 255 do
    part[i + 1] = string.char(i)
end
local buf = string.rep(table.concat(part), 4096)

local f = io.open("out.bin", "wb")

local written = 0
for _ = 1, 50 do
    f:write(buf)
    written = written + #buf
end

f:flush()
f:close()
print(written)
