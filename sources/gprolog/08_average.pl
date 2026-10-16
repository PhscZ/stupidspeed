% task 08 average — expected output: 0.498046875
% build: gplc --no-top-level -o 08_average.exe 08_average.pl <shim.c>
% run:   exec/gprolog/gplc/08_average/08_average.exe
%
% note: / is float division when an operand is a float, so 256.0 forces it, exactly as
%       in the swipl row. Every term is a dyadic multiple of 1/256 and the running total
%       stays far below 2^53, so the sum is exact and the final average is exactly
%       0.498046875. GNU Prolog prints a float with the shortest decimal that reads back
%       to the same double, which for this value is 0.498046875.
% note: DEVIATION, forced by the implementation: the hundred million iterations are a
%       backtracking loop rather than a tail recursion. GNU Prolog 1.5.0 has no garbage
%       collector at all -- the manual never mentions one, there is no garbage_collect/0
%       or '$gc'/0 to call (both are "existence_error(procedure, ...)" at run time), and
%       the global stack pointer only ever moves forward. A float cell is 8 bytes and the
%       loop builds two or three of them per iteration, so the tail-recursive form
%       allocates 24 bytes per iteration, 2.4 GB over the task, and dies with
%       "Fatal Error: global stack overflow (size: 32768 Kb, ... GLOBALSZ)". Raising the
%       heap does not help: gplc --global-size accepts up to about 1.9 GB before the
%       engine reports "Memory allocation fault" (measured: 1572864 Kb links and runs,
%       2097152 Kb fails to start), and 2.4 GB is past that ceiling anyway. GNU Prolog's
%       own answer to this, stated in the manual under repeat/0, is the backtracking
%       loop: "when the test fails back, the Prolog engine immediately reclaims any
%       working storage consumed since the call to repeat/0". So the loop is
%       between(0, 199999999, _) with the accumulator in a global variable (g_assign/2 is
%       deliberately not undone at backtracking, unlike setarg/3), and the heap stays
%       bounded at a few hundred kilobytes. The loop body, the order of the iterations
%       and the answer are the same as the tail-recursive form's; only the loop's
%       reclamation mechanism differs.
% note: measured region: the between/3 loop only; see 01_branches.pl for the pipeline
%       note and for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    g_assign(avg_acc, 0.0),
    loop,
    g_read(avg_acc, Total),
    Avg is Total / 200000000,
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Avg]),
    halt.

loop :-
    between(0, 199999999, I),
    Reading is (I mod 256) / 256.0,
    g_read(avg_acc, Acc),
    Acc1 is Acc + Reading,
    g_assign(avg_acc, Acc1),
    fail.
loop.
