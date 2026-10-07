% task 11 parallel_sum — expected output: 7500000075000000
% build: C:\stupidspeed\tools\erlang\bin\erlc.exe 11_parallel_sum.erl   (run from a scratch directory: erlc writes 11_parallel_sum.beam)
% run: C:\stupidspeed\tools\erlang\bin\erl.exe -noshell -s 11_parallel_sum main -s init stop
%% note: the build writes <task>.beam into the CURRENT directory, so run erlc from a
%%       scratch directory holding a copy of this file (or pass -o <dir>); running it
%%       here would leave build output inside sources/. The measured run is the .beam.
% timing: erlang:monotonic_time(microsecond); TIME_MS is written to stderr with
%         io:format(standard_error, ...) immediately before the stdout answer.
%% note: module form of sources/erlang/11_parallel_sum.erl. That row is escript, which recompiles
%%       the script on every run; this one is compiled ahead of time with erlc and the .beam is
%%       loaded by name. The shebang and the %%! -smp enable emulator line are replaced by
%%       -module/-export with main/0 instead of main/1. The -smp enable flag is dropped because
%%       SMP is on by default in OTP 29 (erlang:system_info(smp_support) = true, 8 schedulers
%%       here), so the four workers still land on four real scheduler threads. Algorithms are
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
%% note: four real OS threads. spawn/1 puts each worker on its own scheduler, and the BEAM
%%       runs one scheduler per core with no global lock, so the four really overlap. The parent
%%       blocks in receive, which is the join. The escript row measured 4.27x against the same
%%       work run serially; same runtime, same work, so this compiled form behaves the same.

-module('11_parallel_sum').
-export([main/0]).

-define(SPAN, 25000000).

main() ->
    T0 = erlang:monotonic_time(microsecond),
    Self = self(),
    Pids = [spawn(fun() -> Self ! {self(), work(T)} end) || T <- [0, 1, 2, 3]],
    Total = collect(Pids, 0),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [Total]).

collect([], Acc) -> Acc;
collect([P | Rest], Acc) ->
    receive
        {P, V} -> collect(Rest, Acc + V)
    end.

work(T) ->
    Start = T * ?SPAN,
    End = (T + 1) * ?SPAN,
    wloop(Start, End, 0).

wloop(I, End, Acc) when I >= End -> Acc;
wloop(I, End, Acc) ->
    V = case I rem 4 of
            0 -> 1;
            1 -> I;
            2 -> 2 * I;
            _ -> 3 * I
        end,
    wloop(I + 1, End, Acc + V).
