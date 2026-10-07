# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: ring 06_char_count.ring
# note: copy("abcdefghij", 10000000) builds the whole 100000000-character text in one call,
#       which is the block repeat the spec asks for rather than an append loop.
# note: for ch in text walks the string one character at a time and hands back a fresh
#       1-character string per step, the analogue of the C row's char.
# note: Ring has no continue, so 'a' and 'e' are handled by empty branches of the same
#       if/elseif chain — the same control flow the C row's continue produces.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Verified on this machine with Ring 1.27: all fifteen tasks print the expected
#         line and write time.txt.

ssT0 = clock()
text = copy("abcdefghij", 10000000)
count = 0

for ch in text
    if ch = "a"
    elseif ch = "e"
    elseif ch = "h"
        count = count + 1
    ok
next

ssReport()
? count

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
