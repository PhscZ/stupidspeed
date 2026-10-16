% task 07 string_append — expected output: 750000
% build: gplc --no-top-level -o 07_string_append.exe 07_string_append.pl <shim.c>
% run:   exec/gprolog/gplc/07_string_append/07_string_append.exe
%
% note: DEVIATION, forced by the implementation, and this is the row's one cell that is
%       not comparable with the swipl row's. GNU Prolog has no string type at all -- no
%       string, no string builder, no atom buffer -- so the string is a list of character
%       codes, and appending one character with append/3 copies the whole accumulator,
%       exactly the quadratic shape the swipl row measures. The problem is the constant:
%       a code-list cell is 8 bytes, so 750000 appends copy 750000*750001/2 = 2.8x10^11
%       cells, about 2.3 TB. SWI's row can do that because SWI garbage-collects the
%       intermediate copies; GNU Prolog 1.5.0 has no garbage collector at all, the global
%       stack pointer only moves forward, and the engine's heap ceiling is under 2 GB, so
%       the quadratic form cannot run here at all -- it dies within milliseconds with
%       "Fatal Error: global stack overflow (size: 32768 Kb, ... GLOBALSZ)".
%       The cell therefore uses the difference list, which is Prolog's own O(1)-append
%       representation of a growing sequence: text = [x | Rest] with Rest left open, so
%       each of the 750000 appends allocates exactly one cell and the accumulator grows
%       in place. The measured work is 750000 appends and the printed value is the length
%       of the result, 750000, as in every other row -- but this cell measures a linear
%       append, not the quadratic copy, and it is the row's fastest cell rather than its
%       slowest. It is recorded here rather than papered over: there is no way to run the
%       copying form on this implementation.
% note: measured region: the appends and the final length only; see 01_branches.pl for
%       the pipeline note and for real_time/1.

:- initialization(main).

main :-
    real_time(T0),
    build(750000, Text, []),
    length(Text, L),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [L]),
    halt.

% Text-Tail is the difference list being built; each step conses one 'x' onto it.
build(0, Text, Text) :-
    !.
build(N, [x | Text], Tail) :-
    N1 is N - 1,
    build(N1, Text, Tail).
