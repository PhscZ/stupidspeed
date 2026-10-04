% task 11 parallel_sum — expected output: 7500000075000000
% build: mmc --make --grade hlc.par.gc m11_parallel_sum -o prog    run: ./prog
% note: four OS threads, one per range, created with thread.spawn_native; the
% results come back through an mvar. The hlc.par.gc grade must be installed
% (`make install_grades` in the source tree); the single-threaded hlc.gc grade
% cannot spawn native threads at all.
% note: verified here — `hlc.par.gc` is installed in the tools/mercury tree, and
%       `mercury_compile --make m11_parallel_sum --grade hlc.par.gc` builds and runs it,
%       printing 7500000075000000. Every other module in this row builds with
%       --grade hlc.gc.pregen.
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m11_parallel_sum.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is cc_multi.
:- implementation.
:- import_module int, list, maybe, string, thread, thread.mvar, time.

:- pragma require_feature_set([concurrency]).

main(!IO) :-
    time.clock(SS_T0, !IO),
    mvar.init(MVar, !IO),
    spawn_workers(0, MVar, !IO),
    collect(0, MVar, 0, Total, !IO),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(Total)], !IO).

:- pred spawn_workers(int::in, mvar(int)::in, io::di, io::uo) is cc_multi.
spawn_workers(T, MVar, !IO) :-
    ( if T >= 4 then
        true
    else
        thread.spawn_native(worker(T, MVar), Res, !IO),
        (
            Res = maybe.ok(_)
        ;
            Res = maybe.error(Err),
            io.format("spawn failed: %s\n", [s(Err)], !IO),
            io.set_exit_status(1, !IO)
        ),
        spawn_workers(T + 1, MVar, !IO)
    ).

:- pred worker(int::in, mvar(int)::in, thread::in, io::di, io::uo) is cc_multi.
worker(T, MVar, _Thread, !IO) :-
    work_range(T, Acc),
    mvar.put(MVar, Acc, !IO).

:- pred collect(int::in, mvar(int)::in, int::in, int::out, io::di, io::uo)
    is det.
collect(I, MVar, !Total, !IO) :-
    ( if I >= 4 then
        true
    else
        mvar.take(MVar, V, !IO),
        !:Total = !.Total + V,
        collect(I + 1, MVar, !Total, !IO)
    ).

:- pred work_range(int::in, int::out) is det.
work_range(T, Acc) :-
    Lo = T * 25000000,
    Hi = Lo + 25000000,
    work_loop(Lo, Hi, 0, Acc).

:- pred work_loop(int::in, int::in, int::in, int::out) is det.
work_loop(I, Hi, !Acc) :-
    ( if I >= Hi then
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
        work_loop(I + 1, Hi, !Acc)
    ).
