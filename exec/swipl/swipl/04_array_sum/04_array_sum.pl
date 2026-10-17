% task 04 array_sum — expected output: 599999940000000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 04_array_sum.pl
% note: SWI-Prolog has no array library, so the array is a compound term with 10000000
%       arguments -- a/10000000 is one functor plus ten million cells on the global stack,
%       the same 80 MB the C row allocates. Only predicate arity is capped (at 1024);
%       compound-term arity is unbounded. Elements are written with nb_setarg/3 (the
%       non-backtrackable destructive assignment) and read with arg/3.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    functor(A, a, 10000000),
    fill(0, A),
    sum_times(12, A, 0, Total),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(user_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Total]).

fill(I, A) :-
    (   I >= 10000000
    ->  true
    ;   J is I + 1,
        nb_setarg(J, A, I),
        I1 is I + 1,
        fill(I1, A)
    ).

sum_times(0, _, Acc, Total) :-
    Total = Acc.
sum_times(N, A, Acc, Total) :-
    N > 0,
    sum(0, A, Acc, Acc1),
    N1 is N - 1,
    sum_times(N1, A, Acc1, Total).

sum(I, A, Acc, Total) :-
    (   I >= 10000000
    ->  Total = Acc
    ;   J is I + 1,
        arg(J, A, V),
        Acc1 is Acc + V,
        I1 is I + 1,
        sum(I1, A, Acc1, Total)
    ).
