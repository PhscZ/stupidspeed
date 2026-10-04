! task 10 pi — expected output: 4470
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 10_pi.factor    (from sources/factor/)
! note: Factor's integer type is arbitrary precision natively (fixnum below 2^60, bignum
!       above), so Gibbons' unbounded spigot runs on the language's own big integers and
!       `/i` is a real big-integer division. Only the sum of the first 1000 digits is
!       printed. The state (q r t k n l) plus (emitted sum) is carried by tail recursion.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: io kernel locals math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: spigot ( q r t k n l emitted sum -- sum )
    emitted 1000 >= [
        sum
    ] [
        4 q * r + t - n t * <
        [
            ! emit n:  q,r,t,k,n,l = 10q, 10(r-nt), t, k, (10(3q+r))/t - 10n, l
            q 10 * r n t * - 10 * t k 10 3 q * r + * t /i n 10 * - l
            emitted 1 + sum n + spigot
        ]
        [
            ! no digit yet:  q,r,t,k,n,l = qk, (2q+r)l, tl, k+1, (q(7k+2)+rl)/(tl), l+2
            q k * 2 q * r + l * t l * k 1 + q 7 k * 2 + * r l * + t l * /i l 2 +
            emitted sum spigot
        ] if
    ] if ;

nano-count 1 0 1 1 3 3 0 0 spigot ss-report .
