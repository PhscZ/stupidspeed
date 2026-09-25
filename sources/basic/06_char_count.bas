' task 06 char_count -- expected output: 10000000
' build: fbc -O 2 -x prog.exe 06_char_count.bas    run: ./prog
' The 100 MB text is one memcpy of a 10000-byte block repeated 10000 times, not an
' append loop. FreeBASIC's string(n, s) repeats the first character of s, not s, so
' the block is filled by hand and the copy is the CRT memcpy.
' The scan walks the string bytes through strptr(); asc(text, pos) is not used because
' it returns the first character for strings this large.
#include once "crt/string.bi"

const TOTAL as integer = 100000000
const BLOCKLEN as integer = 10000
const PATTERN as string = "abcdefghij"

dim text as string = space(TOTAL)
dim p as ubyte ptr = strptr(text)
dim blk(0 to BLOCKLEN - 1) as ubyte
dim i as longint
dim j as integer
dim count as longint = 0
dim ch as ubyte

for i = 0 to BLOCKLEN - 1
    blk(i) = asc(PATTERN, (i mod 10) + 1)
next

for i = 0 to (TOTAL \ BLOCKLEN) - 1
    memcpy(p + i * BLOCKLEN, @blk(0), BLOCKLEN)
next

for i = 0 to TOTAL - 1
    ch = p[i]
    if ch = asc("a") then
        ' skip
    elseif ch = asc("e") then
        ' skip
    elseif ch = asc("h") then
        count += 1
    else
        ' skip
    end if
next

print str(count)
