-- task 14 file_read — expected output: 2389704704
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 14_file_read.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: data.bin (50 MiB: bytes 0..255 repeating) must be in the working directory.
--       read_file(..., BINARY_MODE) is a byte-exact read: "rb" mode, one getc per byte,
--       so NUL bytes survive and nothing is translated. The sum is taken modulo 2^32 with
--       remainder(); the intermediate sum (about 6.7e9) fits in a 64-bit integer.

include std/dll.e
include std/machine.e
include std/io.e

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

sequence data
data = read_file("data.bin", BINARY_MODE)

integer total
total = 0
for i = 1 to length(data) do
    total = total + data[i]
end for
integer answer
answer = remainder(total, 4294967296)

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {answer})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
