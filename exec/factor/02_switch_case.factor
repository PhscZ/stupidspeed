! task 02 switch_case — expected output: 7500000075000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 02_switch_case.factor    (from sources/factor/)
! note: `case` is Factor's switch. The accumulator rides on the data stack; the branch
!       quotation only ever sees the accumulator, because case consumes the key first.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: combinators io kernel locals math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: switch-case ( -- acc )
    0 100000000 [| acc i |
        i 4 mod {
            { 0 [ acc 1 + ] }
            { 1 [ acc i + ] }
            { 2 [ acc 2 i * + ] }
            { 3 [ acc 3 i * + ] }
        } case
    ] each-integer ;

nano-count switch-case ss-report .
