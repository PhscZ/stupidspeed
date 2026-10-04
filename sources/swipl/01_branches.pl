% task 01 branches — expected output: 33333334 13333333 7619048 45714285
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 01_branches.pl
% note: Prolog has no mutable variables and no loop syntax, so every task here is tail
%       recursion with explicit accumulators (the compiler turns the last call into a
%       jump) plus if-then-else for the branches. -O is load-bearing: it sets the
%       optimise flag, which compiles the arithmetic and removes redundant true/0
%       (~3x on loop code); without it the hot expressions run through the interpreter.
% note: -q suppresses the banner, -f none skips the personal init file, -g main runs
%       main/0 and -t halt makes it the top level, so stdout is exactly one line.

main :-
    get_time(T0),
    nb_setval(time_t0, T0),
    loop(0, 0, 0, 0, 0).

loop(I, A, B, C, D) :-
    (   I >= 100000000
    ->  nb_getval(time_t0, T0),
        get_time(T1),
        Ms is (T1 - T0) * 1000,
        format(standard_error, "TIME_MS=~3f~n", [Ms]),
        format("~w ~w ~w ~w~n", [A, B, C, D])
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
        loop(I1, A1, B1, C1, D1)
    ).
