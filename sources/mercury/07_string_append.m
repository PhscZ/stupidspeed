% task 07 string_append — expected output: 250000
% build: mmc --make m07_string_append -o prog    run: ./prog
% note: Mercury strings are immutable, so each ++ copies the whole string, which
% is the same quadratic work the C row does with realloc plus strcat.

:- module m07_string_append.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string.

main(!IO) :-
    append_x(250000, "", Text),
    io.format("%d\n", [i(string.length(Text))], !IO).

:- pred append_x(int::in, string::in, string::out) is det.
append_x(N, Text0, Text) :-
    ( if N =< 0 then
        Text = Text0
    else
        append_x(N - 1, Text0 ++ "x", Text)
    ).
