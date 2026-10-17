% task 13 matrix_mul — expected output: 599995000
% build: gplc --no-top-level -o 13_matrix_mul.exe 13_matrix_mul.pl <shim.c>
% run:   exec/gprolog/gplc/13_matrix_mul/13_matrix_mul.exe
%
% note: n = 500, and the arity cap of 255 rules out the swipl row's flat 250000-argument
%       compound term, so each matrix is a list of 500 rows of 500 elements. Element
%       [i][j] is row i, position j. A[i][j] = (i + j) mod 7, B[i][j] = (i*j) mod 5, and
%       C[i][j] = sum over k of A[i][k]*B[k][j]. The k loop is a parallel walk of A's row
%       i and B's column j, which is what the transpose is for: B is transposed once into
%       a list of 500 columns, so each dot product is a straight two-list walk instead of
%       a two-dimensional index computation. Same triple loop, same 125 million
%       multiply-adds, no shortcuts; only the answer's sum is printed, and the sum of C
%       is accumulated as C's rows are produced.
% note: measured region: the build, the transpose and the multiply only; see
%       01_branches.pl for the pipeline note and for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    fill_a(0, A),
    fill_b(0, B),
    transpose(B, Bt),
    mul(A, Bt, 0, Total),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Total]),
    halt.

fill_a(I, A) :-
    (   I >= 500
    ->  A = []
    ;   row_a(I, 0, R),
        J is I + 1,
        fill_a(J, A1),
        A = [R | A1]
    ).

row_a(I, J, R) :-
    (   J >= 500
    ->  R = []
    ;   V is (I + J) mod 7,
        J1 is J + 1,
        row_a(I, J1, R1),
        R = [V | R1]
    ).

fill_b(I, B) :-
    (   I >= 500
    ->  B = []
    ;   row_b(I, 0, R),
        J is I + 1,
        fill_b(J, B1),
        B = [R | B1]
    ).

row_b(I, J, R) :-
    (   J >= 500
    ->  R = []
    ;   V is (I * J) mod 5,
        J1 is J + 1,
        row_b(I, J1, R1),
        R = [V | R1]
    ).

transpose([], []) :-
    !.
transpose([[] | _], []) :-
    !.
transpose(M, [R | Rs]) :-
    first_cols(M, R, Rest),
    transpose(Rest, Rs).

first_cols([], [], []).
first_cols([[X | Xs] | Rows], [X | Cs], [Xs | Rest]) :-
    first_cols(Rows, Cs, Rest).

mul([], _, Acc, Total) :-
    Total = Acc.
mul([Ai | As], Bt, Acc, Total) :-
    mul_row(Ai, Bt, Acc, Acc1),
    mul(As, Bt, Acc1, Total).

mul_row(_, [], Acc, Total) :-
    Total = Acc.
mul_row(Ai, [Bj | Bjs], Acc, Total) :-
    dot(Ai, Bj, 0, S),
    Acc1 is Acc + S,
    mul_row(Ai, Bjs, Acc1, Total).

dot([], [], Acc, S) :-
    S = Acc.
dot([X | Xs], [Y | Ys], Acc, S) :-
    Acc1 is Acc + X * Y,
    dot(Xs, Ys, Acc1, S).
