' task 05 alloc_churn -- expected output: 1274991808
' build: fbc -O 2 -x prog.exe 05_alloc_churn.bas    run: ./prog
' FreeBASIC has no garbage collector, so the slot store deallocates the buffer it
' replaces: that is the "free the old one" branch of the C reference.
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Instrumented by inspection:
'         there is no FreeBASIC toolchain on this machine, so this row's timing is unverified.
const N as integer = 10000000
dim ss_t0 as double = timer

dim slots(0 to 255) as any ptr
dim total as longint = 0
dim i as longint
dim k as integer

for i = 0 to N - 1
    dim buf as ubyte ptr = allocate(64)
    buf[0] = i mod 256
    total += buf[0]
    k = i mod 256
    if slots(k) <> 0 then deallocate(slots(k))
    slots(k) = buf
next

for k = 0 to 255
    if slots(k) <> 0 then deallocate(slots(k))
next

dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(total)
