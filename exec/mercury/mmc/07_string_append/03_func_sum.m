% task 03 func_sum — expected output: 400000000
% build: mmc --make m03_func_sum -o prog    run: ./prog
% note: add_one lives in its own module, 03_func_sum_add_one.m, so its body is compiled into a
%       separate C translation unit. That is what keeps the call real: `:- pragma no_inline`
%       emits no C attribute, and the recurrence is affine with a loop-invariant trip count, so
%       gcc -O2 otherwise computes start + (N - I) in closed form and deletes the loop and the
%       call together. This is the same barrier the Fortran, Tcl and Vala task-03 rows use.
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m03_func_sum.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string, time.
:- import_module m03_func_sum_add_one.

main(!IO) :-
    time.clock(SS_T0, !IO),
    loop(0, 400000000, 0, Value),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(Value)], !IO).

:- pred loop(int::in, int::in, int::in, int::out) is det.
loop(I, N, !Value) :-
    ( if I >= N then
        true
    else
        !:Value = add_one(!.Value),
        loop(I + 1, N, !Value)
    ).
