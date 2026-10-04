% task 10 pi — expected output: 4470
% build: mmc --make m10_pi -o prog    run: ./prog
% note: Mercury ships arbitrary-precision integers in the standard library, so
% the spigot state is held in `integer' values instead of the C row's hand-written
% sign-magnitude base-1e9 limbs.
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m10_pi.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, integer, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    spigot(integer.one, integer.zero, integer.one, 1, 3, 3, 0, 0, Sum),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(Sum)], !IO).

:- pred spigot(integer::in, integer::in, integer::in, int::in, int::in,
    int::in, int::in, int::in, int::out) is det.
spigot(Q, R, T, K, L, N, Produced, Sum0, Sum) :-
    ( if Produced >= 1000 then
        Sum = Sum0
    else
        U0 = integer(4) * Q + R,
        V0 = integer(N + 1) * T,
        ( if U0 < V0 then
            Sum1 = Sum0 + N,
            U1 = integer(10) * (integer(3) * Q + R),
            Next = U1 div T - integer(10 * N),
            R1 = integer(10) * (R - integer(N) * T),
            Q1 = integer(10) * Q,
            spigot(Q1, R1, T, K, L, integer.det_to_int(Next), Produced + 1,
                Sum1, Sum)
        else
            U2 = Q * integer(7 * K + 2) + R * integer(L),
            V2 = T * integer(L),
            Next = U2 div V2,
            R1 = (integer(2) * Q + R) * integer(L),
            Q1 = Q * integer(K),
            T1 = T * integer(L),
            spigot(Q1, R1, T1, K + 1, L + 2, integer.det_to_int(Next),
                Produced, Sum0, Sum)
        )
    ).
