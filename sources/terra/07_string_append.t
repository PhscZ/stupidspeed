-- task 07 string_append — expected output: 1000000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 07_string_append.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: this is the row's slow cell and the quadratic the task is designed to measure. A Lua
--       string is immutable, `s .. "x"` allocates a fresh buffer and copies the whole
--       accumulator into it, and Terra has no second string type — a terra function that
--       wants text uses &int8 or int8[N], i.e. C char arrays, which have no append either.
--       So the loop is plain Lua and there is no append optimisation to disclose, unlike the
--       Raku, Erlang, Elixir, Seed7, Eiffel and Beef rows.
-- note: the loop is in Lua, not in a terra function, on purpose: putting it in native code
--       would mean hand-writing a growable buffer, which is a different program from the one
--       every other row writes.
-- note: measured on this host, best of 3 at each count: 12.73 us/append at 100000, 23.46 at
--       200000, 75.07 at 400000 — a clean quadratic, and slightly worse than n^2 past a few
--       hundred megabytes because the copy starts paying page faults. The full million was
--       run: 454.45 s, 465.66 GiB copied. temp/terra-doc.md §9.
-- note: `#text` is the printed value, so the loop cannot be deleted.

local text = ""
for i = 1, 1000000 do
    text = text .. "x"
end

print(string.format("%d", #text))
