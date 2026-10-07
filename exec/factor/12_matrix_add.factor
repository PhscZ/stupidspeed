! task 12 matrix_add — expected output: 999000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 12_matrix_add.factor    (from sources/factor/)
! note: three million-element arrays, kept flat and indexed as i*n+j, so the three passes
!       walk contiguous memory: build A, build B, C = A + B, then sum C.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: arrays io kernel locals math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: matrix-add ( -- sum )
    1000 :> n
    n n * 0 <array> :> a
    n n * 0 <array> :> b
    n n * 0 <array> :> c
    n [| i |
        n [| j |
            i j + i n * j + a set-nth
            i j - i n * j + b set-nth
        ] each-integer
    ] each-integer
    n [| i |
        n [| j |
            i n * j + :> idx
            idx a nth idx b nth + idx c set-nth
        ] each-integer
    ] each-integer
    0 n n * [| total idx | total idx c nth + ] each-integer ;

nano-count matrix-add ss-report .
