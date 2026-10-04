% task 01 branches — expected output: 33333334 13333333 7619048 45714285
% build: mmc --make m01_branches -o prog    run: ./prog
% note: the file name cannot be the module name (Mercury identifiers cannot start
% with a digit), so Mercury.modules maps m01_branches to 01_branches.m.
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m01_branches.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    loop(0, 100000000, 0, A, 0, B, 0, C, 0, D),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 // time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
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
