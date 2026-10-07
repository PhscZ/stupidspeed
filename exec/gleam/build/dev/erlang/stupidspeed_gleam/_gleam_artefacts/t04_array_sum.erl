-module(t04_array_sum).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).
-export_type([atomics/0]).

-type atomics() :: any().

-file("src\\t04_array_sum.gleam", 57).
-spec sum(atomics(), integer(), integer()) -> integer().
sum(Arr, I, N) ->
    case I >= N of
        true ->
            0;

        false ->
            atomics:get(Arr, I + 1) + sum(Arr, I + 1, N)
    end.

-file("src\\t04_array_sum.gleam", 47).
-spec fill(atomics(), integer(), integer()) -> nil.
fill(Arr, I, N) ->
    case I >= N of
        true ->
            nil;

        false ->
            _ = atomics:put(Arr, I + 1, I),
            fill(Arr, I + 1, N)
    end.

-file("src\\t04_array_sum.gleam", 36).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    N = 1000000,
    Arr = atomics:new(N, [{erlang:binary_to_atom(~"signed"), true}]),
    fill(Arr, 0, N),
    Answer = sum(Arr, 0, N),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Answer)).

