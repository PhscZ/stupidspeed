% task 12 matrix_add — expected output: 63984000000
% build: gplc --no-top-level -o 12_matrix_add.exe 12_matrix_add.pl <shim.c>
% run:   exec/gprolog/gplc/12_matrix_add/12_matrix_add.exe
%
% note: GNU Prolog caps compound-term arity at 255 (MAX_ARITY = NB_OF_X_REGS - 1), so the
%       swipl row's sixteen-million-argument compound term is impossible here. Each 4000x4000
%       matrix is a flat list of 16000000 elements in row-major order, so element [i][j]
%       is position i*4000 + j of the list, the same layout and the same arithmetic as
%       the C row. A[i][j] = i + j, B[i][j] = i - j, C = A + B, and the sum of C is
%       printed. A and B are built with a difference list (tail recursive, so no sixteen-million
%       frames on the local stack) and C is built and summed in one walk, exactly as the
%       swipl row's add/6 does. Forty-eight million cells, about 1152 MB live, is what makes this
%       a memory-bandwidth cell rather than a compute cell.
% note: the build reserves a 1.5 GB global stack for this task (gplc --global-size
%       1572864, see exec/gprolog/build_all.bat). GNU Prolog 1.5.0 has no garbage
%       collector and the forty-eight million cells (A, B and C at about 384 MB each, plus the
%       difference-list scaffolding) do not fit the default 32 MB heap, which dies with
%       "Fatal Error: global stack overflow (size: 32768 Kb, ... GLOBALSZ)". The
%       reservation is made once, before the timer starts.
% note: measured region: the build and the add only; see 01_branches.pl for the pipeline
%       note and for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    fill(0, 16000000, A, B),
    add(A, B, C, 0, Total),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Total]),
    halt.

fill(I, N, A, B) :-
    fill_(I, N, A, [], B, []).

fill_(I, N, A, At, B, Bt) :-
    (   I >= N
    ->  A = At,
        B = Bt
    ;   Row is I // 4000,
        Col is I mod 4000,
        Va is Row + Col,
        Vb is Row - Col,
        J is I + 1,
        A = [Va | A1],
        B = [Vb | B1],
        fill_(J, N, A1, At, B1, Bt)
    ).

add(A, B, C, Acc, Total) :-
    add_(A, B, C, [], Acc, Total).

add_([], [], L, T, Acc, Total) :-
    !,
    L = T,
    Total = Acc.
add_([Va | As], [Vb | Bs], L, T, Acc, Total) :-
    Vc is Va + Vb,
    Acc1 is Acc + Vc,
    L = [Vc | L1],
    add_(As, Bs, L1, T, Acc1, Total).
