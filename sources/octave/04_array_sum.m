# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: octave-cli -qf 04_array_sum.m
#
# A double row vector of a million elements. Octave indexes from 1, so the
# 0-based i of the other rows is the index i + 1 here.

n = 1000000;
array = zeros(1, n);
for i = 0:n-1
  array(i + 1) = i;
end
total = 0;
for i = 0:n-1
  total = total + array(i + 1);
end
printf("%.0f\n", total);
