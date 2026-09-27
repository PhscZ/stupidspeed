#!/usr/bin/env escript
%%! -smp enable

% task 14 file_read — expected output: 3442475008
%% build: none (escript compiles the script on every run)
% run: escript 14_file_read.erl
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
%% note: data.bin is read from the working directory in 1 MiB chunks and every byte is added
%%       up; the running total is reduced mod 2^32 after each chunk so it stays inside the 2^53
%%       range where a float is exact. Binaries are byte arrays, so each element is already 0..255.

main(_) ->
    {ok, F} = file:open("data.bin", [read, raw, binary]),
    Total = chunks(F, 0),
    file:close(F),
    io:format("~w~n", [Total rem 4294967296]).

chunks(F, Acc) ->
    case file:read(F, 1048576) of
        {ok, Bin} -> chunks(F, (Acc + sum(Bin, 0)) rem 4294967296);
        eof -> Acc
    end.

sum(<<>>, Acc) -> Acc;
sum(<<B, Rest/binary>>, Acc) -> sum(Rest, Acc + B).
