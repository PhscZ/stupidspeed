% task 09 fib_recursive — expected output: 102334155
% build: C:\stupidspeed\tools\erlang\bin\erlc.exe 09_fib_recursive.erl   (run from a scratch directory: erlc writes 09_fib_recursive.beam)
% run: C:\stupidspeed\tools\erlang\bin\erl.exe -noshell -s 09_fib_recursive main -s init stop
%% note: the build writes <task>.beam into the CURRENT directory, so run erlc from a
%%       scratch directory holding a copy of this file (or pass -o <dir>); running it
%%       here would leave build output inside sources/. The measured run is the .beam.
% timing: erlang:monotonic_time(microsecond); TIME_MS is written to stderr with
%         io:format(standard_error, ...) immediately before the stdout answer.
%% note: module form of sources/erlang/09_fib_recursive.erl. That row is escript, which recompiles
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
%% Naive fib(40): about 331 million calls, so this measures the call path itself.
-module('09_fib_recursive').
-export([main/0]).

main() ->
    T0 = erlang:monotonic_time(microsecond),
    R = fib(40),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [R]).

fib(N) when N < 2 -> N;
fib(N) -> fib(N - 1) + fib(N - 2).
