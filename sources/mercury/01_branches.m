% task 01 branches — expected output: 33333334 13333333 7619048 45714285
% build: mmc --make m01_branches -o prog    run: ./prog
% note: the file name cannot be the module name (Mercury identifiers cannot start
% with a digit), so Mercury.modules maps m01_branches to 01_branches.m.

:- module m01_branches.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string.

main(!IO) :-
    loop(0, 100000000, 0, A, 0, B, 0, C, 0, D),
    io.format("%d %d %d %d\n", [i(A), i(B), i(C), i(D)], !IO).

:- pred loop(int::in, int::in, int::in, int::out, int::in, int::out,
    int::in, int::out, int::in, int::out) is det.
loop(I, N, !A, !B, !C, !D) :-
    ( if I >= N then
        true
    else
        ( if I mod 3 = 0 then
            !:A = !.A + 1
        else if I mod 5 = 0 then
            !:B = !.B + 1
        else if I mod 7 = 0 then
            !:C = !.C + 1
        else
            !:D = !.D + 1
        ),
        loop(I + 1, N, !A, !B, !C, !D)
    ).
