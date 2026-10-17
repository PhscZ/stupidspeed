% task 05 alloc_churn — expected output: 6374991808
% build: gplc --no-top-level -o 05_alloc_churn.exe 05_alloc_churn.pl <shim.c>
% run:   exec/gprolog/gplc/05_alloc_churn/05_alloc_churn.exe
%
% note: the 64-byte buffer is an 8-argument compound term (8 cells), exactly as in the
%       swipl row: buf[0] is argument 1 and is written with setarg/3, this Prolog's
%       destructive assignment. The 256-slot ring that keeps the last 256 buffers
%       reachable cannot be one compound term because GNU Prolog's arity cap is 255
%       (MAX_ARITY = NB_OF_X_REGS - 1), so it is two 128-argument compounds; slot
%       (i mod 256) selects one of them. Fifty million allocations plus the ring is what
%       puts pressure on the garbage collector, as in the C row.
% note: the build reserves a 4 GB global stack for this task (gplc --global-size
%       4194304, see exec/gprolog/build_all.bat). GNU Prolog 1.5.0 has no garbage
%       collector -- the manual never mentions one, garbage_collect/0 does not exist and
%       the global stack pointer only ever moves forward -- so the fifty million 72-byte
%       buffers are 3.6 GB of live heap that is never reclaimed, and the default 32 MB
%       dies with "Fatal Error: global stack overflow (size: 32768 Kb, ... GLOBALSZ)".
%       3.6 GB is the measured cost of the buffers themselves and 4 GB is used for
%       margin; on this 8 GB host the row therefore runs at the edge of the machine, which
%       is the honest cost of this task on an implementation with no collector, and it is
%       why the swipl row (which does collect) and this one are not the same measurement.
% note: measured region: the loop only; see 01_branches.pl for the pipeline note and
%       for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    functor(S1, s, 128),
    functor(S2, s, 128),
    loop(0, S1, S2, 0, T0).

loop(I, S1, S2, Acc, T0) :-
    (   I >= 50000000
    ->  real_time(T1),
        Ms is T1 - T0,
        format(user_error, "TIME_MS=~w~n", [Ms]),
        format("~w~n", [Acc]),
        halt
    ;   functor(Buf, b, 8),
        V is I mod 256,
        setarg(1, Buf, V),
        S is (I mod 256) + 1,
        (   S =< 128
        ->  setarg(S, S1, Buf)
        ;   S2i is S - 128,
            setarg(S2i, S2, Buf)
        ),
        Acc1 is Acc + V,
        I1 is I + 1,
        loop(I1, S1, S2, Acc1, T0)
    ).
