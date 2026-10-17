% task 13 matrix_mul — expected output: 599995000
% build: mmc --make m13_matrix_mul -o prog    run: ./prog
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m13_matrix_mul.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module array, int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    N = 500,
    E = N * N,
    A0 = array.init(E, 0),
    B0 = array.init(E, 0),
    C0 = array.init(E, 0),
    fill_ab(0, N, A0, A, B0, B),
    mul(0, N, A, B, C0, C),
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
        array.set(Idx, (I + J) mod 7, !A),
        array.set(Idx, (I * J) mod 5, !B),
        fill_row(J + 1, I, N, !A, !B)
    ).

    % plain i, j, k triple loop, in that order
:- pred mul(int::in, int::in, array(int)::in, array(int)::in,
    array(int)::array_di, array(int)::array_uo) is det.
mul(I, N, A, B, !C) :-
    ( if I >= N then
        true
    else
        mul_row(0, I, N, A, B, !C),
        mul(I + 1, N, A, B, !C)
    ).

:- pred mul_row(int::in, int::in, int::in, array(int)::in, array(int)::in,
    array(int)::array_di, array(int)::array_uo) is det.
mul_row(J, I, N, A, B, !C) :-
    ( if J >= N then
        true
    else
        sum_k(0, N, I, J, A, B, 0, Sum),
        array.set(I * N + J, Sum, !C),
        mul_row(J + 1, I, N, A, B, !C)
    ).

:- pred sum_k(int::in, int::in, int::in, int::in, array(int)::in,
    array(int)::in, int::in, int::out) is det.
sum_k(K, N, I, J, A, B, !Sum) :-
    ( if K >= N then
        true
    else
        !:Sum = !.Sum + array.lookup(A, I * N + K)
            * array.lookup(B, K * N + J),
        sum_k(K + 1, N, I, J, A, B, !Sum)
    ).
