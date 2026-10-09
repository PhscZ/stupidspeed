-module(t08_average).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t08_average.gleam", 30).
-spec acc(integer(), integer(), float()) -> float().
acc(I, N, Total) ->
    case I >= N of
        true ->
            Total;

        false ->
            acc(I + 1, N, Total + (erlang:float(I rem 256) / 256.0))
    end.

-file("src\\t08_average.gleam", 22).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Total = acc(0, 100000000, +0.0),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(gleam_stdlib:float_to_string(Total / 100000000.0)).

