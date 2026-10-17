% task 04 array_sum — expected output: 599999940000000
% build: mmc --make m04_array_sum -o prog    run: ./prog
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m04_array_sum.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module array, int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    N = 10000000,
    A0 = array.init(N, 0),
    fill(0, N, A0, A),
    sum12(12, A, 0, Total),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(Total)], !IO).

:- pred fill(int::in, int::in, array(int)::array_di, array(int)::array_uo)
    is det.
fill(I, N, !A) :-
    ( if I >= N then
        true
    else
        array.set(I, I, !A),
        fill(I + 1, N, !A)
    ).

:- pred sum12(int::in, array(int)::in, int::in, int::out) is det.
sum12(R, A, Acc0, Acc) :-
    ( if R =< 0 then
        Acc = Acc0
    else
        Acc1 = array.foldl(func(X, T) = X + T, A, Acc0),
        sum12(R - 1, A, Acc1, Acc)
    ).
