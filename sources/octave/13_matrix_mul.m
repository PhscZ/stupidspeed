# task 13 matrix_mul — expected output: 599995000
# build: none (interpreted)    run: octave-cli -qf 13_matrix_mul.m
#
# Plain i, j, k triple loop in that order, no reordering and no library
# multiply. Flat double row vectors with the 1-based index i * n + j + 1.

__t0 = tic;
n = 500;
A = zeros(1, n * n);
B = zeros(1, n * n);
for i = 0:n-1
  for j = 0:n-1
    k = i * n + j + 1;
    A(k) = mod(i + j, 7);
    B(k) = mod(i * j, 5);
  end
end
C = zeros(1, n * n);
for i = 0:n-1
  for j = 0:n-1
    s = 0;
    for k = 0:n-1
      s = s + A(i * n + k + 1) * B(k * n + j + 1);
    end
    C(i * n + j + 1) = s;
  end
end
total = 0;
for k = 1:n * n
  total = total + C(k);
end
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", total);
