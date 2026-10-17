% task 15 file_write — expected output: 419430400
% build: gplc --no-top-level -o 15_file_write.exe 15_file_write.pl <shim.c>
% run:   exec/gprolog/gplc/15_file_write/15_file_write.exe
%
% note: the buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 50
%       times per pass over 8 passes to out.bin (52428800 bytes per pass, 419430400 in
%       all). The buffer is a code list of 1048576 elements built with a difference list,
%       so the build is tail recursive and the list is built once and reused for all
%       four hundred writes.
% note: DEVIATION, forced by the language: GNU Prolog has no bulk byte-write to a binary
%       stream. format(S, "~s", [Codes]) is rejected on a binary stream with
%       `error(permission_error(output,binary_stream,$stream(3)),format/3)`, and a text
%       stream would translate the 0x0A and 0x0D bytes in the pattern on Windows. The
%       buffer is therefore written with put_byte/2, one byte at a time, 419430400 calls
%       in all. The bytes written are exactly the pattern -- it is the same bytes the C
%       row writes -- only the write granularity differs.
% note: DEVIATION: GNU Prolog has no fsync, so each pass's flush_output/1 pushes the buffer
%       to the OS and close/1 closes the stream, exactly what the swipl row does.
% note: measured region: the writes only; see 01_branches.pl for the pipeline note
%       and for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    pattern(0, 256, Block, []),
    copies(4096, Block, Buf, []),
    length(Buf, Len),
    passes(8, Buf, Len, 0, Written),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Written]),
    halt.

% one pass: reopen out.bin (truncating it at offset 0), write 50 times, flush and close
passes(0, _, _, W, Written) :-
    !,
    Written = W.
passes(N, Buf, Len, W0, Written) :-
    open('out.bin', write, S, [type(binary)]),
    write_loop(50, S, Buf, Len, 0, W1),
    flush_output(S),
    close(S),
    N1 is N - 1,
    W2 is W0 + W1,
    passes(N1, Buf, Len, W2, Written).

pattern(I, N, L, T) :-
    (   I >= N
    ->  L = T
    ;   J is I + 1,
        L = [I | L1],
        pattern(J, N, L1, T)
    ).

copies(0, _, L, T) :-
    !,
    L = T.
copies(N, X, L, T) :-
    N1 is N - 1,
    append(X, L1, L),
    copies(N1, X, L1, T).

write_loop(0, _, _, _, W, Written) :-
    !,
    Written = W.
write_loop(N, S, Buf, Len, W0, Written) :-
    put_all(Buf, S),
    N1 is N - 1,
    W1 is W0 + Len,
    write_loop(N1, S, Buf, Len, W1, Written).

put_all([], _) :-
    !.
put_all([C | T], S) :-
    put_byte(S, C),
    put_all(T, S).
