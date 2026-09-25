' task 15 file_write -- expected output: 104857600
' build: fbc -O 2 -x 15_file_write.bas    run: ./15_file_write.exe
' task 15 - file_write
const CHUNK as integer = 1048576
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
for i = 1 to 100
    put #f, , buf()
    written += CHUNK
next
close #f
print str(written)
