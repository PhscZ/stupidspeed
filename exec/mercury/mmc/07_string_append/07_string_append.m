% task 07 string_append — expected output: 250000
% build: mmc --make m07_string_append -o prog    run: ./prog
% note: Mercury strings are immutable, so each ++ copies the whole string, which
% is the same quadratic work the C row does with realloc plus strcat.
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m07_string_append.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    append_x(250000, "", Text),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(string.length(Text))], !IO).

:- pred append_x(int::in, string::in, string::out) is det.
append_x(N, Text0, Text) :-
    ( if N =< 0 then
        Text = Text0
    else
        append_x(N - 1, Text0 ++ "x", Text)
    ).
