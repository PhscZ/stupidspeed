' task 05 alloc_churn -- expected output: 1274991808
' build: fbc -O 2 -x prog.exe 05_alloc_churn.bas    run: ./prog
' FreeBASIC has no garbage collector, so the slot store deallocates the buffer it
' replaces: that is the "free the old one" branch of the C reference.
const N as integer = 10000000

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

print str(total)
