-- task 15 file_write — expected output: 419430400
-- build: none (interpreted)    run: lua 15_file_write.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 15_file_write.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua
-- Buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 50 times per pass
-- over 8 passes (each pass reopening out.bin at offset 0).
-- Lua's standard library has no fsync; the file is flushed and closed instead, once per pass.

local __t0 = os.clock()
local part = {}
for i = 0, 255 do
    part[i + 1] = string.char(i)
end
local buf = string.rep(table.concat(part), 4096)

local written = 0
for _pass = 1, 8 do
    local f = io.open("out.bin", "wb")
    for _ = 1, 50 do
        f:write(buf)
        written = written + #buf
    end
    f:flush()
    f:close()
end
local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(written)
