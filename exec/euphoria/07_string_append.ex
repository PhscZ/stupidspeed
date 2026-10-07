-- task 07 string_append — expected output: 250000
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 07_string_append.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: Euphoria sequences are value types with no growable string, so `text & "x"`
--       copies the whole sequence every time; the loop is quadratic, as the task intends.
--       The count is 250,000, not a million.

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
text = ""
for i = 1 to 250000 do
    text = text & "x"
end for

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {length(text)})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
