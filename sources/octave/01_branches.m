# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: octave-cli -qf 01_branches.m
#
# for over a range expression, not while: Octave iterates a range without
# materialising it (a loop over 0:999999999999 breaks on its fifth iteration
# immediately, so no 8 TB vector is built), and for is Octave's idiomatic loop
# form. Measured on this host, the for form is 2.7x faster than while for a bare
# counter and slightly faster for this body, so there is no cost to the choice.
# note: Octave has no % operator -- % starts a comment -- so the divisibility
# test is the mod() builtin, one real function call per iteration. That is
# Octave's own idiom, the same disclosure the Raku row makes for given/when.
# note: every scalar here is a double, every counter stays below 2^53, and
# printf("%.0f") prints them as integers rather than the 3.3333e+07 that disp()
# would produce.

__t0 = tic;
a = 0;
b = 0;
c = 0;
d = 0;
for i = 0:99999999
  if mod(i, 3) == 0
    a = a + 1;
  elseif mod(i, 5) == 0
    b = b + 1;
  elseif mod(i, 7) == 0
    c = c + 1;
  else
    d = d + 1;
  end
end
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f %.0f %.0f %.0f\n", a, b, c, d);
