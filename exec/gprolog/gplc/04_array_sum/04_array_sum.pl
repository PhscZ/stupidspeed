% task 04 array_sum — expected output: 599999940000000
% build: gplc --no-top-level -o 04_array_sum.exe 04_array_sum.pl <shim.c>
% run:   exec/gprolog/gplc/04_array_sum/04_array_sum.exe
%
% note: GNU Prolog caps compound-term arity at 255 (MAX_ARITY = NB_OF_X_REGS - 1), so
%       the swipl row's million-argument compound term is impossible here; the array is
%       a 10000000-element list instead. It is filled in index order with a difference
%       list (fill/4 is tail recursive, so no deep local stack) and then read
%       back in index order by sum/3, twelve times over. Same fill-then-read shape,
%       same 80 MB of live cells, same arithmetic as the C row.
% note: the build reserves a 1 GB global stack (gplc --global-size 1048576, see
%       exec/gprolog/build_all.bat). The ten-million-element list is 80 MB of cells but
%       GNU Prolog's list constructor leaves the stack pointer where it is, so the fill
%       walks past the default 32 MB and dies with "global stack overflow"; 1 GB is the
%       measured requirement with margin.
% note: measured region: the fill and the sums only; see 01_branches.pl for the pipeline
%       note and for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    fill(0, 10000000, A, []),
    sum_times(A, 12, 0, Total),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Total]),
    halt.

fill(I, N, L, T) :-
    (   I >= N
    ->  L = T
    ;   J is I + 1,
        L = [I | L1],
        fill(J, N, L1, T)
    ).

sum([], Acc, Total) :-
    Total = Acc.
sum([V | Rest], Acc, Total) :-
    Acc1 is Acc + V,
    sum(Rest, Acc1, Total).

sum_times(_, 0, Acc, Total) :-
    Total = Acc.
sum_times(L, K, Acc, Total) :-
    K > 0,
    sum(L, 0, S),
    Acc1 is Acc + S,
    K1 is K - 1,
    sum_times(L, K1, Acc1, Total).
