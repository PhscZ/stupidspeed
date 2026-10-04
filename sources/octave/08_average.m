# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: octave-cli -qf 08_average.m
#
# Every reading is a multiple of 1/256 and the running total stays far below
# 2^53, so the sum is exact. %.9f prints it as an exact decimal: no exponent, no
# trailing zeros, no locale separator.

__t0 = tic;
total = 0;
for i = 0:99999999
  reading = mod(i, 256) / 256;
  total = total + reading;
end
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.9f\n", total / 100000000);
