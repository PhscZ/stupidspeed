-- task 05 alloc_churn — expected output: 1274991808
-- build: none (interpreted)    run: lua 05_alloc_churn.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 05_alloc_churn.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua
-- Lua strings are immutable, so each iteration builds a fresh 64-byte string; the slots
-- table keeps it reachable and drops the buffer it replaces.

local __t0 = os.clock()
local slots = {}
local total = 0

for i = 0, 9999999 do
    local buf = string.char(i % 256) .. string.rep("\0", 63)
    total = total + string.byte(buf)
    slots[(i % 256) + 1] = buf
end

local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(total)
