' task 03 func_sum -- expected output: 100000000
' build: fbc -O 2 -x prog.exe 03_func_sum.bas 03_func_sum_add_one.bas    run: ./prog
' task 03 - function call overhead, no-inline via separate module
' add_one lives in add_one.bas and is compiled separately so the call is real.
declare function add_one(byval n as longint) as longint

' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Built and run against FreeBASIC 1.10.1 on this machine, so the timing is real.
dim ss_t0 as double = timer
dim v as longint = 0
dim i as longint

for i = 0 to 99999999
    v = add_one(v)
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(v)
