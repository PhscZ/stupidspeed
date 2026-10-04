# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)    run: octave-cli -qf 05_alloc_churn.m
#
# zeros(1, 64, 'uint8') is 64 real bytes, freshly allocated every iteration. The
# cell assignment keeps the buffer reachable and drops the one it replaces, so
# the old buffer becomes garbage exactly as in the other rows.
# note: the byte is read back through double(). A uint8 added to a double
# accumulator would make the accumulator a uint8 and Octave's integer arithmetic
# saturates, so the total would silently stop at 255 and the task would print 255
# instead of 1274991808. Every byte in this row goes through double() for that
# reason.

__t0 = tic;
total = 0;
slots = cell(1, 256);
for i = 0:9999999
  buf = zeros(1, 64, 'uint8');
  buf(1) = mod(i, 256);
  total = total + double(buf(1));
  slots{mod(i, 256) + 1} = buf;
end
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", total);
