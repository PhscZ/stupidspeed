-module(t09_fib_recursive).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).

-file("src\\t09_fib_recursive.gleam", 28).
-spec fib(integer()) -> integer().
fib(N) ->
    case N < 2 of
        true ->
            N;

        false ->
            fib(N - 1) + fib(N - 2)
    end.

-file("src\\t09_fib_recursive.gleam", 20).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Answer = fib(40),
    Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
    gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
    gleam_stdlib:println(erlang:integer_to_binary(Answer)).

