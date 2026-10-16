% task 06 char_count — expected output: 25000000
% build: gplc --no-top-level -o 06_char_count.exe 06_char_count.pl <shim.c>
% run:   exec/gprolog/gplc/06_char_count/06_char_count.exe
%
% note: GNU Prolog has no string type and no string builder. Materialising the 250 MB
%       text as one atom is not an option (atoms are interned, so building it by
%       concatenation is quadratic and it would never be collected), and a flat list of
%       250000000 code cells would need about 1.6 GB. The text is therefore represented
%       as 25000000 repetitions of the ten-character block and scanned block by block:
%       count/4 walks the block's code list once per repetition, so exactly the same
%       250000000 character comparisons happen as in the C and swipl rows, and the same
%       'h' (code 104) is the only one counted. The block's code list is built once and
%       shared, which is why this stays inside the default heap.
% note: measured region: the scan only; see 01_branches.pl for the pipeline note and
%       for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    atom_codes(abcdefghij, Block),
    count(25000000, Block, 0, Total),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Total]),
    halt.

count(0, _, N, Total) :-
    !,
    Total = N.
count(K, Block, N0, Total) :-
    walk(Block, 0, K1),
    N1 is N0 + K1,
    K2 is K - 1,
    count(K2, Block, N1, Total).

walk([], K, K) :-
    !.
walk([C | T], K0, K) :-
    (   C =:= 104
    ->  K1 is K0 + 1
    ;   K1 = K0
    ),
    walk(T, K1, K).
