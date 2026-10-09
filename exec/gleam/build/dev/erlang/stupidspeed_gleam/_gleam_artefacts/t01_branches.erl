-module(t01_branches).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t01_branches.gleam", 39).
-spec loop(integer(), integer(), integer(), integer(), integer()) -> {integer(), integer(), integer(), integer()}.
loop(I, A, B, C, D) ->
    case I of
        100000000 ->
            {A, B, C, D};

        _ ->
            case I rem 3 of
                0 ->
                    loop(I + 1, A + 1, B, C, D);

                _ ->
                    case I rem 5 of
                        0 ->
                            loop(I + 1, A, B + 1, C, D);

                        _ ->
                            case I rem 7 of
                                0 ->
                                    loop(I + 1, A, B, C + 1, D);

                                _ ->
                                    loop(I + 1, A, B, C, D + 1)
                            end
                    end
            end
    end.

-file("src\\t01_branches.gleam", 23).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    {A, B, C, D} = loop(0, 0, 0, 0, 0),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(<<<<<<<<<<<<(erlang:integer_to_binary(A))/binary, " "/utf8>>/binary, (erlang:integer_to_binary(B))/binary>>/binary, " "/utf8>>/binary, (erlang:integer_to_binary(C))/binary>>/binary, " "/utf8>>/binary, (erlang:integer_to_binary(D))/binary>>).

