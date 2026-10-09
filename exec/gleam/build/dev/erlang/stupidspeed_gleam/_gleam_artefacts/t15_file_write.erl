-module(t15_file_write).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).
-export_type([fd/0]).

-type fd() :: any().

-file("src\\t15_file_write.gleam", 77).
-spec check(gleam@erlang@atom:atom_()) -> nil.
check(Result) ->
    case Result =:= erlang:binary_to_atom(~"ok") of
        true ->
            nil;

        false ->
            erlang:error(#{
                gleam_error => panic,
                message => ~"file operation failed",
                file => ~"src\\t15_file_write.gleam",
                module => ~"t15_file_write",
                function => ~"check",
                line => 80
            })
    end.

-file("src\\t15_file_write.gleam", 67).
-spec write(fd(), bitstring(), integer()) -> nil.
write(Fd, Buf, N) ->
    case N of
        0 ->
            nil;

        _ ->
            check(file:write(Fd, Buf)),
            write(Fd, Buf, N - 1)
    end.

-file("src\\t15_file_write.gleam", 60).
-spec cycle(integer(), bitstring()) -> bitstring().
cycle(N, Acc) ->
    case N of
        256 ->
            Acc;

        _ ->
            cycle(N + 1, gleam@bit_array:append(Acc, <<N:8>>))
    end.

-file("src\\t15_file_write.gleam", 43).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Buf = binary:copy(cycle(0, <<>>), 4096),
    Modes = [erlang:binary_to_atom(~"write"), erlang:binary_to_atom(~"raw"), erlang:binary_to_atom(~"binary")],
    case file:open(~"out.bin", Modes) of
        {ok, Fd} ->
            write(Fd, Buf, 50),
            check(file:datasync(Fd)),
            check(file:close(Fd)),
            Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
            gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
            gleam_stdlib:println(erlang:integer_to_binary(50 * 1048576));

        {error, _} ->
            erlang:error(#{
                gleam_error => panic,
                message => ~"cannot open out.bin",
                file => ~"src\\t15_file_write.gleam",
                module => ~"t15_file_write",
                function => ~"main",
                line => 56
            })
    end.

