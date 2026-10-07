-- task 08 average — expected output: 0.498046875
-- build: none (interpreted)    run: lua 08_average.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 08_average.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua

local __t0 = os.clock()
local total = 0.0
for i = 0, 99999999 do
    local reading = (i % 256) / 256.0
    total = total + reading
end

local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(string.format("%.9f", total / 100000000))
