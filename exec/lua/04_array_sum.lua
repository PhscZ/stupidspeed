-- task 04 array_sum — expected output: 599999940000000
-- build: none (interpreted)    run: lua 04_array_sum.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 04_array_sum.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua

local __t0 = os.clock()
local n = 10000000
local array = {}

for i = 1, n do
    array[i] = i - 1
end

local total = 0
for r = 1, 12 do
    for i = 1, n do
        total = total + array[i]
    end
end

local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
-- %.0f, not the default %g: LuaJIT holds the sum as a double (Lua 5.1 has no
-- integer type) and %g prints it as 5.9999994e+14, where the expected line is
-- the integer. PUC Lua 5.4 prints the same digits either way.
print(string.format("%.0f", total))
