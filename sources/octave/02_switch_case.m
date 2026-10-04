# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)    run: octave-cli -qf 02_switch_case.m
#
# switch on the value of mod(i, 4), which is Octave's real multi-way branch and
# only evaluates the selected alternative, so this is a switch and not the
# if-chain task 01 uses.
# note: no % operator in Octave, so mod() is the builtin call in the switch
# expression, as in task 01.
# note: acc is a double; it ends at 7.5e15, below 2^53 = 9.007e15, and every
# term is an integer, so the sum is exact and %.0f prints all sixteen digits.

__t0 = tic;
acc = 0;
for i = 0:99999999
  switch mod(i, 4)
    case 0
      acc = acc + 1;
    case 1
      acc = acc + i;
    case 2
      acc = acc + 2 * i;
    case 3
      acc = acc + 3 * i;
  end
end
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", acc);
