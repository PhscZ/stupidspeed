! task 06 char_count — expected output: 10000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 06_char_count.factor    (from sources/factor/)
! note: the hundred-million-character string is built by replicating the whole ten-char
!       block and concatenating once, never by appending. Factor's `each` walks the string
!       as fixnum character codes.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: io kernel locals math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: char-count ( -- count )
    10000000 [ "abcdefghij" ] replicate concat :> text
    0 text [| count ch |
        ch CHAR: a = [ count ]
        [ ch CHAR: e = [ count ]
          [ ch CHAR: h = [ count 1 + ] [ count ] if ] if ] if
    ] each ;

nano-count char-count ss-report .
