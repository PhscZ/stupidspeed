// task 12 matrix_add — expected output: 999000000
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

import 'dart:typed_data';

void main() {
  const int n = 1000;
  final Int64List a = Int64List(n * n);
  final Int64List b = Int64List(n * n);

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      a[i * n + j] = i + j;
    }
  }
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      b[i * n + j] = i - j;
    }
  }

  final Int64List c = Int64List(n * n);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      c[i * n + j] = a[i * n + j] + b[i * n + j];
    }
  }

  int total = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      total += c[i * n + j];
    }
  }
  print(total);
}
