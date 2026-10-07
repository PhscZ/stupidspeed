% task 03 func_sum helper — add_one/2 in its own module, loaded by 03_func_sum.pl
% build: none (interpreted)
% note: this file is the second-file helper for task 03. The main file loads it with
%       use_module/1 so the call is a genuine cross-module call and cannot be inlined.

:- module(func_sum_add_one, [add_one/2]).

add_one(N, N1) :-
    N1 is N + 1.
