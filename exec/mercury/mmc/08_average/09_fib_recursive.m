% task 09 fib_recursive — expected output: 102334155
% build: mmc --make m09_fib_recursive -o prog    run: ./prog
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m09_fib_recursive.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    % fib(40) is evaluated into a variable first: computing it inside the
    % io.format argument list would place all 331 million calls after the
    % timer stops.
    SS_R = fib(40),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(SS_R)], !IO).

:- func fib(int) = int.
fib(N) = ( if N < 2 then N else fib(N - 1) + fib(N - 2) ).
