! task 05 alloc_churn — expected output: 1274991808
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 05_alloc_churn.factor    (from sources/factor/)
! note: ten million 64-byte byte arrays. Each one is stored into a 256-slot array, which
!       keeps it reachable and drops the buffer it replaces — the old one becomes garbage
!       for Factor's generational copying GC.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: arrays byte-arrays io kernel locals math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: alloc-churn ( -- total )
    256 f <array> :> slots
    0 10000000 [| total i |
        64 <byte-array> :> buf
        i 256 mod 0 buf set-nth
        total 0 buf nth +
        buf i 256 mod slots set-nth
    ] each-integer ;

nano-count alloc-churn ss-report .
