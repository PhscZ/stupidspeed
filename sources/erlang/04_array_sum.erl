#!/usr/bin/env escript
%%! -smp enable

% task 04 array_sum — expected output: 499999500000
%% build: none (escript compiles the script on every run)
% run: escript 04_array_sum.erl
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
%% atomics is a real fixed-size mutable array of 64-bit integers with O(1) get/put -- the
%% closest thing Erlang has to an array, and genuinely imperative. Filled in one pass and
%% summed in another, so the fill is not part of the read loop.
main(_) ->
    T0 = erlang:monotonic_time(microsecond),
    N = 1000000,
    Arr = atomics:new(N, [{signed, true}]),
    fill(Arr, 0, N),
    Total = sum(Arr, 0, N),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [Total]).

fill(_Arr, I, N) when I >= N -> ok;
fill(Arr, I, N) ->
    atomics:put(Arr, I + 1, I),
    fill(Arr, I + 1, N).

sum(_Arr, I, N) when I >= N -> 0;
sum(Arr, I, N) ->
    atomics:get(Arr, I + 1) + sum(Arr, I + 1, N).
