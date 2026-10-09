% task 08 average — expected output: 0.498046875
% build: mmc --make m08_average -o prog    run: ./prog
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m08_average.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module float, int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    loop(0, 100000000, 0.0, Total),
    Avg = Total / 100000000.0,
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%.9f\n", [f(Avg)], !IO).

:- pred loop(int::in, int::in, float::in, float::out) is det.
loop(I, N, !Total) :-
    ( if I >= N then
        true
    else
        !:Total = !.Total + float(I mod 256) / 256.0,
        loop(I + 1, N, !Total)
    ).
