% task 14 file_read — expected output: 1937768448
% build: gplc --no-top-level -o 14_file_read.exe 14_file_read.pl <shim.c>
% run:   exec/gprolog/gplc/14_file_read/14_file_read.exe   (data.bin beside it)
%
% note: data.bin is opened from the working directory as a binary stream -- type(binary)
%       means no translation -- and read one byte at a time with get_byte/2, which
%       returns 0..255 or -1 at end of file, exactly as the swipl row does. GNU Prolog
%       buffers the stream, so this is a call per byte rather than a syscall per byte.
%       The open/read/close sequence is repeated 8 times, each pass starting at the
%       beginning of the file, and the total accumulates across all 8 passes.
% note: GNU Prolog integers are 60-bit, and the running total over 8 passes peaks at
%       53477376000, far below PL_MAX_INTEGER, so the whole file is summed 8 times over
%       and the mod 2^32 checksum is applied once at the end, as in the swipl row.
% note: measured region: the read loop only; see 01_branches.pl for the pipeline note and
%       for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    read_passes(8, 0, Total),
    Checksum is Total mod 4294967296,
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Checksum]),
    halt.

read_passes(0, Acc, Acc).
read_passes(N, Acc, Total) :-
    N > 0,
    open('data.bin', read, S, [type(binary)]),
    read_loop(S, Acc, Acc1),
    close(S),
    N1 is N - 1,
    read_passes(N1, Acc1, Total).

read_loop(S, Acc, Total) :-
    get_byte(S, B),
    (   B =:= -1
    ->  Total = Acc
    ;   Acc1 is Acc + B,
        read_loop(S, Acc1, Total)
    ).
