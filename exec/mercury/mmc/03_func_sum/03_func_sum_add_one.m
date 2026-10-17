% task 03 func_sum — expected output: 400000000
% build: compiled with 03_func_sum.m: mercury_compile --make m03_func_sum --grade hlc.gc.pregen
% note: this is the second module, and the split is load-bearing. `:- pragma no_inline` only
%       stops Mercury's own inliner; it emits no C attribute, so a helper defined in the same
%       module stays a `static` function whose body gcc -O2 can see. The recurrence is affine
%       with a loop-invariant trip count, so gcc then computes start + (N - I) in closed form
%       and deletes both the loop and the call. Keeping add_one in its own module puts its
%       body in a separate translation unit, which is the same barrier the Fortran, Tcl and
%       Vala task-03 rows use.
:- module m03_func_sum_add_one.
:- interface.

:- func add_one(int) = int.

:- implementation.

:- import_module int.

:- pragma no_inline(func(add_one/1)).
add_one(N) = N + 1.
