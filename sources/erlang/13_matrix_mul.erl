#!/usr/bin/env escript
%%! -smp enable

% task 13 matrix_mul — expected output: 599995000
%% build: none (escript compiles the script on every run)
% run: escript 13_matrix_mul.erl
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
%% The plain i, j, k triple loop in that order on flat row-major arrays, so the k loop walks a
%% column of B. Reordering would be faster, which is the point.
main(_) ->
    N = 500,
    E = N * N,
    A = atomics:new(E, [{signed, true}]),
    B = atomics:new(E, [{signed, true}]),
    C = atomics:new(E, [{signed, true}]),
    fill(A, B, 0, N),
    mul(A, B, C, 0, N),
    io:format("~w~n", [sum(C, 0, E)]).

fill(_A, _B, I, N) when I >= N -> ok;
fill(A, B, I, N) ->
    inner(A, B, I, 0, N),
    fill(A, B, I + 1, N).

inner(_A, _B, _I, J, N) when J >= N -> ok;
inner(A, B, I, J, N) ->
    Idx = I * N + J,
    atomics:put(A, Idx + 1, (I + J) rem 7),
    atomics:put(B, Idx + 1, (I * J) rem 5),
    inner(A, B, I, J + 1, N).

mul(_A, _B, _C, R, N) when R >= N -> ok;
mul(A, B, C, R, N) ->
    row(A, B, C, R, 0, N),
    mul(A, B, C, R + 1, N).

row(_A, _B, _C, _R, Col, N) when Col >= N -> ok;
row(A, B, C, R, Col, N) ->
    atomics:put(C, R * N + Col + 1, dot(A, B, R, Col, 0, N, 0)),
    row(A, B, C, R, Col + 1, N).

dot(_A, _B, _R, _Col, K, N, Acc) when K >= N -> Acc;
dot(A, B, R, Col, K, N, Acc) ->
    dot(A, B, R, Col, K + 1, N,
        Acc + atomics:get(A, R * N + K + 1) * atomics:get(B, K * N + Col + 1)).

sum(_C, K, E) when K >= E -> 0;
sum(C, K, E) -> atomics:get(C, K + 1) + sum(C, K + 1, E).
