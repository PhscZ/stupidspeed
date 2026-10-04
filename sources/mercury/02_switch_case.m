% task 02 switch_case — expected output: 7500000075000000
% build: mmc --make m02_switch_case -o prog    run: ./prog
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m02_switch_case.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    loop(0, 100000000, 0, Acc),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
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
