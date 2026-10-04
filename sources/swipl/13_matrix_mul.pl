% task 13 matrix_mul — expected output: 599995000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 13_matrix_mul.pl
% note: n = 500, so each matrix is a 250000-argument compound term in row-major order and
%       element [i][j] is argument i*500 + j + 1. A[i][j] = (i + j) mod 7,
%       B[i][j] = (i*j) mod 5, C[i][j] = sum over k of A[i][k]*B[k][j]; the sum of C is
%       printed. Plain triple loop, 125 million multiply-adds, no shortcuts.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    functor(A, a, 250000),
    functor(B, b, 250000),
    functor(C, c, 250000),
    fill_a(0, A),
    fill_b(0, B),
    rows(0, A, B, C, 0, Total),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(standard_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Total]).

fill_a(I, A) :-
    (   I >= 250000
    ->  true
    ;   I2 is I + 1,
        Row is I // 500,
        Col is I mod 500,
        V is (Row + Col) mod 7,
        nb_setarg(I2, A, V),
        fill_a(I2, A)
    ).

fill_b(I, B) :-
    (   I >= 250000
    ->  true
    ;   I2 is I + 1,
        Row is I // 500,
        Col is I mod 500,
        V is (Row * Col) mod 5,
        nb_setarg(I2, B, V),
        fill_b(I2, B)
    ).

rows(I, A, B, C, Acc, Total) :-
    (   I >= 500
    ->  Total = Acc
    ;   cols(I, 0, A, B, C, Acc, Acc1),
        I1 is I + 1,
        rows(I1, A, B, C, Acc1, Total)
    ).

cols(I, J, A, B, C, Acc, Total) :-
    (   J >= 500
    ->  Total = Acc
    ;   dot(I, J, 0, A, B, 0, S),
        Idx is I * 500 + J + 1,
        nb_setarg(Idx, C, S),
        Acc1 is Acc + S,
        J1 is J + 1,
        cols(I, J1, A, B, C, Acc1, Total)
    ).

dot(I, J, K, A, B, Sum, S) :-
    (   K >= 500
    ->  S = Sum
    ;   Ai is I * 500 + K + 1,
        Bk is K * 500 + J + 1,
        arg(Ai, A, Va),
        arg(Bk, B, Vb),
        Sum1 is Sum + Va * Vb,
        K1 is K + 1,
        dot(I, J, K1, A, B, Sum1, S)
    ).
