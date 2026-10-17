#!/usr/bin/env escript
%%! -smp enable

% task 15 file_write — expected output: 419430400
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
%% note: the 1 MiB buffer is written 50 times per pass, 8 passes over out.bin, each pass
%%       rewriting the file from offset 0 and committed with file:datasync/1, which is the
%%       BEAM's fsync on the descriptor; the file is closed at the end.

main(_) ->
    T0 = erlang:monotonic_time(microsecond),
    Cycle = list_to_binary(lists:seq(0, 255)),
    Buf = binary:copy(Cycle, 4096),
    {ok, F} = file:open("out.bin", [write, raw, binary]),
    passes(F, Buf, 8),
    file:close(F),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [8 * 50 * 1048576]).

write(_F, _Buf, 0) -> ok;
write(F, Buf, N) ->
    ok = file:write(F, Buf),
    write(F, Buf, N - 1).

%% one pass: rewind to offset 0, write the 1 MiB buffer 50 times, then fsync
passes(_F, _Buf, 0) -> ok;
passes(F, Buf, N) ->
    {ok, _} = file:position(F, 0),
    write(F, Buf, 50),
    ok = file:datasync(F),
    passes(F, Buf, N - 1).
