# task 14 file_read — expected output: 2389704704
# build: none (interpreted)    run: ring 14_file_read.ring
# note: data.bin must be in the working directory: 52428800 bytes, the bytes 0 through 255
#       repeating. fopen resolves a relative path against the process working directory.
# note: fgetc returns a 1-character string, or a number (-1) at end of file, so the loop
#       stops when isstring is no longer true and each byte is read with ascii. That is one
#       byte at a time, like the C row, and it is the slow part of this cell: 52428800
#       fgetc calls, each allocating a 1-character string.
# note: the fixture contains NUL bytes (byte 0 of every 256-byte cycle), and fgetc builds its
#       result as a C string, so a NUL byte comes back as a zero-length string rather than a
#       one-character one. ascii() rejects that ("error in length"), so the loop adds ascii(b)
#       only when len(b) = 1 and adds nothing otherwise, which is exactly the value 0 the C
#       row adds for the same byte. The byte is still read and the loop still runs once per
#       byte; only its value needs the special case.
# note: the C row accumulates in uint64 and takes the remainder at the end. Ring's numbers
#       are doubles, and 6684672000 is exact in a double, so the running total is exact and
#       the remainder is taken with %, which is fmod — also exact here, because the total is
#       a whole number far below 2^53.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Verified on this machine with Ring 1.27: all fifteen tasks print the expected
#         line and write time.txt.

ssT0 = clock()
fp = fopen("data.bin", "rb")
total = 0
b = fgetc(fp)

while isstring(b)
    if len(b) = 1
        total = total + ascii(b)
    ok
    b = fgetc(fp)
end

fclose(fp)

ssReport()
? total % 4294967296

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
