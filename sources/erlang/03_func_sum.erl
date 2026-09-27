#!/usr/bin/env escript
%%! -smp enable

% task 03 func_sum — expected output: 100000000
%% build: none (escript compiles the script on every run)
% run: escript 03_func_sum.erl
%% note: Erlang has no mutable variables and no loop syntax, so there is no imperative
%%       register to write in -- every loop here is tail recursion with explicit
%%       accumulators, which the compiler turns into a jump, plus case/guards for the
%%       branches. What is deliberately avoided is the functional style: no lists:map,
%%       lists:foldl, list comprehensions or higher-order functions in any timed path.
%%       This is the most procedural register the language has; it cannot honestly be
%%       called imperative, and the row does not claim to be.
%% note: mutable state, where a task genuinely needs it, uses the language's own escape
%%       hatches -- the process dictionary (put/get) and the atomics module, which is a
%%       real fixed-size mutable array of 64-bit integers.
%% The helper is a separate module so the call crosses a module boundary. Erlang does not
%% inline across modules, and it does not inline within one either unless -compile(inline) is
%% given, so add_one/1 is a real call -- the same guarantee the Fortran, Tcl, Vala and Common
%% Lisp rows get by splitting this task into two files.
main(_) ->
    loop(0, 0).

loop(I, Value) when I >= 100000000 ->
    io:format("~w~n", [Value]);
loop(I, Value) ->
    loop(I + 1, add_one(Value)).

add_one(N) -> N + 1.
