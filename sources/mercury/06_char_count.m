% task 06 char_count — expected output: 10000000
% build: mmc --make m06_char_count -o prog    run: ./prog

:- module m06_char_count.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module char, int, list, string.

main(!IO) :-
    Block = "abcdefghij",
    Blocks = list.duplicate(10000000, Block),
    Text = string.append_list(Blocks),
    string.foldl(count_char, Text, 0, Count),
    io.format("%d\n", [i(Count)], !IO).

:- pred count_char(char::in, int::in, int::out) is det.
count_char(C, A0, A) :-
    ( if C = 'h' then
        A = A0 + 1
    else
        A = A0
    ).
