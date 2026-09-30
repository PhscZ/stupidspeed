-- task 05 alloc_churn — expected output: 1274991808
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 05_alloc_churn.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: this is the row's one deliberate interpreter-speed cell. The allocation is
--       terralib.new(uint8[64]), which is LuaJIT's ffi.new and therefore a GC-managed cdata;
--       the loop is plain Lua. Terra's strings, tables, functions and cdata are all
--       LuaJIT-managed, so this is the language's natural allocator and the collector the
--       task exists to measure. Measured on this host: 1449.6 ns per allocation, 14.5 s for
--       the ten million.
-- note: there is a 58x faster route — the loop in terra code with the Windows heap
--       (HeapAlloc/HeapFree, 25.3 ns per allocation, 0.25 s) — and it was measured and
--       rejected. It bypasses the collector entirely, and task 05's subject is the collector.
--       The C, Beef and Assembly rows take the manually-managed route because those
--       languages have no collector; Terra does. temp/terra-doc.md §11 has both numbers.
-- note: the buffer is NOT leaked. The working set stays flat at 201-230 MB across the ten
--       million allocations, and an explicit collectgarbage("collect") takes it back down.
--       The premise that terralib.new memory is never freed is wrong: it is ffi.new.
-- note: `slots[i % 256] = buf` is what keeps the buffer reachable and drops the one it
--       replaces, exactly as the spec requires; without it the allocation would be dead and
--       LuaJIT's collector would reclaim it immediately.

local slots = {}
for i = 0, 255 do
    slots[i] = nil
end

local total = 0
for i = 0, 9999999 do
    local buf = terralib.new(uint8[64])
    buf[0] = i % 256
    total = total + buf[0]
    slots[i % 256] = buf
end

print(string.format("%d", total))
