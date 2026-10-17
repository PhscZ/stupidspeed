% task 15 file_write — expected output: 419430400
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 15_file_write.pl
% note: the buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, built once and
%       written 50 times per pass to out.bin, 8 passes over the file (reopened at offset 0
%       each pass, so the file ends at 52428800 bytes). The buffer is one string: the 256 code
%       points joined by string_codes/2, repeated 4096 times, joined by atomics_to_string/2.
%       Each write is one format(S, "~s", [Buf]) call on a binary (octet) stream; the
%       stream accepts a text string (stream_type_check is loose by default) and writes
%       each code point 0..255 as one byte.
% note: DEVIATION: SWI-Prolog has no fsync. flush_output/1 pushes the buffer to the OS
%       and close/1 closes the stream, exactly what the R row does; there is no way to
%       ask for a disk-level sync from standard SWI-Prolog.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    numlist(0, 255, Codes),
    string_codes(Block, Codes),
    copies(4096, Block, L),
    atomics_to_string(L, Buf),
    string_length(Buf, Len),
    pass_loop(8, Buf, Len, 0, Written),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(user_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Written]).

copies(0, _, []) :-
    !.
copies(N, X, [X | T]) :-
    N1 is N - 1,
    copies(N1, X, T).

pass_loop(0, _, _, W, W) :-
    !.
pass_loop(P, Buf, Len, W0, Written) :-
    open('out.bin', write, S, [type(binary)]),
    write_loop(50, S, Buf, Len, W0, W1),
    flush_output(S),
    close(S),
    P1 is P - 1,
    pass_loop(P1, Buf, Len, W1, Written).

write_loop(0, _, _, _, W, Written) :-
    !,
    Written = W.
write_loop(N, S, Buf, Len, W0, Written) :-
    format(S, "~s", [Buf]),
    W1 is W0 + Len,
    N1 is N - 1,
    write_loop(N1, S, Buf, Len, W1, Written).
