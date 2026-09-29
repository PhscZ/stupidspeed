% task 05 alloc_churn — expected output: 1274991808
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 05_alloc_churn.pl
% note: the 64-byte buffer is an 8-argument compound term (8 cells x 8 bytes); buf[0] is
%       argument 1, written with nb_setarg/3. slots is a 256-argument term used as the
%       ring, so slots[i mod 256] keeps the previous 256 buffers reachable while the
%       older ones become garbage, exactly as the C row does. SWI reclaims the global
%       stack by garbage collection once the data is no longer referenced.
% note: -O is required, see 01_branches.pl.

main :-
    functor(Slots, s, 256),
    loop(0, Slots, 0, Total),
    format("~w~n", [Total]).

loop(I, Slots, Acc, Total) :-
    (   I >= 10000000
    ->  Total = Acc
    ;   functor(Buf, b, 8),
        V is I mod 256,
        nb_setarg(1, Buf, V),
        S is (I mod 256) + 1,
        nb_setarg(S, Slots, Buf),
        Acc1 is Acc + V,
        I1 is I + 1,
        loop(I1, Slots, Acc1, Total)
    ).
