% task 09 fib_recursive — expected output: 102334155
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 09_fib_recursive.pl
% note: naive double recursion, no memoisation, no loop. The two base clauses are cut so
%       the recursive clause cannot be tried after them, and the first-argument index
%       picks the base clauses in O(1). fib(40) makes about 331 million calls.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    fib(40, R),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(standard_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [R]).

fib(0, 0) :-
    !.
fib(1, 1) :-
    !.
fib(N, R) :-
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, R1),
    fib(N2, R2),
    R is R1 + R2.
