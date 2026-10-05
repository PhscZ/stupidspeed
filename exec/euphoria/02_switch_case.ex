-- task 02 switch_case — expected output: 7500000075000000
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 02_switch_case.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: Euphoria has no switch statement, so the four cases are an if/elsif chain on
--       remainder(i, 4), the same shape as the other interpreted rows.
-- note: acc is an `integer` (64-bit), so the 16-digit total 7500000075000000 is exact;
--       printf "%d" prints it in full.

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

integer acc, c
acc = 0
for i = 0 to 99999999 do
    c = remainder(i, 4)
    if c = 0 then
        acc = acc + 1
    elsif c = 1 then
        acc = acc + i
    elsif c = 2 then
        acc = acc + 2 * i
    else
        acc = acc + 3 * i
    end if
end for

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {acc})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
