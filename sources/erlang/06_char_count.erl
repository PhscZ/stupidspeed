#!/usr/bin/env escript
%%! -smp enable

% task 06 char_count — expected output: 10000000
%% build: none (escript compiles the script on every run)
% run: escript 06_char_count.erl
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
%% The 100 MB text is built once with binary:copy, which allocates it in a single pass rather
%% than a hundred million appends, and then scanned one byte at a time with binary:at, which is
%% O(1).
main(_) ->
    Text = binary:copy(<<"abcdefghij">>, 10000000),
    io:format("~w~n", [scan(Text, 0, 100000000, 0)]).

scan(_Text, I, N, Count) when I >= N -> Count;
scan(Text, I, N, Count) ->
    case binary:at(Text, I) of
        $h -> scan(Text, I + 1, N, Count + 1);
        _  -> scan(Text, I + 1, N, Count)
    end.
