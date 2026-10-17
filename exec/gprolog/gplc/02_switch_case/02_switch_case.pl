% task 02 switch_case — expected output: 8748000081000000
% build: gplc --no-top-level -o 02_switch_case.exe 02_switch_case.pl <shim.c>
% run:   exec/gprolog/gplc/02_switch_case/02_switch_case.exe
%
% note: the switch is an if-then-else chain on (I mod 4), the closest thing Prolog has
%       to a case statement, exactly as in the swipl row's 02_switch_case.pl. Tail
%       recursion carries the accumulator. Measured region: the loop only, and the
%       clock is real_time/1; see 01_branches.pl for the full pipeline note.

:- initialization(main).

main :-
    real_time(T0),
    loop(0, 0, T0).

loop(I, Acc, T0) :-
    (   I >= 108000000
    ->  real_time(T1),
        Ms is T1 - T0,
        format(user_error, "TIME_MS=~w~n", [Ms]),
        format("~w~n", [Acc]),
        halt
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
        loop(I1, Acc1, T0)
    ).
