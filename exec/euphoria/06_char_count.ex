-- task 06 char_count — expected output: 10000000
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 06_char_count.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: the 100 MB text is built by repeated doubling of the whole 10-char block (23
--       doublings give 83,886,080 chars, then one more block slice to reach 100,000,000),
--       never by appending one char at a time. It is scanned one byte at a time.
-- note: the 'a' and 'e' branches are empty (skip); only 'h' increments count.

include std/dll.e
include std/machine.e

atom k32, freq, buf, t0, t1, r, ms
integer pF, pC
k32 = open_dll("kernel32.dll")
pF = define_c_func(k32, "QueryPerformanceFrequency", {C_POINTER}, C_LONG)
pC = define_c_func(k32, "QueryPerformanceCounter", {C_POINTER}, C_LONG)
buf = allocate(8)
r = c_func(pF, {buf})
freq = peek8u(buf)
r = c_func(pC, {buf})
t0 = peek8u(buf)

sequence text
text = "abcdefghij"
for k = 1 to 23 do
    text = text & text
end for
text = text & text[1 .. 16113920]

integer count, ch
count = 0
for i = 1 to 100000000 do
    ch = text[i]
    if ch = 97 then
    elsif ch = 101 then
    elsif ch = 104 then
        count = count + 1
    end if
end for

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {count})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
