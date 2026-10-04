# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: ring 03_func_sum.ring
# note: add_one lives in 03_func_sum_add_one.ring, a real second file. load is executed by
#       the compiler in the parsing stage, so the helper is included at compile time and the
#       function is not defined in this file at all.
# note: Ring has no no-inline marker and needs none: the source is compiled to bytecode and
#       run on the VM, and the VM never inlines a call, so all 100000000 calls are real
#       interpreted calls.
# note: a Ring source file has three sections in order — load lines, top-level statements,
#       functions — so the load is first and the loop follows it.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

load "03_func_sum_add_one.ring"

ssT0 = clock()
value = 0

for i = 0 to 99999999
    value = add_one(value)
next

ssReport()
? value

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
