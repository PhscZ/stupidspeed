-- task 09 fib_recursive — expected output: 102334155
-- build: none (interpreted)    run: lua 09_fib_recursive.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 09_fib_recursive.lua

local function fib(n)
    if n < 2 then
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

print(fib(40))
