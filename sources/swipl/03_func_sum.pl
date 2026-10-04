% task 03 func_sum — expected output: 100000000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 03_func_sum.pl
% note: add_one/2 lives in 03_func_sum_add_one.pl, loaded with use_module/1, so the
%       call crosses a module boundary and is a real call. SWI-Prolog does not inline
%       across modules; the only thing -O does here is compile the arithmetic and drop
%       redundant true/0, so the call stays. That is the same guarantee the Fortran,
%       Tcl, Vala and Common Lisp rows get by splitting this task into two files.
% note: only the helper is a module. The main file stays non-modular so -g main finds
%       user:main/0; a modular main file would need -g <module>:main instead.

:- use_module('03_func_sum_add_one.pl').

main :-
    get_time(T0),
    nb_setval(time_t0, T0),
    loop(0, 0).

loop(I, V) :-
    (   I >= 100000000
    ->  nb_getval(time_t0, T0),
        get_time(T1),
        Ms is (T1 - T0) * 1000,
        format(standard_error, "TIME_MS=~3f~n", [Ms]),
        format("~w~n", [V])
    ;   add_one(V, V1),
        I1 is I + 1,
        loop(I1, V1)
    ).
