' task 07 string_append -- expected output: 250000
' build: fbc -O 2 -x prog.exe 07_string_append.bas    run: ./prog
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
dim ss_t0 as double = timer
dim text as string = ""
dim i as longint

for i = 1 to 250000
    text &= "x"
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(len(text))
