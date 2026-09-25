' task 11 parallel_sum -- expected output: 7500000075000000
' build: fbc -O 2 -x 11_parallel_sum.bas    run: ./11_parallel_sum.exe
' task 11 - four real threads
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
print str(total)
