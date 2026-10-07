-module(t10_pi).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t10_pi.gleam", 33).
-spec loop(integer(), integer(), integer(), integer(), integer(), integer(), integer(), integer()) -> integer().
loop(Q, R, T, K, N, L, Emitted, Sum) ->
    case Emitted >= 1000 of
        true ->
            Sum;

        false ->
            case (((4 * Q) + R) - T) < (N * T) of
                true ->
                    loop(10 * Q, 10 * (R - (N * T)), T, K, case T of
                        0 ->
                            0;

                        _value ->
                            (10 * ((3 * Q) + R)) div _value
                    end - (10 * N), L, Emitted + 1, Sum + N);

                false ->
                    loop(Q * K, ((2 * Q) + R) * L, T * L, K + 1, case T * L of
                        0 ->
                            0;

                        _value@1 ->
                            ((Q * ((7 * K) + 2)) + (R * L)) div _value@1
                    end, L + 2, Emitted, Sum)
            end
    end.

-file("src\\t10_pi.gleam", 25).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Answer = loop(1, 0, 1, 1, 3, 3, 0, 0),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Answer)).

