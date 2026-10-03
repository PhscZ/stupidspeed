% task 08 average — expected output: 0.498046875
% build: mmc --make m08_average -o prog    run: ./prog

:- module m08_average.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module float, int, list, string.

main(!IO) :-
    loop(0, 100000000, 0.0, Total),
    Avg = Total / 100000000.0,
    io.format("%.9f\n", [f(Avg)], !IO).

:- pred loop(int::in, int::in, float::in, float::out) is det.
loop(I, N, !Total) :-
    ( if I >= N then
        true
    else
        !:Total = !.Total + float(I mod 256) / 256.0,
        loop(I + 1, N, !Total)
    ).
