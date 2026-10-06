% task 07 string_append — expected output: 250000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 07_string_append.pl
% note: SWI strings are immutable and there is no string builder in the standard library,
%       so appending one character is string_concat/3, which allocates a whole new string
%       each time. This cell is quadratic by design: 250000 appends copy about 3.1x10^10
%       characters in total, which makes it the row's slow cell, documented as such -- the
%       same kind of cell as the Racket row's task 07.
% note: string_concat/3 is used rather than atom_concat/3 on purpose: atoms are interned
%       in a global table, so 250000 distinct ~250 KB atoms would be pathological.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    nb_setval(time_t0, T0),
    loop(250000, "").

loop(0, Text) :-
    !,
    string_length(Text, L),
    nb_getval(time_t0, T0),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(user_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [L]).
loop(N, Text) :-
    string_concat(Text, "x", Text1),
    N1 is N - 1,
    loop(N1, Text1).
