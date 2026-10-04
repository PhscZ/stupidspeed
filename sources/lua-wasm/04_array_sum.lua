-- task 04 array_sum — expected output: 499999500000
-- build: none (interpreted)    run: lua 04_array_sum.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 04_array_sum.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua

local __t0 = os.clock()
local n = 1000000
local array = {}

for i = 1, n do
    array[i] = i - 1
end

local total = 0
for i = 1, n do
    total = total + array[i]
end

local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(total)
