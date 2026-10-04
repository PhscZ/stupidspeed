' task 08 average -- expected output: 0.498046875
' build: fbc -O 2 -x prog.exe 08_average.bas    run: ./prog
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
dim ss_t0 as double = timer
dim total as double = 0.0
dim reading as double
dim i as longint

for i = 0 to 99999999
    reading = (i mod 256) / 256.0
    total += reading
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(total / 100000000)
