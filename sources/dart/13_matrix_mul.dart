// task 13 matrix_mul — expected output: 599995000
// build: dart compile exe -o prog 13_matrix_mul.dart (aot; jit has no build step)    run: ./prog (aot) | dart 13_matrix_mul.dart (jit)

import 'dart:typed_data';

void main() {
  const int n = 500;
  final Int32List a = Int32List(n * n);
  final Int32List b = Int32List(n * n);

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      a[i * n + j] = (i + j) % 7;
    }
  }
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      b[i * n + j] = (i * j) % 5;
    }
  }

  final Int64List c = Int64List(n * n);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      int sum = 0;
      for (int k = 0; k < n; k++) {
        sum += a[i * n + k] * b[k * n + j];
      }
      c[i * n + j] = sum;
    }
  }

  int total = 0;
  for (int i = 0; i < n * n; i++) {
    total += c[i];
  }
  print(total);
}
