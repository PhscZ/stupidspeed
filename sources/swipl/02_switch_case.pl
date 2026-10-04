% task 02 switch_case — expected output: 7500000075000000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 02_switch_case.pl
% note: the switch is an if-then-else chain on (I mod 4), the closest thing Prolog has
%       to a case statement without adding a helper predicate per arm. Tail recursion
%       carries the accumulator. -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    nb_setval(time_t0, T0),
    loop(0, 0).

loop(I, Acc) :-
    (   I >= 100000000
    ->  nb_getval(time_t0, T0),
        get_time(T1),
        Ms is (T1 - T0) * 1000,
        format(standard_error, "TIME_MS=~3f~n", [Ms]),
        format("~w~n", [Acc])
    ;   R is I mod 4,
        (   R =:= 0
        ->  Acc1 is Acc + 1
        ;   R =:= 1
        ->  Acc1 is Acc + I
        ;   R =:= 2
        ->  Acc1 is Acc + 2 * I
        ;   Acc1 is Acc + 3 * I
        ),
        I1 is I + 1,
        loop(I1, Acc1)
    ).
