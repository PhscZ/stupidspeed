-module(t06_char_count).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t06_char_count.gleam", 35).
-spec scan(bitstring(), integer()) -> integer().
scan(Text, Count) ->
    case Text of
        <<B, Rest/bitstring>> ->
            case B of
                97 ->
                    scan(Rest, Count);

                101 ->
                    scan(Rest, Count);

                104 ->
                    scan(Rest, Count + 1);

                _ ->
                    scan(Rest, Count)
            end;

        _ ->
            Count
    end.

-file("src\\t06_char_count.gleam", 26).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Text = gleam_stdlib:identity(gleam@string:repeat(~"abcdefghij", 10000000)),
    Count = scan(Text, 0),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Count)).

