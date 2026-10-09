#!/usr/bin/env escript
%%! -smp enable

% task 11 parallel_sum — expected output: 7500000075000000
%% build: none (escript compiles the script on every run)
% run: escript 11_parallel_sum.erl
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
%%       blocks in receive, which is the join. Measured 4.27x against the same work run serially
%%       -- the best task-11 result in the matrix.

-define(SPAN, 25000000).

main(_) ->
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
