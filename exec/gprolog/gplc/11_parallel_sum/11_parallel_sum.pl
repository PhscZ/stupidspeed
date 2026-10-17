% task 11 parallel_sum — expected output: 8748000081000000
% build: gplc --no-top-level -o 11_parallel_sum.exe 11_parallel_sum.pl <shim.c>
% run:   exec/gprolog/gplc/11_parallel_sum/11_parallel_sum.exe
%
% note: GNU Prolog 1.5.0 has no thread primitive of any kind. There is no thread_create/3,
%       no thread_self/1, no thread_join/2 and no concurrent/3 anywhere in the system --
%       "thread" appears zero times in doc/gprolog.html and the predicates do not exist at
%       run time. The exact errors, from a compiled program that catches them, are:
%
%         thread_self/1   -> error(existence_error(procedure,thread_self/1),main/0)
%         thread_create/3 -> error(existence_error(procedure,thread_create/3),main/0)
%
%       There is no threading extension for GNU Prolog either, so the README's escape
%       hatch ("the language's own threading extension when the standard library has
%       none") has nothing to name.
% note: the four workers are therefore four child PROCESSES, which is what the hashlink,
%       VBScript, COBOL and gforth rows do for the same reason. The child is the same
%       compiled executable, re-invoked with its quarter index as an argument -- not
%       gprolog.exe interpreting a .pl -- so the code that runs in the children is the
%       native code gplc produced, which is the whole point of this row. The parent finds
%       its own path with argument_value(0, Self) (documented as "the first argument is
%       always the name of the running program") and hands it to the shell through exec/5.
% note: exec/5 is used rather than spawn/3 because spawn/3 BLOCKS until the child
%       terminates ("the control is returned to Prolog upon termination of the command"),
%       which would serialise the four quarters. exec/5 takes the command as one atom --
%       it is passed to the default shell, so the program path is quoted and the quarter
%       index appended -- and returns immediately with the Pid; the process stays in the
%       process table until wait/2 collects it. The parent therefore starts all four
%       children before waiting on any of them, and the four quarters really do run at
%       once. The exec/5 calls, the four wait/2 joins, the four file reads and the sum are
%       all inside the measured region.
% note: each worker still owns exactly t*27000000..(t+1)*27000000-1 and nothing else, so
%       which one finishes first cannot change the answer, and the arithmetic is task 02's
%       switch over i mod 4 unchanged -- the four children together do exactly the work of
%       task 02 and print the same number, so one core against four is directly comparable.
%       Measured on this machine: task 02 (the same 108000000 iterations in one process)
%       takes 22077 ms, this cell takes 8669 / 12314 / 10459 ms over three runs, about 2.1x
%       on four cores; one child alone over its own quarter takes 6.5 s wall including
%       process start-up, so the quarters are genuinely overlapping rather than running
%       one after another (four children in sequence would be about 26 s).
% note: the child hands its partial back through a file in the working directory, named
%       gprolog_t11_part_<t>.txt, the same shape the hashlink row uses. The parent reads
%       all four after waiting, deletes them, and leaves nothing behind.
% note: real_time/1 is milliseconds since the Prolog engine started (documented under
%       8.24.2: "real_time(Time) unifies Time with the absolute time elapsed since the
%       start of Prolog"), and the engine starts before main/0 runs, so every TIME_MS in
%       this row is a difference of two such readings and the origin cancels.
% note: measured region: the four exec/5 calls, the four wait/2 joins, the four file reads
%       and the sum. The native pipeline (pl2wam, wam2ma, ma2asm, as, gcc) is at build time;
%       see 01_branches.pl.

:- initialization(main).

main :-
    (   argument_value(1, _)
    ->  child
    ;   parent
    ).

% ---------------------------------------------------------------- child
% One quarter: read the index, compute its partial, write it to its own file.
child :-
    argument_value(1, Arg),
    atom_codes(Arg, Codes),
    number_codes(T, Codes),
    work(T, R),
    format_to_atom(Name, "gprolog_t11_part_~w.txt", [T]),
    open(Name, write, S),
    format(S, "~w", [R]),
    close(S).

% ---------------------------------------------------------------- parent
parent :-
    real_time(T0),
    argument_value(0, Self),
    exec_quarter(Self, 0, P0),
    exec_quarter(Self, 1, P1),
    exec_quarter(Self, 2, P2),
    exec_quarter(Self, 3, P3),
    wait(P0, _),
    wait(P1, _),
    wait(P2, _),
    wait(P3, _),
    read_part(0, R0),
    read_part(1, R1),
    read_part(2, R2),
    read_part(3, R3),
    Total is R0 + R1 + R2 + R3,
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Total]),
    halt.

exec_quarter(Self, T, Pid) :-
    format_to_atom(Cmd, "\"~w\" ~w", [Self, T]),
    exec(Cmd, Sin, Sout, Serr, Pid),
    close(Sin),
    close(Sout),
    close(Serr).

read_part(T, R) :-
    format_to_atom(Name, "gprolog_t11_part_~w.txt", [T]),
    open(Name, read, S, [type(binary)]),
    read_number(S, 0, R),
    close(S),
    delete_file(Name).

read_number(S, Acc, R) :-
    get_byte(S, B),
    (   B =:= -1
    ->  R = Acc
    ;   D is B - 48,
        Acc1 is Acc * 10 + D,
        read_number(S, Acc1, R)
    ).

% ---------------------------------------------------------------- the work
% Task 02's switch over this worker's own quarter.
work(T, R) :-
    Start is T * 27000000,
    End is (T + 1) * 27000000,
    wloop(Start, End, 0, R).

wloop(I, End, Acc, R) :-
    (   I >= End
    ->  R = Acc
    ;   M is I mod 4,
        (   M =:= 0
        ->  Acc1 is Acc + 1
        ;   M =:= 1
        ->  Acc1 is Acc + I
        ;   M =:= 2
        ->  Acc1 is Acc + 2 * I
        ;   Acc1 is Acc + 3 * I
        ),
        I1 is I + 1,
        wloop(I1, End, Acc1, R)
    ).
