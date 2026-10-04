# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: ring 08_average.ring
# note: decimals(9) is set before the print because Ring's default is 2 decimals, which
#       would round the answer to 0.50. decimals() only affects the non-integral branch of
#       the number-to-string conversion, so the integer cells in this row are unaffected.
# note: i % 256 and the division by 256.0 are double operations, like the C row's; the total
#       is a double from the start.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

ssT0 = clock()
total = 0.0

for i = 0 to 99999999
    reading = (i % 256) / 256.0
    total = total + reading
next

decimals(9)
ssReport()
? total / 100000000

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
