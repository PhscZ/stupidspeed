#!/usr/bin/env escript
%%! -smp enable

% task 08 average — expected output: 0.498046875
%% build: none (escript compiles the script on every run)
% run: escript 08_average.erl
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
%% A hundred million readings, each a multiple of 1/256, accumulated as a float. The total is
%% far below 2^53, so the sum is exact and the digits do not depend on the order of addition.
main(_) ->
    T0 = erlang:monotonic_time(microsecond),
    Total = acc(0, 100000000, 0.0),
    Avg = Total / 100000000,
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [Avg]).

acc(I, N, Total) when I >= N -> Total;
acc(I, N, Total) -> acc(I + 1, N, Total + (I rem 256) / 256).
