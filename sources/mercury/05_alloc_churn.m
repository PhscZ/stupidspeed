% task 05 alloc_churn — expected output: 1274991808
% build: mmc --make m05_alloc_churn -o prog    run: ./prog
% note: the 64-byte blocks are 8-word heap terms and reclamation is left to the
% Boehm collector, which is the closest Mercury equivalent of the C row's malloc.
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m05_alloc_churn.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module array, int, list, string, time.

:- type blob
    --->    blob(int, int, int, int, int, int, int, int).

main(!IO) :-
    time.clock(SS_T0, !IO),
    Zero = blob(0, 0, 0, 0, 0, 0, 0, 0),
    Slots0 = array.init(256, Zero),
    churn(0, 10000000, Slots0, _Slots, 0, Total),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
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
