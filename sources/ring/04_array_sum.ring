# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: ring 04_array_sum.ring
# note: list(n) allocates the million slots up front, the way the C row's malloc does. A
#       Ring list item is a full Item, not a machine word, so this is a million boxed
#       doubles rather than a million int64s; the algorithm is the same either way.
# note: Ring lists are 1-based, so a[i] holds the value i-1 and the sum is still 0..999999.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

ssT0 = clock()
n = 1000000
a = list(n)

for i = 1 to n
    a[i] = i - 1
next

total = 0

for i = 1 to n
    total = total + a[i]
next

ssReport()
? total

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
