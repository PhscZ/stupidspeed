' task 01 branches -- expected output: 33333334 13333333 7619048 45714285
' build: fbc -O 2 -x prog.exe 01_branches.bas    run: ./prog
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
dim ss_t0 as double = timer
dim a as longint = 0
dim b as longint = 0
dim c as longint = 0
dim d as longint = 0
dim i as longint

for i = 0 to 99999999
    if (i mod 3) = 0 then
        a += 1
    elseif (i mod 5) = 0 then
        b += 1
    elseif (i mod 7) = 0 then
        c += 1
    else
        d += 1
    end if
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(a) & " " & str(b) & " " & str(c) & " " & str(d)
