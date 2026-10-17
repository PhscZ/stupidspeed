% task 09 fib_recursive — expected output: 102334155
% build: gplc --no-top-level -o 09_fib_recursive.exe 09_fib_recursive.pl <shim.c>
% run:   exec/gprolog/gplc/09_fib_recursive/09_fib_recursive.exe
%
% note: naive double recursion, no memoisation, no loop, the same 331 million calls as
%       every other row.
% note: DEVIATION, forced by the implementation: the recursion is written as one clause
%       with an if-then-else rather than the swipl row's two cut base clauses plus a
%       recursive clause. GNU Prolog 1.5.0 leaves a trail entry for every binding made
%       in an environment that a choice point can see, and it never truncates that trail
%       when the environment is deallocated, so the three-clause form runs out of trail
%       long before fib(40): measured, fib(30) leaves 10770184 bytes of trail behind
%       (about 4 bytes per call, so fib(40) would need roughly 1.3 GB) and dies with
%       "Fatal Error: trail stack overflow (size: 16384 Kb, ... TRAILSZ)". A trail of
%       1.3 GB cannot be reserved either -- the engine's allocation ceiling is just under
%       2 GB and it reports "Memory allocation error". The if-then-else form compiles to
%       cut/trust instead of clause selection, so there is no choice point and the trail
%       stays flat: measured, fib(30) leaves 16 bytes in total. The recursion itself,
%       the two base cases and the call count are unchanged; only the way the base cases
%       are selected differs. The same shape is used by the row's other recursive
%       predicates, for the same reason.
% note: measured region: the fib call only; see 01_branches.pl for the pipeline note and
%       for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    fib(40, R),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [R]),
    halt.

fib(N, R) :-
    (   N < 2
    ->  R = N
    ;   N1 is N - 1,
        N2 is N - 2,
        fib(N1, R1),
        fib(N2, R2),
        R is R1 + R2
    ).
