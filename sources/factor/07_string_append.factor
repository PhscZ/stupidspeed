! task 07 string_append — expected output: 1000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 07_string_append.factor    (from sources/factor/)
! note: Factor strings are immutable, so `text = text + "x"` would copy the whole string
!       every time. The growable string here is the string buffer, Factor's own appendable
!       string type: `push` appends in place and the buffer doubles its capacity when full.

USING: math prettyprint sequences strings ;
IN: scratchpad

:: string-append ( -- n )
    SBUF" " :> text
    1000000 [ CHAR: x text push ] times
    text length ;

string-append .
