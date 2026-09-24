-- task 14 file_read — expected output: 484442112
-- build: none (interpreted)    run: lua main.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit main.lua
-- data.bin (100 MiB: the bytes 0..255 repeating) must sit in the working directory.
-- Read in 1 MiB chunks, then scan every byte.

local f = io.open("data.bin", "rb")

local total = 0
while true do
    local chunk = f:read(1048576)
    if not chunk then
        break
    end
    for i = 1, #chunk do
        total = total + string.byte(chunk, i)
    end
end

f:close()
print(total % 4294967296)
