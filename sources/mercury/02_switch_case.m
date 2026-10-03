% task 02 switch_case — expected output: 7500000075000000
% build: mmc --make m02_switch_case -o prog    run: ./prog

:- module m02_switch_case.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string.

main(!IO) :-
    loop(0, 100000000, 0, Acc),
    io.format("%d\n", [i(Acc)], !IO).

:- pred loop(int::in, int::in, int::in, int::out) is det.
loop(I, N, !Acc) :-
    ( if I >= N then
        true
    else
        R = I mod 4,
        ( if R = 0 then
            !:Acc = !.Acc + 1
        else if R = 1 then
            !:Acc = !.Acc + I
        else if R = 2 then
            !:Acc = !.Acc + 2 * I
        else
            !:Acc = !.Acc + 3 * I
        ),
        loop(I + 1, N, !Acc)
    ).
