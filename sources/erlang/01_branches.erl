#!/usr/bin/env escript
%%! -smp enable

% task 01 branches — expected output: 33333334 13333333 7619048 45714285
%% build: none (escript compiles the script on every run)
% run: escript 01_branches.erl
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
main(_) ->
    loop(0, 0, 0, 0, 0).

loop(I, A, B, C, D) when I >= 100000000 ->
    io:format("~w ~w ~w ~w~n", [A, B, C, D]);
loop(I, A, B, C, D) ->
    case I rem 3 of
        0 -> loop(I + 1, A + 1, B, C, D);
        _ ->
            case I rem 5 of
                0 -> loop(I + 1, A, B + 1, C, D);
                _ ->
                    case I rem 7 of
                        0 -> loop(I + 1, A, B, C + 1, D);
                        _ -> loop(I + 1, A, B, C, D + 1)
                    end
            end
    end.
