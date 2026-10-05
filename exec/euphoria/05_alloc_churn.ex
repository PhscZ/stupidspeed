-- task 05 alloc_churn — expected output: 1274991808
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 05_alloc_churn.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: each 64-byte buffer is a fresh 64-element sequence (Euphoria's native byte-array
--       type); the 256-slot sequence keeps the buffer reachable and drops the one it
--       replaces, so the interpreter's reference-counted garbage collector does the churn.
--       total is an `integer`; the answer is exact.

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

sequence slots
slots = repeat(0, 256)
integer total
total = 0
for i = 0 to 9999999 do
    sequence b
    b = repeat(0, 64)
    b[1] = remainder(i, 256)
    total = total + b[1]
    slots[remainder(i, 256) + 1] = b
end for

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {total})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
