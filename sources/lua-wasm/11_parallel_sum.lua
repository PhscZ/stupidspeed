-- task 11 parallel_sum — expected output: 7500000075000000
-- build: lua.wasm is the wasm32-wasip1 build of PUC Lua 5.4.8 (see BUILD.md); run:
--   wasmtime -W exceptions=y --dir . lua.wasm 11_parallel_sum.lua
-- note: this is the wasm row, and it cannot use the Lanes extension the native row uses:
-- Lanes is a C extension over pthreads and there is no wasm build of it, so the four workers
-- are the language's own cooperative coroutines. They interleave, they each own one fixed
-- quarter, and the total is right, but nothing runs in parallel — the same disposition the
-- Simula row carries for its cooperative PROCESS objects. The native Lua rows keep Lanes.

local __t0 = os.clock()
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

-- Four workers, one fixed quarter each, resumed round-robin until all four have finished.
local workers = {}
for t = 0, 3 do
    workers[t + 1] = coroutine.create(function() return work(t) end)
end

local total = 0
local finished = 0
while finished < 4 do
    for t = 1, 4 do
        if coroutine.status(workers[t]) ~= "dead" then
            local ok, value = coroutine.resume(workers[t])
            if not ok then error(value) end
            if coroutine.status(workers[t]) == "dead" then
                total = total + value
                finished = finished + 1
            end
        end
    end
end

-- string.format("%d", ...) so the full 16-digit total prints: the default conversion is "%.14g".
local __t1 = os.clock()
io.stderr:write(string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
print(string.format("%d", total))
