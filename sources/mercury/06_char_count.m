% task 06 char_count — expected output: 10000000
% build: mmc --make m06_char_count -o prog    run: ./prog
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m06_char_count.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module char, int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    Block = "abcdefghij",
    Blocks = list.duplicate(10000000, Block),
    Text = string.append_list(Blocks),
    string.foldl(count_char, Text, 0, Count),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(Count)], !IO).

:- pred count_char(char::in, int::in, int::out) is det.
count_char(C, A0, A) :-
    ( if C = 'h' then
        A = A0 + 1
    else
        A = A0
    ).
