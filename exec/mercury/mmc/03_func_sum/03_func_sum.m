% task 03 func_sum — expected output: 100000000
% build: mmc --make m03_func_sum -o prog    run: ./prog
% note: DEVIATION, measured on this machine. The hundred million calls are written out and
%       the `:- pragma no_inline` is present, but the hlc.gc.pregen grade emits C and lets
%       gcc -O2 fold the loop anyway: the generated C does call add_one
%       (`STATE_VARIABLE_Value = m03x__add_one_1_f_0(STATE_VARIABLE_Value)`), yet the
%       executable finishes in 65 ms, and raising the loop to 1e9 iterations (a tenfold
%       increase) moved that only to 124 ms, so the calls are not happening at run time.
%       The pragma does suppress the Mercury-level inlining; what defeats the cell is the C
%       back end. The cell therefore measures an empty loop, and it is recorded rather than
%       worked around.
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

main(!IO) :-
    time.clock(SS_T0, !IO),
    loop(0, 100000000, 0, Value),
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

:- func add_one(int) = int.
:- pragma no_inline(func(add_one/1)).
add_one(N) = N + 1.
