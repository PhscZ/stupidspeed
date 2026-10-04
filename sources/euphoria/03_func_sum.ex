-- task 03 func_sum — expected output: 100000000
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 03_func_sum.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: Euphoria is interpreted by eui.exe and has no inliner or no-inline marker, so
--       add_one really is called 100,000,000 times. There is no separate-file trick that
--       changes that in an interpreter.

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

function add_one(integer n)
    return n + 1
end function

integer value
value = 0
for i = 1 to 100000000 do
    value = add_one(value)
end for

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {value})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
