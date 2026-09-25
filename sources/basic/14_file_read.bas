' task 14 file_read -- expected output: 484442112
' build: fbc -O 2 -x 14_file_read.bas    run: ./14_file_read.exe
' task 14 - file_read
const CHUNK as integer = 1048576
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
print str(total mod 4294967296ULL)
