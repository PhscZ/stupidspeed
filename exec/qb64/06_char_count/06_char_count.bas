' task 06 char_count -- expected output: 10000000
' build: qb64pe.exe -x 06_char_count.bas -o prog.exe    run: prog.exe
' timing: _UPTIME (QB64-PE v4.7.0's high-resolution monotonic clock, seconds as a Double);
'         TIME_MS goes to stderr through the kernel32 WriteFile route below
'         (DECLARE DYNAMIC LIBRARY, GetStdHandle(-12)).
' note: QB64's STRING$(n, s$) repeats the FIRST character of s$, so it cannot build
'       "abcdefghij" repeated; the 10000-byte block is filled by hand and the 100 MB text is
'       that whole block copied 10000 times with _MEMCOPY, not an append loop. The text is a
'       fixed-length STRING so that _MEM can address its bytes; the scan walks them with
'       _MEMGET (ASC(text$, pos) is not used -- it is a function call per byte).
' stdout: written with the same WriteFile call on handle -11, with one LF as the trailing
'         newline and no CR, so the line is byte-for-byte the expected one. QB64's PRINT
'         would add CRLF and a leading space for positive numbers, so it is not used.
$CONSOLE:ONLY
DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetStdHandle%& (BYVAL n AS LONG)
    FUNCTION WriteFile%& (BYVAL h AS _OFFSET, BYVAL b AS _OFFSET, BYVAL n AS _UNSIGNED LONG, BYVAL w AS _OFFSET, BYVAL o AS _OFFSET)
END DECLARE

CONST BLOCKLEN = 10000
CONST TOTAL = 100000000

DIM t0 AS DOUBLE
t0 = _UPTIME

DIM blk AS STRING * 10000
DIM text AS STRING * 100000000
DIM mb AS _MEM, mt AS _MEM
mb = _MEM(blk)
mt = _MEM(text)
DIM i AS _INTEGER64
DIM j AS _INTEGER64

' "abcdefghij" is ASCII 97..106, so byte j of the block is 97 + (j MOD 10)
FOR j = 0 TO BLOCKLEN - 1
    _MEMPUT mb, mb.OFFSET + j, (97 + (j MOD 10)) AS _UNSIGNED _BYTE
NEXT

FOR j = 0 TO (TOTAL \ BLOCKLEN) - 1
    _MEMCOPY mb, mb.OFFSET, mb.SIZE TO mt, mt.OFFSET + j * BLOCKLEN
NEXT

DIM ch AS _UNSIGNED _BYTE
DIM cnt AS _INTEGER64

FOR i = 0 TO TOTAL - 1
    _MEMGET mt, mt.OFFSET + i, ch
    IF ch = 97 THEN
        ' 'a': skip
    ELSEIF ch = 101 THEN
        ' 'e': skip
    ELSEIF ch = 104 THEN
        ' 'h': count
        cnt = cnt + 1
    ELSE
        ' skip
    END IF
NEXT

_MEMFREE mb
_MEMFREE mt

DIM msv AS DOUBLE
msv = (_UPTIME - t0) * 1000
emit_time msv
say LTRIM$(STR$(cnt))
SYSTEM

SUB emit_time (msv AS DOUBLE)
    DIM ti AS _INTEGER64
    ti = INT(msv * 1000 + .5)
    DIM s AS STRING
    s = LTRIM$(STR$(ti))
    IF LEN(s) < 4 THEN s = STRING$(4 - LEN(s), "0") + s
    s = "TIME_MS=" + LEFT$(s, LEN(s) - 3) + "." + RIGHT$(s, 3) + CHR$(10)
    DIM fs AS STRING * 64
    fs = s
    DIM h AS _OFFSET
    h = GetStdHandle(-12)
    DIM nw AS LONG
    DIM r AS _OFFSET
    r = WriteFile(h, _OFFSET(fs), LEN(s), _OFFSET(nw), 0)
END SUB

SUB say (txt AS STRING)
    DIM s AS STRING
    s = txt + CHR$(10)
    DIM fs AS STRING * 512
    fs = s
    DIM h AS _OFFSET
    h = GetStdHandle(-11)
    DIM nw AS LONG
    DIM rr AS _OFFSET
    rr = WriteFile(h, _OFFSET(fs), LEN(s), _OFFSET(nw), 0)
END SUB
