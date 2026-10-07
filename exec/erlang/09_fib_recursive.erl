#!/usr/bin/env escript
%%! -smp enable

% task 09 fib_recursive — expected output: 102334155
%% build: none (escript compiles the script on every run)
% run: escript 09_fib_recursive.erl
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
%% Naive fib(40): about 331 million calls, so this measures the call path itself.
main(_) ->
    T0 = erlang:monotonic_time(microsecond),
    R = fib(40),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [R]).

fib(N) when N < 2 -> N;
fib(N) -> fib(N - 1) + fib(N - 2).
