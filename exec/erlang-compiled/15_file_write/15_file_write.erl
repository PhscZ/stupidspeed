% task 15 file_write — expected output: 52428800
% build: C:\stupidspeed\tools\erlang\bin\erlc.exe 15_file_write.erl   (run from a scratch directory: erlc writes 15_file_write.beam)
% run: C:\stupidspeed\tools\erlang\bin\erl.exe -noshell -s 15_file_write main -s init stop
%% note: the build writes <task>.beam into the CURRENT directory, so run erlc from a
%%       scratch directory holding a copy of this file (or pass -o <dir>); running it
%%       here would leave build output inside sources/. The measured run is the .beam.
%         (run from a directory containing data.bin; out.bin is written there)
% timing: erlang:monotonic_time(microsecond); TIME_MS is written to stderr with
%         io:format(standard_error, ...) immediately before the stdout answer.
%% note: module form of sources/erlang/15_file_write.erl. That row is escript, which recompiles
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
%% note: the 1 MiB buffer is written 50 times, then committed with file:datasync/1, which is the
%%       BEAM's fsync on the descriptor, and closed.
-module('15_file_write').
-export([main/0]).

main() ->
    T0 = erlang:monotonic_time(microsecond),
    Cycle = list_to_binary(lists:seq(0, 255)),
    Buf = binary:copy(Cycle, 4096),
    {ok, F} = file:open("out.bin", [write, raw, binary]),
    write(F, Buf, 50),
    ok = file:datasync(F),
    file:close(F),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [50 * 1048576]).

write(_F, _Buf, 0) -> ok;
write(F, Buf, N) ->
    ok = file:write(F, Buf),
    write(F, Buf, N - 1).
