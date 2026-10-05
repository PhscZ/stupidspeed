#!/usr/bin/env escript
%%! -smp enable

% task 10 pi — expected output: 4470
%% build: none (escript compiles the script on every run)
% run: escript 10_pi.erl
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
%% note: Erlang has arbitrary-precision integers built in, so this row does NOT hand-roll
%%       base-1e9 limbs. They promote automatically and `div`/`rem` are exact at any size, which
%%       is the fast route the Python, Ruby, Java, Clojure and Common Lisp rows take.

%% Gibbons' unbounded spigot over Erlang's built-in exact integers.
main(_) ->
    T0 = erlang:monotonic_time(microsecond),
    loop(1, 0, 1, 1, 3, 3, 0, 0, T0).

loop(_Q, _R, _T, _K, _L, _N, Produced, Sum, T0) when Produced >= 1000 ->
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [Sum]);
loop(Q, R, T, K, L, N, Produced, Sum, T0) ->
    U = 4 * Q + R,
    V = (N + 1) * T,
    case U < V of
        true ->
            %% n is settled: emit it and advance
            Next = (10 * (3 * Q + R)) div T - 10 * N,
            R2 = 10 * (R - N * T),
            loop(10 * Q, R2, T, K, L, Next, Produced + 1, Sum + N, T0);
        false ->
            %% not settled: widen the state by one more term
            Next = (Q * (7 * K + 2) + R * L) div (T * L),
            R2 = (2 * Q + R) * L,
            loop(Q * K, R2, T * L, K + 1, L + 2, Next, Produced, Sum, T0)
    end.
