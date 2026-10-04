! task 07 string_append — expected output: 250000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 07_string_append.factor    (from sources/factor/)
! note: Factor strings are immutable, so `text = text + "x"` would copy the whole string
!       every time. The growable string here is the string buffer, Factor's own appendable
!       string type: `push` appends in place and the buffer doubles its capacity when full.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: io kernel math math.parser namespaces prettyprint sequences strings system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: string-append ( -- n )
    SBUF" " :> text
    250000 [ CHAR: x text push ] times
    text length ;

nano-count string-append ss-report .
