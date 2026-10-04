#!/usr/bin/env escript
%%! -smp enable

% task 05 alloc_churn — expected output: 1274991808
%% build: none (escript compiles the script on every run)
% run: escript 05_alloc_churn.erl
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
%% Ten million 64-byte binaries, each stored into one of 256 slots so the buffer it replaces
%% becomes garbage -- the same reachability line the C and Java rows draw. The slots are the
%% process dictionary, which is Erlang's mutable state. The total adds v, the value written.
main(_) ->
    T0 = erlang:monotonic_time(microsecond),
    churn(0, 0, T0).

churn(I, Total, T0) when I >= 10000000 ->
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [Total]);
churn(I, Total, T0) ->
    V = I rem 256,
    Buf = binary:copy(<<V:8>>, 64),
    put({slot, V}, Buf),
    churn(I + 1, Total + V, T0).
