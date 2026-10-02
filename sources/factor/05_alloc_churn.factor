! task 05 alloc_churn — expected output: 1274991808
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 05_alloc_churn.factor    (from sources/factor/)
! note: ten million 64-byte byte arrays. Each one is stored into a 256-slot array, which
!       keeps it reachable and drops the buffer it replaces — the old one becomes garbage
!       for Factor's generational copying GC.

USING: arrays byte-arrays locals math prettyprint sequences ;
IN: scratchpad

:: alloc-churn ( -- total )
    256 f <array> :> slots
    0 10000000 [| total i |
        64 <byte-array> :> buf
        i 256 mod 0 buf set-nth
        total 0 buf nth +
        buf i 256 mod slots set-nth
    ] each-integer ;

alloc-churn .
