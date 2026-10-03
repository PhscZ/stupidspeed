% task 03 func_sum — expected output: 100000000
% build: mmc --make m03_func_sum -o prog    run: ./prog

:- module m03_func_sum.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string.

main(!IO) :-
    loop(0, 100000000, 0, Value),
    io.format("%d\n", [i(Value)], !IO).

:- pred loop(int::in, int::in, int::in, int::out) is det.
loop(I, N, !Value) :-
    ( if I >= N then
        true
    else
        !:Value = add_one(!.Value),
        loop(I + 1, N, !Value)
    ).

:- func add_one(int) = int.
:- pragma no_inline(func(add_one/1)).
add_one(N) = N + 1.
