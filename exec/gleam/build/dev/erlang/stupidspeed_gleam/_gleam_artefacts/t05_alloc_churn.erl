-module(t05_alloc_churn).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t05_alloc_churn.gleam", 35).
-spec churn(integer(), integer(), integer()) -> nil.
churn(I, Total, T0) ->
    case I of
        10000000 ->
            Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
            gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
            gleam_stdlib:println(erlang:integer_to_binary(Total));

        _ ->
            V = I rem 256,
            Buf = binary:copy(<<V:8>>, 64),
            _ = erlang:put(V, Buf),
            churn(I + 1, Total + V, T0)
    end.

-file("src\\t05_alloc_churn.gleam", 30).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    churn(0, 0, T0).

