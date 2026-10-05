-- task 09 fib_recursive — expected output: 102334155
-- build: none (interpreted)    run: lua 09_fib_recursive.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 09_fib_recursive.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua

local __t0 = os.clock()
local function fib(n)
    if n < 2 then
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

local __result = fib(40)
local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(__result)
