-module(t07_string_append).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t07_string_append.gleam", 34).
-spec append(integer(), binary()) -> binary().
append(N, Acc) ->
    case N of
        0 ->
            Acc;

        _ ->
            append(N - 1, <<Acc/binary, "x"/utf8>>)
    end.

-file("src\\t07_string_append.gleam", 25).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Text = append(250000, ~""),
    Answer = string:length(Text),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Answer)).

