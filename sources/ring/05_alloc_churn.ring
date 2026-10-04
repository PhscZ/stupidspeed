# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)    run: ring 05_alloc_churn.ring
# note: Ring has no malloc, so the 64-byte allocation primitive is a 64-byte string:
#       space(64) allocates exactly 64 bytes and fills them. buf[1] is the byte the C row
#       writes into buf[0], and ascii(buf[1]) is the read back; Ring strings are mutable by
#       index.
# note: slots[i % 256 + 1] = buf is a deep copy in Ring — lists and strings are stored by
#       value — so the slot keeps its own 64 bytes and the buffer it replaces becomes garbage
#       for the collector. That is the reachability the C row gets from keeping the pointer
#       in the slot and calling free on the one it drops.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

ssT0 = clock()
slots = list(256)
total = 0

for i = 0 to 9999999
    buf = space(64)
    buf[1] = char(i % 256)
    total = total + ascii(buf[1])
    slots[i % 256 + 1] = buf
next

ssReport()
? total

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
