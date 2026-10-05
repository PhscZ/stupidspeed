-module(t11_parallel_sum).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t11_parallel_sum.gleam", 50).
-spec loop(integer(), integer(), integer()) -> integer().
loop(I, End, Acc) ->
    case I >= End of
        true ->
            Acc;

        false ->
            case I rem 4 of
                0 ->
                    loop(I + 1, End, Acc + 1);

                1 ->
                    loop(I + 1, End, Acc + I);

                2 ->
                    loop(I + 1, End, Acc + (2 * I));

                _ ->
                    loop(I + 1, End, Acc + (3 * I))
            end
    end.

-file("src\\t11_parallel_sum.gleam", 46).
-spec work(integer()) -> integer().
work(T) ->
    loop(T * 25000000, (T + 1) * 25000000, 0).

-file("src\\t11_parallel_sum.gleam", 29).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Subject = gleam@erlang@process:new_subject(),
    _ = proc_lib:spawn_link(fun() ->
        gleam@erlang@process:send(Subject, work(0))
    end),
    _ = proc_lib:spawn_link(fun() ->
        gleam@erlang@process:send(Subject, work(1))
    end),
    _ = proc_lib:spawn_link(fun() ->
        gleam@erlang@process:send(Subject, work(2))
    end),
    _ = proc_lib:spawn_link(fun() ->
        gleam@erlang@process:send(Subject, work(3))
    end),
    First = gleam_erlang_ffi:'receive'(Subject),
    Second = gleam_erlang_ffi:'receive'(Subject),
    Third = gleam_erlang_ffi:'receive'(Subject),
    Fourth = gleam_erlang_ffi:'receive'(Subject),
    Total = ((First + Second) + Third) + Fourth,
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Total)).

