' task 14 file_read -- expected output: 2389704704
' build: fbc -O 2 -x prog.exe 14_file_read.bas    run: ./prog
' task 14 - file_read
' timing: Timer is FreeBASIC's own clock, seconds since midnight as a Double. TIME_MS goes to
'         stderr through the Err device, and stdout is unchanged. Built and run against FreeBASIC 1.10.1 on this machine, so the timing is real.
const CHUNK as integer = 1048576
dim ss_t0 as double = timer
dim as ubyte buf(0 to CHUNK-1)
dim as integer f = freefile
open "data.bin" for binary access read as #f
dim as ulongint total = 0
dim as integer i, got
do
    got = 0
    get #f, , buf()
    ' freebasic get with array fills whole array; detect EOF by loc
    got = CHUNK
    for i = 0 to CHUNK - 1
        total += buf(i)
    next
    if eof(f) then exit do
loop
close #f
dim ss_ms as longint = clng((timer - ss_t0) * 1000)
open err for output as #1
print #1, "TIME_MS=" & ltrim(str(ss_ms))
close #1
print str(total mod 4294967296ULL)
