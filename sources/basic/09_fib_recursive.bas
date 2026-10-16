' task 09 fib_recursive -- expected output: 102334155
' build: fbc -O 2 -x prog.exe 09_fib_recursive.bas    run: ./prog
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Built and run against FreeBASIC 1.10.1 on this machine, so the timing is real.
dim ss_t0 as double = timer

function fib(byval n as longint) as longint
    if n < 2 then return n
    return fib(n - 1) + fib(n - 2)
end function

dim ss_r as longint = fib(40)
dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(ss_r)
