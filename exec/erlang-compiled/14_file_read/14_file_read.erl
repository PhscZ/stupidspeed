% task 14 file_read — expected output: 2389704704
% build: C:\stupidspeed\tools\erlang\bin\erlc.exe 14_file_read.erl   (run from a scratch directory: erlc writes 14_file_read.beam)
% run: C:\stupidspeed\tools\erlang\bin\erl.exe -noshell -s 14_file_read main -s init stop
%% note: the build writes <task>.beam into the CURRENT directory, so run erlc from a
%%       scratch directory holding a copy of this file (or pass -o <dir>); running it
%%       here would leave build output inside sources/. The measured run is the .beam.
%         (must be run from a directory containing data.bin)
% timing: erlang:monotonic_time(microsecond); TIME_MS is written to stderr with
%         io:format(standard_error, ...) immediately before the stdout answer.
%% note: module form of sources/erlang/14_file_read.erl. That row is escript, which recompiles
%%       the script on every run; this one is compiled ahead of time with erlc and the .beam is
%%       loaded by name. The shebang and the %%! -smp enable emulator line are replaced by
%%       -module/-export with main/0 instead of main/1, and -smp enable is dropped because SMP
%%       is on by default in OTP 29 (erlang:system_info(smp_support) = true). Algorithms are
%%       unchanged from the escript row.
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
-module('14_file_read').
-export([main/0]).

main() ->
    T0 = erlang:monotonic_time(microsecond),
    {ok, F} = file:open("data.bin", [read, raw, binary]),
    Total = chunks(F, 0),
    file:close(F),
    R = Total rem 4294967296,
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [R]).

chunks(F, Acc) ->
    case file:read(F, 1048576) of
        {ok, Bin} -> chunks(F, (Acc + sum(Bin, 0)) rem 4294967296);
        eof -> Acc
    end.

sum(<<>>, Acc) -> Acc;
sum(<<B, Rest/binary>>, Acc) -> sum(Rest, Acc + B).
