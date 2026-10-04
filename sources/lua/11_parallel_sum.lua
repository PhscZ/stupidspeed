-- task 11 parallel_sum — expected output: 7500000075000000
-- build: none (interpreted)    run: lua 11_parallel_sum.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 11_parallel_sum.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua
-- note (wasm): the wasm row cannot use Lanes — it is a pthreads C extension with no wasm build —
-- so it builds sources/lua-wasm/11_parallel_sum.lua instead, whose four workers are coroutines.
-- Stock Lua has no threads, only cooperative coroutines, so this task needs the Lanes C
-- extension: luarocks install lanes (which itself needs a C compiler). Lane results are
-- read back through the lane handle, which joins the lane.

local __t0 = os.clock()
local lanes = require("lanes")
lanes = lanes.configure() or lanes

local function work(t)
    local acc = 0
    local first = t * 25000000
    local last = first + 25000000 - 1
    for i = first, last do
        local c = i % 4
        if c == 0 then
            acc = acc + 1
        elseif c == 1 then
            acc = acc + i
        elseif c == 2 then
            acc = acc + 2 * i
        else
            acc = acc + 3 * i
        end
    end
    return acc
end

local gen = lanes.gen("*", work)

local handles = {}
for t = 0, 3 do
    handles[t + 1] = gen(t)
end

local total = 0
for t = 1, 4 do
    total = total + handles[t][1]
end

-- string.format("%d", ...) so both runtimes print the full 16-digit total: LuaJIT's default
-- conversion is "%.14g" and would print 7.5e+15 for a value this large.
local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(string.format("%d", total))
