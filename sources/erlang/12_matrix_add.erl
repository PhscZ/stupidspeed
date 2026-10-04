#!/usr/bin/env escript
%%! -smp enable

% task 12 matrix_add — expected output: 999000000
%% build: none (escript compiles the script on every run)
% run: escript 12_matrix_add.erl
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
%% Three flat 1000x1000 atomics arrays, row-major, filled and added with plain index
%% arithmetic. The total fits comfortably in a 64-bit integer.
main(_) ->
    T0 = erlang:monotonic_time(microsecond),
    N = 1000,
    E = N * N,
    A = atomics:new(E, [{signed, true}]),
    B = atomics:new(E, [{signed, true}]),
    C = atomics:new(E, [{signed, true}]),
    fill(A, B, 0, N),
    add(A, B, C, 0, E),
    S = sum(C, 0, E),
    io:format(standard_error, "TIME_MS=~p~n", [(erlang:monotonic_time(microsecond) - T0) / 1000]),
    io:format("~w~n", [S]).

fill(_A, _B, I, N) when I >= N -> ok;
fill(A, B, I, N) ->
    inner(A, B, I, 0, N),
    fill(A, B, I + 1, N).

inner(_A, _B, _I, J, N) when J >= N -> ok;
inner(A, B, I, J, N) ->
    Idx = I * N + J,
    atomics:put(A, Idx + 1, I + J),
    atomics:put(B, Idx + 1, I - J),
    inner(A, B, I, J + 1, N).

add(_A, _B, _C, K, E) when K >= E -> ok;
add(A, B, C, K, E) ->
    atomics:put(C, K + 1, atomics:get(A, K + 1) + atomics:get(B, K + 1)),
    add(A, B, C, K + 1, E).

sum(_C, K, E) when K >= E -> 0;
sum(C, K, E) -> atomics:get(C, K + 1) + sum(C, K + 1, E).
