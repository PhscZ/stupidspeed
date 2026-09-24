// task 04 array_sum — expected output: 499999500000
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

import 'dart:typed_data';

void main() {
  const int n = 1000000;
  final Int64List array = Int64List(n);
  for (int i = 0; i < n; i++) {
    array[i] = i;
  }

  int total = 0;
  for (int i = 0; i < n; i++) {
    total += array[i];
  }
  print(total);
}
