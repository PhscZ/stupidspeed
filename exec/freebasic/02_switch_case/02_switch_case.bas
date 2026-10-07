' task 02 switch_case -- expected output: 7500000075000000
' build: fbc -O 2 -x prog.exe 02_switch_case.bas    run: ./prog
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Built and run against FreeBASIC 1.10.1 on this machine, so the timing is real.
dim ss_t0 as double = timer
dim acc as longint = 0
dim i as longint

for i = 0 to 99999999
    select case (i mod 4)
        case 0
            acc += 1
        case 1
            acc += i
        case 2
            acc += 2 * i
        case 3
            acc += 3 * i
    end select
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(acc)
