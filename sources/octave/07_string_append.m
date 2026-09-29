# task 07 string_append — expected output: 1000000
# build: none (interpreted)    run: octave-cli -qf 07_string_append.m
#
# The plain append the spec asks for: [text 'x'] allocates a fresh character
# array holding both operands and copies the old one into it, because Octave has
# no growable string type. A million appends therefore copy about 5x10^11 bytes,
# which is the quadratic cost this task exists to measure, and makes this one of
# the slowest cells in the row.

text = '';
for i = 1:1000000
  text = [text 'x'];
end
printf("%.0f\n", numel(text));
