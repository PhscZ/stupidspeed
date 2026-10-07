! task 11 parallel_sum — expected output: 7500000075000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 11_parallel_sum.factor    (from sources/factor/)
! note: four workers, spawned with `future` (concurrency.futures) and joined with `?future`.
!       `future` is `spawn-linked-to`, i.e. the `threads` vocabulary's `spawn`/`(spawn)`,
!       which is Factor's own co-operative green-thread scheduler, not OS threads, so this
!       is a correct-answer-no-speedup cell. Measured against this row's own task 02, which
!       does exactly the same 100 million iterations: 1075 ms on one thread against 5535 ms
!       through four `future`s. The workers interleave on one core and the per-future
!       scheduling and data-stack setup costs far more than the parallelism could save, so
!       the cell is not merely flat but several times slower than the serial task.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged. The counter brackets the four
!         futures and the join.
USING: combinators concurrency.futures io kernel locals math math.parser namespaces
prettyprint ranges sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: work ( t -- acc )
    t 25000000 * :> base
    0 25000000 [| acc k |
        base k + :> i
        i 4 mod {
            { 0 [ acc 1 + ] }
            { 1 [ acc i + ] }
            { 2 [ acc 2 i * + ] }
            { 3 [ acc 3 i * + ] }
        } case
    ] each-integer ;

:: parallel-sum ( -- total )
    4 <iota> [| t | [ t work ] future ] map
    [ ?future ] map sum ;

nano-count parallel-sum ss-report .
