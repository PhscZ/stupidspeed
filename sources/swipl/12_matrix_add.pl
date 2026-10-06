% task 12 matrix_add — expected output: 999000000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 12_matrix_add.pl
% note: each 1000x1000 matrix is a 1000000-argument compound term (SWI's array idiom,
%       see 04_array_sum.pl) laid out row-major, so element [i][j] is argument
%       i*1000 + j + 1 -- the same layout and the same arithmetic as the C row.
%       A[i][j] = i + j, B[i][j] = i - j, C = A + B, and the sum of C is printed.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    functor(A, a, 1000000),
    functor(B, b, 1000000),
    functor(C, c, 1000000),
    fill(0, A, B),
    add(1, A, B, C, 0, Total),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(user_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Total]).

fill(I, A, B) :-
    (   I >= 1000000
    ->  true
    ;   I2 is I + 1,
        Row is I // 1000,
        Col is I mod 1000,
        Va is Row + Col,
        Vb is Row - Col,
        nb_setarg(I2, A, Va),
        nb_setarg(I2, B, Vb),
        fill(I2, A, B)
    ).

add(I, A, B, C, Acc, Total) :-
    (   I > 1000000
    ->  Total = Acc
    ;   arg(I, A, Va),
        arg(I, B, Vb),
        Vc is Va + Vb,
        nb_setarg(I, C, Vc),
        Acc1 is Acc + Vc,
        I1 is I + 1,
        add(I1, A, B, C, Acc1, Total)
    ).
