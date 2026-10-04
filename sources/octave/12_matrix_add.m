# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: octave-cli -qf 12_matrix_add.m
#
# Flat double row vectors with the 1-based index i * n + j + 1, the same layout
# as the i * n + j the other languages use. The fill, the add and the sum are
# three separate loops, as in every other row.

__t0 = tic;
n = 1000;
A = zeros(1, n * n);
B = zeros(1, n * n);
for i = 0:n-1
  for j = 0:n-1
    k = i * n + j + 1;
    A(k) = i + j;
    B(k) = i - j;
  end
end
C = zeros(1, n * n);
for i = 0:n-1
  for j = 0:n-1
    k = i * n + j + 1;
    C(k) = A(k) + B(k);
  end
end
total = 0;
for k = 1:n * n
  total = total + C(k);
end
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", total);
