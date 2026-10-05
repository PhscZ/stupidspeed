-module(t14_file_read).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([main/0]).
-export_type([fd/0, res/1]).

-type fd() :: any().

-type res(DXC) :: {ok, DXC} | {error, gleam@erlang@atom:atom_()} | eof.

-file("src\\t14_file_read.gleam", 70).
-spec sum(bitstring(), integer()) -> integer().
sum(Bits, Acc) ->
    case Bits of
        <<B, Rest/bitstring>> ->
            sum(Rest, Acc + B);

        _ ->
            Acc
    end.

-file("src\\t14_file_read.gleam", 62).
-spec chunks(fd(), integer()) -> integer().
chunks(Fd, Acc) ->
    case file:read(Fd, 1048576) of
        {ok, Bin} ->
            chunks(Fd, (Acc + sum(Bin, 0)) rem 4294967296);

        eof ->
            Acc;

        {error, _} ->
            erlang:error(#{
                gleam_error => panic,
                message => ~"cannot read data.bin",
                file => ~"src\\t14_file_read.gleam",
                module => ~"t14_file_read",
                function => ~"chunks",
                line => 66
            })
    end.

-file("src\\t14_file_read.gleam", 46).
-spec main() -> nil.
main() ->
    T0 = erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")),
    Modes = [erlang:binary_to_atom(~"read"), erlang:binary_to_atom(~"raw"), erlang:binary_to_atom(~"binary")],
    case file:open(~"data.bin", Modes) of
        {ok, Fd} ->
            Total = chunks(Fd, 0),
            _ = file:close(Fd),
            Ms = erlang:float(erlang:monotonic_time(erlang:binary_to_atom(~"microsecond")) - T0) / 1000.0,
            gleam_stdlib:println_error(<<"TIME_MS="/utf8, (gleam_stdlib:float_to_string(Ms))/binary>>),
            gleam_stdlib:println(erlang:integer_to_binary(Total rem 4294967296));

        {error, _} ->
            erlang:error(#{
                gleam_error => panic,
                message => ~"cannot open data.bin",
                file => ~"src\\t14_file_read.gleam",
                module => ~"t14_file_read",
                function => ~"main",
                line => 57
            });

        eof ->
            erlang:error(#{
                gleam_error => panic,
                message => ~"file_open cannot return eof",
                file => ~"src\\t14_file_read.gleam",
                module => ~"t14_file_read",
                function => ~"main",
                line => 58
            })
    end.

