-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 01_branches.ex
-- timing: QueryPerformanceCounter via kernel32 FFI (std/dll.e + std/machine.e).
--         Euphoria cannot reach stderr in this build (printf(2,..) and puts(2,..) write
--         nothing), so TIME_MS goes to time.txt in the working directory, per the contract's
--         fallback; stdout carries only the answer.
-- note: `remainder(i, 3)` is the modulo for the non-negative loop index here. The four
--       counters are Euphoria `integer`s, which are 64-bit and exact.

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

integer a, b, c, d
a = 0
b = 0
c = 0
d = 0
for i = 0 to 99999999 do
    if remainder(i, 3) = 0 then
        a = a + 1
    elsif remainder(i, 5) = 0 then
        b = b + 1
    elsif remainder(i, 7) = 0 then
        c = c + 1
    else
        d = d + 1
    end if
end for

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d %d %d %d\n", {a, b, c, d})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
