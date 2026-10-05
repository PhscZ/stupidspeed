-module(t02_switch_case).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t02_switch_case.gleam", 33).
-spec loop(integer(), integer()) -> integer().
loop(I, Acc) ->
    case I of
        100000000 ->
            Acc;

        _ ->
            case I rem 4 of
                0 ->
                    loop(I + 1, Acc + 1);

                1 ->
                    loop(I + 1, Acc + I);

                2 ->
                    loop(I + 1, Acc + (2 * I));

                _ ->
                    loop(I + 1, Acc + (3 * I))
            end
    end.

-file("src\\t02_switch_case.gleam", 25).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Answer = loop(0, 0),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Answer)).

