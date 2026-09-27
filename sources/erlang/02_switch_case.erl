#!/usr/bin/env escript
%%! -smp enable

% task 02 switch_case — expected output: 7500000075000000
%% build: none (escript compiles the script on every run)
% run: escript 02_switch_case.erl
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
%% 7500000075000000 is past 2^31 but far inside Erlang's arbitrary-precision integers, which
%% promote automatically, so no type declaration is needed.
main(_) ->
    loop(0, 0).

loop(I, Acc) when I >= 100000000 ->
    io:format("~w~n", [Acc]);
loop(I, Acc) ->
    V = case I rem 4 of
            0 -> 1;
            1 -> I;
            2 -> 2 * I;
            _ -> 3 * I
        end,
    loop(I + 1, Acc + V).
