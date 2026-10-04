' task 13 matrix_mul -- expected output: 599995000
' build: fbc -O 2 -x prog.exe 13_matrix_mul.bas    run: ./prog
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
const N as integer = 500

' `shared` puts the 2 MB arrays in static storage; plain `dim` overflows the stack.
dim shared a(0 to N - 1, 0 to N - 1) as longint
dim shared b(0 to N - 1, 0 to N - 1) as longint
dim shared c(0 to N - 1, 0 to N - 1) as longint
dim ss_t0 as double = timer
dim i as integer
dim j as integer
dim k as integer
dim acc as longint
dim total as longint = 0

for i = 0 to N - 1
    for j = 0 to N - 1
        a(i, j) = (i + j) mod 7
        b(i, j) = (i * j) mod 5
    next
next

for i = 0 to N - 1
    for j = 0 to N - 1
        acc = 0
        for k = 0 to N - 1
            acc += a(i, k) * b(k, j)
        next
        c(i, j) = acc
    next
next

for i = 0 to N - 1
    for j = 0 to N - 1
        total += c(i, j)
    next
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(total)
