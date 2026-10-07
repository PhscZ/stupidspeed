-- task 06 char_count — expected output: 10000000
-- build: none (interpreted)    run: lua 06_char_count.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 06_char_count.lua
-- build (wasm): lua.wasm is the wasm32-wasip1 build of this same interpreter (see BUILD.md); run: wasmtime -W exceptions=y --dir . lua.wasm <task>.lua
-- The 100 MB text is built once with string.rep, then scanned one character at a time.

local __t0 = os.clock()
local text = string.rep("abcdefghij", 10000000)

local count = 0
for i = 1, #text do
    local ch = string.byte(text, i)
    if ch == 97 then          -- 'a': skip
    elseif ch == 101 then     -- 'e': skip
    elseif ch == 104 then     -- 'h': count
        count = count + 1
    end
end

local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(count)
