// task 03 func_sum — expected output: 100000000
// build: dart compile exe -o prog 03_func_sum.dart (aot; jit has no build step)    run: ./prog (aot) | dart 03_func_sum.dart (jit)
// note: @pragma('vm:never-inline') is Dart's own no-inline marker, honoured by both the
//       AOT compiler and the JIT. Without it the AOT compiler is free to inline addOne at
//       its single call site and delete the 100000000 calls, which is exactly what the
//       task exists to measure.

import 'dart:io';

@pragma('vm:never-inline')
int addOne(int n) => n + 1;

void main() {
  final Stopwatch sw = Stopwatch()..start();
  int value = 0;
  for (int i = 0; i < 100000000; i++) {
    value = addOne(value);
  }
  stderr.writeln('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(value);
}
