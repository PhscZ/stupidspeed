-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none (interpreted)    run: lua main.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit main.lua

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

print(a .. " " .. b .. " " .. c .. " " .. d)
