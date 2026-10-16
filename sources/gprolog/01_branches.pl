% task 01 branches — expected output: 33333334 13333333 7619048 45714285
% build: gplc --no-top-level -o 01_branches.exe 01_branches.pl <shim.c>
%        driven by exec/gprolog/build_all.bat; see that file for the exact PATH.
% run:   exec/gprolog/gplc/01_branches/01_branches.exe
%
% note: GNU Prolog has no mutable variables and no loop syntax, so every task here is
%       tail recursion with explicit accumulators plus if-then-else for the branches,
%       the same shape as the swipl row. The one difference is the clock: GNU Prolog
%       1.5.0 has no get_time/1, so the timer is real_time/1 (milliseconds since the
%       start of the Prolog engine) and the elapsed time is a plain integer.
%
%       MEASURED REGION. This row measures the stand-alone native executable, not the
%       interpreter. gplc runs the whole native pipeline at BUILD time:
%         pl2wam  : .pl  -> WAM
%         wam2ma  : WAM -> mini-assembly
%         ma2asm  : mini-assembly -> x86-64 assembly
%         as      : assembly -> object
%         gcc     : object + GNU Prolog runtime archives -> .exe
%       All of that is outside the measured region, as is process start-up and WAM
%       engine initialisation. Inside the measured region are only the compiled native
%       code of the loop below and the two real_time/1 calls around it. That native
%       backend is what makes this a different cell from swipl's in-memory clauses.

:- initialization(main).

main :-
    real_time(T0),
    loop(0, 0, 0, 0, 0, T0).

loop(I, A, B, C, D, T0) :-
    (   I >= 100000000
    ->  real_time(T1),
        Ms is T1 - T0,
        format(user_error, "TIME_MS=~w~n", [Ms]),
        format("~w ~w ~w ~w~n", [A, B, C, D]),
        halt
    ;   M3 is I mod 3,
        (   M3 =:= 0
        ->  A1 is A + 1, B1 = B, C1 = C, D1 = D
        ;   M5 is I mod 5,
            (   M5 =:= 0
            ->  A1 = A, B1 is B + 1, C1 = C, D1 = D
            ;   M7 is I mod 7,
                (   M7 =:= 0
                ->  A1 = A, B1 = B, C1 is C + 1, D1 = D
                ;   A1 = A, B1 = B, C1 = C, D1 is D + 1
                )
            )
        ),
        I1 is I + 1,
        loop(I1, A1, B1, C1, D1, T0)
    ).
