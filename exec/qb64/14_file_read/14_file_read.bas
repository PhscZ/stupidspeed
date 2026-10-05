' task 14 file_read -- expected output: 2389704704
' build: qb64pe.exe -x 14_file_read.bas -o prog.exe    run: prog.exe
' timing: _UPTIME (QB64-PE v4.7.0's high-resolution monotonic clock, seconds as a Double);
'         TIME_MS goes to stderr through the kernel32 WriteFile route below
'         (DECLARE DYNAMIC LIBRARY, GetStdHandle(-12)).
' note: data.bin (50 MiB: the bytes 0..255 repeating) must sit in the working directory.
'       The file is read in 1 MiB chunks with GET #f, , buf() into a fixed 1 MiB array --
'       QB64's GET fills the whole array -- and every byte is added. QB64's INTEGER is
'       16-bit, so the per-byte loop counter is _INTEGER64: a 16-bit counter over
'       0..1048575 wraps and dies with "Subscript out of range".
'       The total is kept in _INTEGER64 and the final MOD 4294967296 is applied before
'       printing.
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
DIM f AS INTEGER
f = FREEFILE
OPEN "data.bin" FOR BINARY AS #f

DIM total AS _INTEGER64
DIM i AS _INTEGER64

DO WHILE NOT EOF(f)
    GET #f, , buf()
    FOR i = 0 TO CHUNK - 1
        total = total + buf(i)
    NEXT
LOOP
CLOSE #f

DIM msv AS DOUBLE
msv = (_UPTIME - t0) * 1000
emit_time msv
say LTRIM$(STR$(total MOD 4294967296))
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
