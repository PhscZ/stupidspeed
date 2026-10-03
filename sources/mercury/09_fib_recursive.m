% task 09 fib_recursive — expected output: 102334155
% build: mmc --make m09_fib_recursive -o prog    run: ./prog

:- module m09_fib_recursive.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string.

main(!IO) :-
    io.format("%d\n", [i(fib(40))], !IO).

:- func fib(int) = int.
fib(N) = ( if N < 2 then N else fib(N - 1) + fib(N - 2) ).
