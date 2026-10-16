% task 03 func_sum — expected output: 400000000
% build: gplc --no-top-level -o 03_func_sum.exe 03_func_sum.pl
%        03_func_sum_add_one.pl <shim.c>
% run:   exec/gprolog/gplc/03_func_sum/03_func_sum.exe
%
% note: add_one/2 lives in 03_func_sum_add_one.pl, a second source file, and both files
%       are compiled into the one executable by a single gplc invocation, so the call is
%       a genuine predicate call. GNU Prolog's compiler inlines predicates within the file
%       it is compiling, but pl2wam processes one source file at a time, so a call to a
%       predicate that lives in another file cannot be inlined -- the file boundary is
%       this language's no-inline marker, the same guarantee the Fortran, Tcl, Vala and
%       Common Lisp rows get by splitting this task into two files. (The compiler's own
%       --no-inline flag is not usable here: measured, it makes a plain hundred-million
%       iteration tail loop overflow the global stack, because the uninlined call's
%       environment is not reclaimed, so the two-file split is the way to keep the call.)
% note: GNU Prolog is not used modularly here; there is no module boundary, only a file
%       boundary. Measured region: the loop only; see 01_branches.pl.

:- initialization(main).

main :-
    real_time(T0),
    loop(0, 0, T0).

loop(I, V, T0) :-
    (   I >= 400000000
    ->  real_time(T1),
        Ms is T1 - T0,
        format(user_error, "TIME_MS=~w~n", [Ms]),
        format("~w~n", [V]),
        halt
    ;   add_one(V, V1),
        I1 is I + 1,
        loop(I1, V1, T0)
    ).
