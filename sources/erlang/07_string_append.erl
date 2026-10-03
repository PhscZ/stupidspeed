#!/usr/bin/env escript
%%! -smp enable

% task 07 string_append — expected output: 250000
%% build: none (escript compiles the script on every run)
% run: escript 07_string_append.erl
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
%% Plain binary append 250000 times. NOTE: BEAM's writable-binary optimisation turns the
%% natural <<Acc/binary, "x">> into an amortised O(1) in-place extend, so this runs LINEAR here
%% rather than the quadratic copy task 07 is designed to measure. That is the runtime's real
%% behaviour for this operation and is recorded rather than worked around; forcing a copy would
%% mean writing the row artificially.
main(_) ->
    Acc = append(250000, <<>>),
    io:format("~w~n", [byte_size(Acc)]).

append(0, Acc) -> Acc;
append(N, Acc) -> append(N - 1, <<Acc/binary, "x">>).
