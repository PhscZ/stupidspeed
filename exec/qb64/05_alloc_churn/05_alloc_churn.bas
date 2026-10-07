' task 05 alloc_churn -- expected output: 1274991808
' build: qb64pe.exe -x 05_alloc_churn.bas -o prog.exe    run: prog.exe
' timing: _UPTIME (QB64-PE v4.7.0's high-resolution monotonic clock, seconds as a Double);
'         TIME_MS goes to stderr through the kernel32 WriteFile route below
'         (DECLARE DYNAMIC LIBRARY, GetStdHandle(-12)).
' note: QB64 has no garbage collector, so _MEMNEW(64) is a real 64-byte allocation and
'       _MEMFREE is the "free the old one" branch of the C reference: the slot store
'       releases the buffer it replaces. The final 256 buffers are released too.
' stdout: written with the same WriteFile call on handle -11, with one LF as the trailing
'         newline and no CR, so the line is byte-for-byte the expected one. QB64's PRINT
'         would add CRLF and a leading space for positive numbers, so it is not used.
$CONSOLE:ONLY
DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetStdHandle%& (BYVAL n AS LONG)
    FUNCTION WriteFile%& (BYVAL h AS _OFFSET, BYVAL b AS _OFFSET, BYVAL n AS _UNSIGNED LONG, BYVAL w AS _OFFSET, BYVAL o AS _OFFSET)
END DECLARE

DIM SHARED slots(0 TO 255) AS _MEM
DIM t0 AS DOUBLE
t0 = _UPTIME
DIM i AS _INTEGER64, j AS _INTEGER64, total AS _INTEGER64
DIM bv AS _UNSIGNED _BYTE

FOR i = 0 TO 9999999
    DIM mb AS _MEM
    mb = _MEMNEW(64)
    _MEMPUT mb, mb.OFFSET, (i MOD 256) AS _UNSIGNED _BYTE
    _MEMGET mb, mb.OFFSET, bv
    total = total + bv
    j = i MOD 256
    IF slots(j).SIZE > 0 THEN _MEMFREE slots(j)
    slots(j) = mb
NEXT

FOR j = 0 TO 255
    IF slots(j).SIZE > 0 THEN _MEMFREE slots(j)
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
