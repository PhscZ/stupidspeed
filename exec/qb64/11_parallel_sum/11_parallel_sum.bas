' task 11 parallel_sum -- expected output: 7500000075000000
' build: qb64pe.exe -x 11_parallel_sum.bas -o prog.exe    run: prog.exe
' timing: _UPTIME (QB64-PE v4.7.0's high-resolution monotonic clock, seconds as a Double);
'         TIME_MS goes to stderr through the kernel32 WriteFile route below
'         (DECLARE DYNAMIC LIBRARY, GetStdHandle(-12)).
' note: QB64 has no thread library, so the four workers are four real OS processes: the
'       program re-runs its own executable (path from GetModuleFileNameA) with a worker
'       index as its argument, using SHELL _DONTWAIT _HIDE, so all four run at once on four
'       cores. Each child computes one quarter and writes its partial to ps_<t>.bin, then
'       touches ps_<t>.done; the parent polls for the four done files, sums the partials and
'       removes the scratch files. The same category as the R row's PSOCK workers and the
'       VBScript row's WScript.Shell.Exec children. Children print nothing, so only the
'       parent writes stdout and stderr.
' stdout: written with the same WriteFile call on handle -11, with one LF as the trailing
'         newline and no CR, so the line is byte-for-byte the expected one. QB64's PRINT
'         would add CRLF and a leading space for positive numbers, so it is not used.
$CONSOLE:ONLY
DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetStdHandle%& (BYVAL n AS LONG)
    FUNCTION WriteFile%& (BYVAL h AS _OFFSET, BYVAL b AS _OFFSET, BYVAL n AS _UNSIGNED LONG, BYVAL w AS _OFFSET, BYVAL o AS _OFFSET)
    FUNCTION GetModuleFileNameA%& (BYVAL h AS _OFFSET, BYVAL lp AS _OFFSET, BYVAL n AS _UNSIGNED LONG)
END DECLARE

CONST SPAN = 25000000

' ---- worker mode: one quarter of task 02's range ----
IF COMMAND$ <> "" THEN
    DIM ct AS _INTEGER64
    ct = VAL(COMMAND$)
    DIM acc AS _INTEGER64
    DIM lo AS _INTEGER64, hi AS _INTEGER64, i AS _INTEGER64
    lo = ct * SPAN
    hi = lo + SPAN - 1
    FOR i = lo TO hi
        SELECT CASE (i MOD 4)
            CASE 0: acc = acc + 1
            CASE 1: acc = acc + i
            CASE 2: acc = acc + 2 * i
            CASE 3: acc = acc + 3 * i
        END SELECT
    NEXT
    DIM wf AS INTEGER
    wf = FREEFILE
    OPEN "ps_" + LTRIM$(STR$(ct)) + ".bin" FOR BINARY AS #wf
    PUT #wf, , acc
    CLOSE #wf
    wf = FREEFILE
    OPEN "ps_" + LTRIM$(STR$(ct)) + ".done" FOR OUTPUT AS #wf
    PRINT #wf, "1"
    CLOSE #wf
    SYSTEM
END IF

' ---- parent ----
DIM t0 AS DOUBLE
t0 = _UPTIME

DIM pbuf AS STRING * 512
DIM pr AS _UNSIGNED LONG
pr = GetModuleFileNameA(0, _OFFSET(pbuf), 512)
DIM exe AS STRING
exe = LEFT$(pbuf, pr)

DIM k AS INTEGER
FOR k = 0 TO 3
    SHELL _DONTWAIT _HIDE CHR$(34) + exe + CHR$(34) + " " + LTRIM$(STR$(k))
NEXT

DIM waiting AS INTEGER
DIM guard AS DOUBLE
guard = _UPTIME + 120
DO
    waiting = 0
    FOR k = 0 TO 3
        IF NOT _FILEEXISTS("ps_" + LTRIM$(STR$(k)) + ".done") THEN waiting = waiting + 1
    NEXT
    IF waiting > 0 THEN _DELAY .002
LOOP WHILE waiting > 0 AND _UPTIME < guard

DIM total AS _INTEGER64
DIM v AS _INTEGER64
FOR k = 0 TO 3
    IF _FILEEXISTS("ps_" + LTRIM$(STR$(k)) + ".bin") THEN
        DIM rf AS INTEGER
        rf = FREEFILE
        OPEN "ps_" + LTRIM$(STR$(k)) + ".bin" FOR BINARY AS #rf
        GET #rf, , v
        CLOSE #rf
        total = total + v
    END IF
NEXT

DIM msv AS DOUBLE
msv = (_UPTIME - t0) * 1000
emit_time msv

FOR k = 0 TO 3
    IF _FILEEXISTS("ps_" + LTRIM$(STR$(k)) + ".bin") THEN KILL "ps_" + LTRIM$(STR$(k)) + ".bin"
    IF _FILEEXISTS("ps_" + LTRIM$(STR$(k)) + ".done") THEN KILL "ps_" + LTRIM$(STR$(k)) + ".done"
NEXT
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
    DIM rr AS _OFFSET
    rr = WriteFile(h, _OFFSET(fs), LEN(s), _OFFSET(nw), 0)
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
