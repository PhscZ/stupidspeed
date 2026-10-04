# task 07 string_append — expected output: 250000
# build: none (interpreted)    run: ring 07_string_append.ring
# note: this is the spec's text = text + "x" form, and it is quadratic in Ring: + appends
#       the right operand into a copy of the left one, and the assignment then copies that
#       result back into the variable, so every one of the 250000 iterations copies the
#       whole accumulated string twice.
# note: Ring's += operator is deliberately NOT used. += appends straight into the variable's
#       own string object, which doubles its capacity as needed (Ring's own release notes
#       advertise it as 60x faster than the old behaviour). Using it would turn this cell
#       into a linear one and would not be the task the other rows run.
# note: see RUN.md for the measured cost of this cell.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

ssT0 = clock()
text = ""

for i = 1 to 250000
    text = text + "x"
next

ssReport()
? len(text)

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
