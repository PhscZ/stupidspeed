-module(t03_add_one).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([add_one/1]).

-file("src\\t03_add_one.gleam", 9).
-spec add_one(integer()) -> integer().
add_one(N) ->
    N + 1.

