% task 12 matrix_add — expected output: 999000000
% build: mmc --make m12_matrix_add -o prog    run: ./prog
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m12_matrix_add.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module array, int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    N = 1000,
    E = N * N,
    A0 = array.init(E, 0),
    B0 = array.init(E, 0),
    C0 = array.init(E, 0),
    fill_ab(0, N, A0, A, B0, B),
    add_ab(0, N, A, B, C0, C),
    Total = array.foldl(func(X, Acc) = X + Acc, C, 0),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(Total)], !IO).

:- pred fill_ab(int::in, int::in,
    array(int)::array_di, array(int)::array_uo,
    array(int)::array_di, array(int)::array_uo) is det.
fill_ab(I, N, !A, !B) :-
    ( if I >= N then
        true
    else
        fill_row(0, I, N, !A, !B),
        fill_ab(I + 1, N, !A, !B)
    ).

:- pred fill_row(int::in, int::in, int::in,
    array(int)::array_di, array(int)::array_uo,
    array(int)::array_di, array(int)::array_uo) is det.
fill_row(J, I, N, !A, !B) :-
    ( if J >= N then
        true
    else
        Idx = I * N + J,
        array.set(Idx, I + J, !A),
        array.set(Idx, I - J, !B),
        fill_row(J + 1, I, N, !A, !B)
    ).

:- pred add_ab(int::in, int::in, array(int)::in, array(int)::in,
    array(int)::array_di, array(int)::array_uo) is det.
add_ab(I, N, A, B, !C) :-
    ( if I >= N then
        true
    else
        add_row(0, I, N, A, B, !C),
        add_ab(I + 1, N, A, B, !C)
    ).

:- pred add_row(int::in, int::in, int::in, array(int)::in, array(int)::in,
    array(int)::array_di, array(int)::array_uo) is det.
add_row(J, I, N, A, B, !C) :-
    ( if J >= N then
        true
    else
        Idx = I * N + J,
        array.set(Idx, array.lookup(A, Idx) + array.lookup(B, Idx), !C),
        add_row(J + 1, I, N, A, B, !C)
    ).
