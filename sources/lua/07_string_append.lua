-- task 07 string_append — expected output: 250000
-- build: none (interpreted)    run: lua 07_string_append.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 07_string_append.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua
-- Lua strings are immutable, so every append copies the whole string.

local __t0 = os.clock()
local text = ""
for _ = 1, 250000 do
    text = text .. "x"
end

local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(#text)
