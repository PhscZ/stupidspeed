' task 11 parallel_sum -- expected output: 7500000075000000
' build: fbc -O 2 -x prog.exe 11_parallel_sum.bas    run: ./prog
' task 11 - four real threads
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
#define NT 4
#define SPAN 25000000

dim shared res(0 to NT-1) as longint

sub worker(byval p as any ptr)
    dim t as longint = cast(longint, p)
    dim i as longint
    dim acc as longint = 0
    dim lo as longint = t * SPAN
    dim hi as longint = lo + SPAN - 1
    for i = lo to hi
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
    res(t) = acc
end sub

dim ss_t0 as double = timer
dim h(0 to NT-1) as any ptr
dim k as integer
for k = 0 to NT-1
    h(k) = threadcreate(@worker, cast(any ptr, k))
next
for k = 0 to NT-1
    threadwait(h(k))
next

dim total as longint = 0
for k = 0 to NT-1
    total += res(k)
next
dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(total)
