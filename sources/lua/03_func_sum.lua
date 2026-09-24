-- task 03 func_sum — expected output: 100000000
-- build: none (interpreted)    run: lua 03_func_sum.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 03_func_sum.lua
-- PUC Lua always interprets the call. LuaJIT may trace and inline add_one away, which is
-- a property of the JIT, not of this source; there is no no-inline directive in Lua.

local function add_one(n)
    return n + 1
end

local value = 0
for _ = 1, 100000000 do
    value = add_one(value)
end

print(value)
