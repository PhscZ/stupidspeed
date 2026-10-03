% task 04 array_sum — expected output: 499999500000
% build: mmc --make m04_array_sum -o prog    run: ./prog

:- module m04_array_sum.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module array, int, list, string.

main(!IO) :-
    N = 1000000,
    A0 = array.init(N, 0),
    fill(0, N, A0, A),
    Total = array.foldl(func(X, Acc) = X + Acc, A, 0),
    io.format("%d\n", [i(Total)], !IO).

:- pred fill(int::in, int::in, array(int)::array_di, array(int)::array_uo)
    is det.
fill(I, N, !A) :-
    ( if I >= N then
        true
    else
        array.set(I, I, !A),
        fill(I + 1, N, !A)
    ).
