' task 04 array_sum -- expected output: 499999500000
' build: fbc -O 2 -x prog.exe 04_array_sum.bas    run: ./prog
' `shared` puts the array in static storage: a plain `dim` of 8 MB would overflow
' the default 1 MB thread stack and the process would die with no output.
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
dim shared arr(0 to 999999) as longint
dim ss_t0 as double = timer
dim i as longint
dim total as longint = 0

for i = 0 to 999999
    arr(i) = i
next

for i = 0 to 999999
    total += arr(i)
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(total)
