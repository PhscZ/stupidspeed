# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: ring 01_branches.ring
# note: Ring has one number type, a double, so the four counters are doubles holding whole
#       values far below 2^53. Every value here is exact and the final line is printed by
#       the engine's integral path (see 02_switch_case.ring).
# note: i % 3 is fmod on doubles; for whole numbers this small it is exact.
# note: the print needs the leading "" so the expression is a string concatenation. Ring's +
#       converts its string operand to a number, so ? a + " " + b stops with "Invalid numeric
#       string"; the empty string first forces the string path.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

ssT0 = clock()
a = 0
b = 0
c = 0
d = 0

for i = 0 to 99999999
    if i % 3 = 0
        a = a + 1
    elseif i % 5 = 0
        b = b + 1
    elseif i % 7 = 0
        c = c + 1
    else
        d = d + 1
    ok
next

ssReport()
? "" + a + " " + b + " " + c + " " + d

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
