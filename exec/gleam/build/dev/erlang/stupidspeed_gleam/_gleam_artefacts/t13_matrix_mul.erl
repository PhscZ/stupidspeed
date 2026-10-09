-module(t13_matrix_mul).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).
-export_type([atomics/0]).

-type atomics() :: any().

-file("src\\t13_matrix_mul.gleam", 110).
-spec sum(atomics(), integer(), integer()) -> integer().
sum(C, K, E) ->
    case K >= E of
        true ->
            0;

        false ->
            atomics:get(C, K + 1) + sum(C, K + 1, E)
    end.

-file("src\\t13_matrix_mul.gleam", 94).
-spec dot(atomics(), atomics(), integer(), integer(), integer(), integer(), integer()) -> integer().
dot(A, B, Row, Col, K, N, Acc) ->
    case K >= N of
        true ->
            Acc;

        false ->
            dot(A, B, Row, Col, K + 1, N, Acc + (atomics:get(A, ((Row * N) + K) + 1) * atomics:get(B, ((K * N) + Col) + 1)))
    end.

-file("src\\t13_matrix_mul.gleam", 84).
-spec cols(atomics(), atomics(), atomics(), integer(), integer(), integer()) -> nil.
cols(A, B, C, Row, Col, N) ->
    case Col >= N of
        true ->
            nil;

        false ->
            _ = atomics:put(C, ((Row * N) + Col) + 1, dot(A, B, Row, Col, 0, N, 0)),
            cols(A, B, C, Row, Col + 1, N)
    end.

-file("src\\t13_matrix_mul.gleam", 74).
-spec mul(atomics(), atomics(), atomics(), integer(), integer()) -> nil.
mul(A, B, C, Row, N) ->
    case Row >= N of
        true ->
            nil;

        false ->
            cols(A, B, C, Row, 0, N),
            mul(A, B, C, Row + 1, N)
    end.

-file("src\\t13_matrix_mul.gleam", 62).
-spec inner(atomics(), atomics(), integer(), integer(), integer()) -> nil.
inner(A, B, I, J, N) ->
    case J >= N of
        true ->
            nil;

        false ->
            Index = (I * N) + J,
            _ = atomics:put(A, Index + 1, (I + J) rem 7),
            _ = atomics:put(B, Index + 1, (I * J) rem 5),
            inner(A, B, I, J + 1, N)
    end.

-file("src\\t13_matrix_mul.gleam", 52).
-spec fill(atomics(), atomics(), integer(), integer()) -> nil.
fill(A, B, I, N) ->
    case I >= N of
        true ->
            nil;

        false ->
            inner(A, B, I, 0, N),
            fill(A, B, I + 1, N)
    end.

-file("src\\t13_matrix_mul.gleam", 48).
-spec opts() -> list({gleam@erlang@atom:atom_(), boolean()}).
opts() ->
    [{erlang:binary_to_atom(~"signed"), true}].

-file("src\\t13_matrix_mul.gleam", 33).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    N = 500,
    E = N * N,
    A = atomics:new(E, opts()),
    B = atomics:new(E, opts()),
    C = atomics:new(E, opts()),
    fill(A, B, 0, N),
    mul(A, B, C, 0, N),
    Answer = sum(C, 0, E),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Answer)).

