#!/usr/bin/env escript
%%! -smp enable

% task 15 file_write — expected output: 52428800
%% build: none (escript compiles the script on every run)
% run: escript 15_file_write.erl
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
%% note: the 1 MiB buffer is written 50 times, then committed with file:datasync/1, which is the
%%       BEAM's fsync on the descriptor, and closed.

main(_) ->
    Cycle = list_to_binary(lists:seq(0, 255)),
    Buf = binary:copy(Cycle, 4096),
    {ok, F} = file:open("out.bin", [write, raw, binary]),
    write(F, Buf, 50),
    ok = file:datasync(F),
    file:close(F),
    io:format("~w~n", [50 * 1048576]).

write(_F, _Buf, 0) -> ok;
write(F, Buf, N) ->
    ok = file:write(F, Buf),
    write(F, Buf, N - 1).
