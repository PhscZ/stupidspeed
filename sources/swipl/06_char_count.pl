% task 06 char_count — expected output: 10000000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 06_char_count.pl
% note: the text is the 10-character block repeated 10000000 times, built in one pass by
%       collecting the 10000000 block references into a list and joining them with
%       atomics_to_string/2 -- not by appending in a loop. SWI strings are immutable, so
%       a loop append would be quadratic; this build is linear, and the 100 MB result is
%       the same text the C row builds.
% note: the scan walks the text a character at a time, but it has to convert it to a
%       code list to do so: on SWI-Prolog 10.0.2 reading a single character out of a long
%       string is pathologically slow (string_code/3 costs time proportional to the
%       length of the string on every call, so a linear scan with it is quadratic, and
%       sub_string/5 costs about 2 us per call whatever the index). The text is therefore
%       scanned in 1 MiB chunks, each converted once with string_codes/2 and then walked
%       with a plain list recursion. Chunking is also what keeps it inside the default
%       1 GiB stack limit: a code list for the whole 100 MB text would need about 1.6 GB.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    blocks(10000000, [], L),
    atomics_to_string(L, Text),
    count(Text, 0, 0, Total),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(standard_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Total]).

blocks(0, Acc, Acc) :-
    !.
blocks(N, Acc0, Acc) :-
    N1 is N - 1,
    blocks(N1, [abcdefghij | Acc0], Acc).

count(Text, Off, N, Total) :-
    string_length(Text, Len),
    (   Off >= Len
    ->  Total = N
    ;   Rem is Len - Off,
        Size is min(Rem, 1048576),
        sub_string(Text, Off, Size, _, Chunk),
        string_codes(Chunk, Codes),
        walk(Codes, 0, K),
        N1 is N + K,
        Off1 is Off + Size,
        count(Text, Off1, N1, Total)
    ).

walk([], K, K) :-
    !.
walk([C | T], K0, K) :-
    (   C =:= 0'h
    ->  K1 is K0 + 1
    ;   K1 = K0
    ),
    walk(T, K1, K).
