' task 12 matrix_add -- expected output: 999000000
' build: fbc -O 2 -x prog.exe 12_matrix_add.bas    run: ./prog
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
const N as integer = 1000

' `shared` puts the 8 MB arrays in static storage; plain `dim` overflows the stack.
dim shared a(0 to N - 1, 0 to N - 1) as longint
dim shared b(0 to N - 1, 0 to N - 1) as longint
dim shared c(0 to N - 1, 0 to N - 1) as longint
dim ss_t0 as double = timer
dim i as integer
dim j as integer
dim total as longint = 0

for i = 0 to N - 1
    for j = 0 to N - 1
        a(i, j) = i + j
        b(i, j) = i - j
    next
next

for i = 0 to N - 1
    for j = 0 to N - 1
        c(i, j) = a(i, j) + b(i, j)
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
