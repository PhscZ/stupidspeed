' task 13 matrix_mul -- expected output: 599995000
' build: qb64pe.exe -x 13_matrix_mul.bas -o prog.exe    run: prog.exe
' timing: _UPTIME (QB64-PE v4.7.0's high-resolution monotonic clock, seconds as a Double);
'         TIME_MS goes to stderr through the kernel32 WriteFile route below
'         (DECLARE DYNAMIC LIBRARY, GetStdHandle(-12)).
' note: plain triple loop, no reordering and no tricks; the 2 MB matrices are DIM SHARED to
'       stay out of the automatic/stack area.
' stdout: written with the same WriteFile call on handle -11, with one LF as the trailing
'         newline and no CR, so the line is byte-for-byte the expected one. QB64's PRINT
'         would add CRLF and a leading space for positive numbers, so it is not used.
$CONSOLE:ONLY
DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetStdHandle%& (BYVAL n AS LONG)
    FUNCTION WriteFile%& (BYVAL h AS _OFFSET, BYVAL b AS _OFFSET, BYVAL n AS _UNSIGNED LONG, BYVAL w AS _OFFSET, BYVAL o AS _OFFSET)
END DECLARE

DIM SHARED a(0 TO 499, 0 TO 499) AS _INTEGER64
DIM SHARED b(0 TO 499, 0 TO 499) AS _INTEGER64
DIM SHARED c(0 TO 499, 0 TO 499) AS _INTEGER64
DIM t0 AS DOUBLE
t0 = _UPTIME
DIM i AS INTEGER, j AS INTEGER, k AS INTEGER
DIM acc AS _INTEGER64
DIM total AS _INTEGER64

FOR i = 0 TO 499
    FOR j = 0 TO 499
        a(i, j) = (i + j) MOD 7
        b(i, j) = (i * j) MOD 5
    NEXT
NEXT

FOR i = 0 TO 499
    FOR j = 0 TO 499
        acc = 0
        FOR k = 0 TO 499
            acc = acc + a(i, k) * b(k, j)
        NEXT
        c(i, j) = acc
    NEXT
NEXT

FOR i = 0 TO 499
    FOR j = 0 TO 499
        total = total + c(i, j)
    NEXT
NEXT

DIM msv AS DOUBLE
msv = (_UPTIME - t0) * 1000
emit_time msv
say LTRIM$(STR$(total))
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
