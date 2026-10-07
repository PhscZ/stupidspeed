' task 15 file_write -- expected output: 52428800
' build: qb64pe.exe -x 15_file_write.bas -o prog.exe    run: prog.exe
' timing: _UPTIME (QB64-PE v4.7.0's high-resolution monotonic clock, seconds as a Double);
'         TIME_MS goes to stderr through the kernel32 WriteFile route below
'         (DECLARE DYNAMIC LIBRARY, GetStdHandle(-12)).
' note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times and is written 50 times,
'       one PUT per megabyte. QB64 has no fsync, so the flush is the CLOSE -- this row is in
'       the flush-and-close group (like the Lua, TinyGo and gforth rows).
' stdout: written with the same WriteFile call on handle -11, with one LF as the trailing
'         newline and no CR, so the line is byte-for-byte the expected one. QB64's PRINT
'         would add CRLF and a leading space for positive numbers, so it is not used.
$CONSOLE:ONLY
DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetStdHandle%& (BYVAL n AS LONG)
    FUNCTION WriteFile%& (BYVAL h AS _OFFSET, BYVAL b AS _OFFSET, BYVAL n AS _UNSIGNED LONG, BYVAL w AS _OFFSET, BYVAL o AS _OFFSET)
END DECLARE

CONST CHUNK = 1048576

DIM t0 AS DOUBLE
t0 = _UPTIME

DIM SHARED buf(0 TO CHUNK - 1) AS _UNSIGNED _BYTE
DIM i AS INTEGER, j AS INTEGER
FOR i = 0 TO 4095
    FOR j = 0 TO 255
        buf(i * 256 + j) = j
    NEXT
NEXT

DIM f AS INTEGER
f = FREEFILE
OPEN "out.bin" FOR BINARY AS #f

DIM written AS _INTEGER64
FOR i = 1 TO 50
    PUT #f, , buf()
    written = written + CHUNK
NEXT
CLOSE #f

DIM msv AS DOUBLE
msv = (_UPTIME - t0) * 1000
emit_time msv
say LTRIM$(STR$(written))
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
