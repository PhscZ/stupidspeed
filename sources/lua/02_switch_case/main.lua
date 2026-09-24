-- task 02 switch_case — expected output: 7500000075000000
-- build: none (interpreted)    run: lua main.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit main.lua
-- Lua has no switch statement, so the four cases are an if/elseif chain on i % 4, the
-- closest thing to a switch the language has (a dispatch table of closures would add a
-- function call per iteration and measure task 03 instead).

-- string.format("%d", ...) rather than print(acc): PUC Lua 5.4 keeps the total a 64-bit
-- integer and prints it in full, but LuaJIT has only doubles and its default conversion is
-- "%.14g", which would print this 16-digit total as 7.5e+15. The value is exact in both.

local acc = 0
for i = 0, 99999999 do
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

print(string.format("%d", acc))
