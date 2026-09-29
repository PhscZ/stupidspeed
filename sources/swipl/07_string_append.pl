% task 07 string_append — expected output: 1000000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 07_string_append.pl
% note: SWI strings are immutable and there is no string builder in the standard library,
%       so appending one character is string_concat/3, which allocates a whole new string
%       each time. This cell is quadratic by design: 1000000 appends copy about 5x10^11
%       characters in total. Measured on this host: 2.7 s at 100000, 8.6 s at 200000,
%       55.5 s at 400000 and 1405 s (23.4 minutes) at the committed 1000000, which makes
%       it the row's slow cell, documented as such -- the same kind of cell as the Racket
%       row's task 07 (1121 s).
% note: string_concat/3 is used rather than atom_concat/3 on purpose: atoms are interned
%       in a global table, so a million distinct ~500 KB atoms would be pathological.
% note: -O is required, see 01_branches.pl.

main :-
    loop(1000000, "").

loop(0, Text) :-
    !,
    string_length(Text, L),
    format("~w~n", [L]).
loop(N, Text) :-
    string_concat(Text, "x", Text1),
    N1 is N - 1,
    loop(N1, Text1).
