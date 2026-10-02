-- task 11 parallel_sum — expected output: 7500000075000000
-- build: none (interpreted)    run: C:\stupidspeed\tools\lute\lute.exe run 11_parallel_sum.luau
-- note: THIS FILE NEEDS LUTE, NOT luau.exe. Luau has no threads, and the plain Luau CLI cannot
--       start a process either: it exposes no io library, no os.execute and no package/loadfile
--       (its os is {clock, date, difftime, time}), and its coroutines are cooperative and
--       single-threaded. So the four workers are four child processes, one per quarter of the
--       range, each handed its worker index as an argument and read back through its stdout -
--       exactly the route the VBScript and JScript rows take.
--       Lute, the Luau team's own runtime (github.com/luau-lang/lute, release v1.0.0,
--       lute-windows-x86_64.zip, tools/lute/lute.exe), supplies the two things that are missing:
--       @lute/process.run runs a program and captures its stdout, and process.run yields on Lute's
--       task scheduler, so four of them are in flight at the same time. Measured on this host:
--       the four children concurrent take 5.5 s of wall clock against 11.2 s for the same four
--       children started one after another, so this is real parallelism across four cores, the
--       same category as the VBScript, JScript, R and Octave rows.
--       They are OS processes, not threads: no shared memory, no locking. Each worker owns a fixed
--       range, so the total does not depend on the order they finish in.
-- note: run with no argument this is the parent; a child is `lute run 11_parallel_sum.luau <t>`,
--       which prints one number. The parent sums the four numbers it reads back from stdout.

local process = require("@lute/process")
local task = require("@lute/task")

local RANGE = 25000000

-- Task 02's switch over one fixed quarter of the range.
local function work(t)
    local acc = 0
    local lo = t * RANGE
    for i = lo, lo + RANGE - 1 do
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

local t = tonumber(process.args[2])
if t then
    -- child: run one quarter and print it for the parent to read
    print(work(t))
    return
end

local exe = process.execPath()
local script = process.args[1]
local results = {}

local function child(i)
    local r = process.run({ exe, "run", script, tostring(i) })
    if not r.ok then
        error("worker " .. i .. " exited " .. tostring(r.exitcode) .. ": " .. r.stderr)
    end
    results[i] = tonumber(r.stdout)
end

-- process.run yields while the child runs, so all four children are alive at once.
local threads = {}
for i = 0, 3 do
    threads[i + 1] = task.spawn(child, i)
end
while true do
    local alive = false
    for i = 1, 4 do
        if coroutine.status(threads[i]) ~= "dead" then
            alive = true
        end
    end
    if not alive then
        break
    end
    task.wait()
end

local total = 0
for i = 0, 3 do
    total = total + results[i]
end

print(total)
