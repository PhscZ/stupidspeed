-- task 13 matrix_mul — expected output: 599995000
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 13_matrix_mul.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: plain i, j, k triple loop in that order over flat 500x500 sequences (index i*n+j+1),
--       125 million multiply-adds, no reordering or blocking.

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

integer n, size, row, s, total
n = 500
size = n * n
sequence A, B, C
A = repeat(0, size)
B = repeat(0, size)
C = repeat(0, size)

for i = 0 to n - 1 do
    row = i * n
    for j = 0 to n - 1 do
        A[row + j + 1] = remainder(i + j, 7)
        B[row + j + 1] = remainder(i * j, 5)
    end for
end for

for i = 0 to n - 1 do
    row = i * n
    for j = 0 to n - 1 do
        s = 0
        for k = 0 to n - 1 do
            s = s + A[row + k + 1] * B[k * n + j + 1]
        end for
        C[row + j + 1] = s
    end for
end for

total = 0
for p = 1 to size do
    total = total + C[p]
end for

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {total})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
