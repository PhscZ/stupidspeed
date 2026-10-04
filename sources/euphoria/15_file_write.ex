-- task 15 file_write — expected output: 52428800
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 15_file_write.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times, built by doubling the
--       256-byte block 12 times, then written 50 times to out.bin. Euphoria exposes no
--       fsync; std/io.e's flush() pushes the C stream to the OS and close() flushes again,
--       so the file is complete before the answer is printed.

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

sequence unit, blk
integer fh, written
unit = ""
for i = 0 to 255 do
    unit = unit & i
end for
blk = unit
for k = 1 to 12 do
    blk = blk & blk
end for

fh = open("out.bin", "wb")
written = 0
for k = 1 to 50 do
    puts(fh, blk)
    written = written + length(blk)
end for
flush(fh)
close(fh)

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {written})
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
