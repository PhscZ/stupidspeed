-module(t12_matrix_add).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).
-export_type([atomics/0]).

-type atomics() :: any().

-file("src\\t12_matrix_add.gleam", 85).
-spec sum(atomics(), integer(), integer()) -> integer().
sum(C, K, E) ->
    case K >= E of
        true ->
            0;

        false ->
            atomics:get(C, K + 1) + sum(C, K + 1, E)
    end.

-file("src\\t12_matrix_add.gleam", 75).
-spec add(atomics(), atomics(), atomics(), integer(), integer()) -> nil.
add(A, B, C, K, E) ->
    case K >= E of
        true ->
            nil;

        false ->
            _ = atomics:put(C, K + 1, atomics:get(A, K + 1) + atomics:get(B, K + 1)),
            add(A, B, C, K + 1, E)
    end.

-file("src\\t12_matrix_add.gleam", 63).
-spec inner(atomics(), atomics(), integer(), integer(), integer()) -> nil.
inner(A, B, I, J, N) ->
    case J >= N of
        true ->
            nil;

        false ->
            Index = (I * N) + J,
            _ = atomics:put(A, Index + 1, I + J),
            _ = atomics:put(B, Index + 1, I - J),
            inner(A, B, I, J + 1, N)
    end.

-file("src\\t12_matrix_add.gleam", 53).
-spec fill(atomics(), atomics(), integer(), integer()) -> nil.
fill(A, B, I, N) ->
    case I >= N of
        true ->
            nil;

        false ->
            inner(A, B, I, 0, N),
            fill(A, B, I + 1, N)
    end.

-file("src\\t12_matrix_add.gleam", 49).
-spec opts() -> list({gleam@erlang@atom:atom_(), boolean()}).
opts() ->
    [{erlang:binary_to_atom(~"signed"), true}].

-file("src\\t12_matrix_add.gleam", 34).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    N = 1000,
    E = N * N,
    A = atomics:new(E, opts()),
    B = atomics:new(E, opts()),
    C = atomics:new(E, opts()),
    fill(A, B, 0, N),
    add(A, B, C, 0, E),
    Answer = sum(C, 0, E),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Answer)).

