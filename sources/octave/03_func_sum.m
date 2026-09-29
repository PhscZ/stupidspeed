# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: octave-cli -qf 03_func_sum.m
#
# The helper is a separate file, add_one.m, beside this one; it is loaded from
# the working directory.
# note: the helper cannot carry the NN_ prefix the other rows use. Octave ties a
# function's name to its file name -- a call to add_one() is resolved by looking
# for add_one.m on the load path -- so a file called 03_func_sum_add_one.m would
# define a function no call could reach. This is the same naming exception the
# Oberon-07 row has for AddOne.ob07 (BUILD.md), and it is the first of the two
# options the task spec offers: the function lives in its own file, so no
# inliner question arises.
# note: Octave has no JIT at all -- the prototype JIT compiler was removed in
# Octave 7 -- so this is a hundred million real tree-walking calls and no
# no-inline marker is needed or available.
# note: value stays below 2^53, so the double holds it exactly.

value = 0;
for i = 0:99999999
  value = add_one(value);
end
printf("%.0f\n", value);
