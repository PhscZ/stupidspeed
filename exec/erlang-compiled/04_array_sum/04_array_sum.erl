% task 04 array_sum — expected output: 499999500000
% build: C:\stupidspeed\tools\erlang\bin\erlc.exe 04_array_sum.erl   (run from a scratch directory: erlc writes 04_array_sum.beam)
% run: C:\stupidspeed\tools\erlang\bin\erl.exe -noshell -s 04_array_sum main -s init stop
%% note: the build writes <task>.beam into the CURRENT directory, so run erlc from a
%%       scratch directory holding a copy of this file (or pass -o <dir>); running it
%%       here would leave build output inside sources/. The measured run is the .beam.
% timing: erlang:monotonic_time(microsecond); TIME_MS is written to stderr with
%         io:format(standard_error, ...) immediately before the stdout answer.
%% note: module form of sources/erlang/04_array_sum.erl. That row is escript, which recompiles
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
%% atomics is a real fixed-size mutable array of 64-bit integers with O(1) get/put -- the
%% closest thing Erlang has to an array, and genuinely imperative. Filled in one pass and
%% summed in another, so the fill is not part of the read loop. One million elements, left at a
%% million on purpose.
-module('04_array_sum').
-export([main/0]).

main() ->
    T0 = erlang:monotonic_time(microsecond),
    N = 1000000,
    Arr = atomics:new(N, [{signed, true}]),
    fill(Arr, 0, N),
    Total = sum(Arr, 0, N),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [Total]).

fill(_Arr, I, N) when I >= N -> ok;
fill(Arr, I, N) ->
    atomics:put(Arr, I + 1, I),
    fill(Arr, I + 1, N).

sum(_Arr, I, N) when I >= N -> 0;
sum(Arr, I, N) ->
    atomics:get(Arr, I + 1) + sum(Arr, I + 1, N).
