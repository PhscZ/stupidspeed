% task 05 alloc_churn — expected output: 1274991808
% build: mmc --make m05_alloc_churn -o prog    run: ./prog
% note: the 64-byte blocks are 8-word heap terms and reclamation is left to the
% Boehm collector, which is the closest Mercury equivalent of the C row's malloc.

:- module m05_alloc_churn.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module array, int, list, string.

:- type blob
    --->    blob(int, int, int, int, int, int, int, int).

main(!IO) :-
    Zero = blob(0, 0, 0, 0, 0, 0, 0, 0),
    Slots0 = array.init(256, Zero),
    churn(0, 10000000, Slots0, _Slots, 0, Total),
    io.format("%d\n", [i(Total)], !IO).

:- pred churn(int::in, int::in, array(blob)::array_di, array(blob)::array_uo,
    int::in, int::out) is det.
churn(I, N, !Slots, !Total) :-
    ( if I >= N then
        true
    else
        V = I mod 256,
        B = blob(V, V, V, V, V, V, V, V),
        array.set(V, B, !Slots),
        !:Total = !.Total + V,
        churn(I + 1, N, !Slots, !Total)
    ).
