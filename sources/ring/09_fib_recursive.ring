# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: ring 09_fib_recursive.ring
# note: naive recursion, no memoisation, exactly the C row's shape. Every one of the ~331
#       million calls is an interpreted call, which is why this is one of the slow cells.
# note: Ring numbers are doubles; fib(40) = 102334155 is exact.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

ssT0 = clock()
# the work is evaluated into a variable first: computing it inside the output
# argument would place all 331 million calls after the timer stops.
ssR = fib(40)
ssReport()
? ssR

func fib n
    if n < 2
        return n
    ok
    return fib(n - 1) + fib(n - 2)

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
