% task 14 file_read — expected output: 2389704704
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 14_file_read.pl
% note: data.bin is opened from the working directory as a binary stream -- type(binary)
%       means no translation and the default encoding is octet -- and read one byte at a
%       time with get_byte/2 (0..255, or -1 at end of file). SWI's default full buffering
%       makes this a call per byte rather than a syscall per byte.
% note: SWI integers are unbounded, so the running total needs none of the
%       modulo-2^32-per-chunk workaround; the checksum is applied once at the end.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    open('data.bin', read, S, [type(binary)]),
    read_loop(S, 0, Total),
    close(S),
    Checksum is Total mod 4294967296,
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(user_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Checksum]).

read_loop(S, Acc, Total) :-
    get_byte(S, B),
    (   B =:= -1
    ->  Total = Acc
    ;   Acc1 is Acc + B,
        read_loop(S, Acc1, Total)
    ).
