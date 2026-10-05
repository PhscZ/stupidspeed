-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none (interpreted)    run: lua 01_branches.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 01_branches.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua

local __t0 = os.clock()
local a, b, c, d = 0, 0, 0, 0

for i = 0, 99999999 do
    if i % 3 == 0 then
        a = a + 1
    elseif i % 5 == 0 then
        b = b + 1
    elseif i % 7 == 0 then
        c = c + 1
    else
        d = d + 1
    end
end

local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(a .. " " .. b .. " " .. c .. " " .. d)
