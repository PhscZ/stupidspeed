% task 03 func_sum helper — add_one/2 in its own source file, compiled with
% 03_func_sum.pl into the one executable by gplc (see 03_func_sum.pl). --no-inline keeps
% the call from being inlined, so the hundred million calls really happen.

add_one(N, N1) :-
    N1 is N + 1.
