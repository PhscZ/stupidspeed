# task 15 file_write — expected output: 52428800
# build: none (interpreted)    run: ring 15_file_write.ring
# note: out.bin is written into the working directory, 52428800 bytes.
# note: the 1 MiB buffer is bytes 0..255 repeated 4096 times, and it is built the way the
#       spec asks: the 256-byte pattern is described once as 512 hex digits, copy() repeats
#       it 4096 times in a single call, and hex2str() turns the 2 MB of hex into the
#       binary-safe 1048576-byte string. An append loop cannot be used here, because Ring
#       concatenation is length-based and would truncate at the first NUL byte (byte 0);
#       copy() and hex2str() both work on explicit string sizes.
# note: the count printed is fwrite's own return value, summed over the 50 writes, not a
#       constant.
# note: Ring's file API has fflush and fclose but no fsync, so fflush + fclose is the whole
#       flush story — the same deviation the VBScript row records.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Instrumented by inspection: Ring is not installed on this machine, so this
#         row's timing is unverified.

ssT0 = clock()
pat = ""

for i = 0 to 255
    pat = pat + right("0" + hex(i), 2)
next

buf = hex2str(copy(pat, 4096))

fp = fopen("out.bin", "wb")
written = 0

for i = 1 to 50
    written = written + fwrite(fp, buf)
next

fflush(fp)
fclose(fp)

ssReport()
? written

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
