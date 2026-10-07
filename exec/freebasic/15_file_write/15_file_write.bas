' task 15 file_write -- expected output: 52428800
' build: fbc -O 2 -x prog.exe 15_file_write.bas    run: ./prog
' task 15 - file_write
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Built and run against FreeBASIC 1.10.1 on this machine, so the timing is real.
const CHUNK as integer = 1048576
dim ss_t0 as double = timer
dim as ubyte buf(0 to CHUNK-1)
dim as integer i, j
for i = 0 to 4095
    for j = 0 to 255
        buf(i * 256 + j) = j
    next
next
dim as integer f = freefile
open "out.bin" for binary access write as #f
dim as ulongint written = 0
for i = 1 to 50
    put #f, , buf()
    written += CHUNK
next
close #f
dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(written)
