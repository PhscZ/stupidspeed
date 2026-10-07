-- task 08 average — expected output: 0.498046875
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 08_average.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: Euphoria `atom` is an IEEE double. Each reading is an exact multiple of 1/256 and
--       the total stays well below 2^53, so the sum is exact and the printed digits do not
--       depend on summation order. "%.9f" prints the full 0.498046875.

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

atom total, reading
total = 0.0
for i = 0 to 99999999 do
    reading = remainder(i, 256) / 256.0
    total = total + reading
end for
atom avg
avg = total / 100000000

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%.9f\n", {avg})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
