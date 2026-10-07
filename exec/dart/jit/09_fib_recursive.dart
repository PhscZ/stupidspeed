// task 09 fib_recursive — expected output: 102334155
// build: dart compile exe -o prog 09_fib_recursive.dart (aot; jit has no build step)    run: ./prog (aot) | dart 09_fib_recursive.dart (jit)

import 'dart:io';

int fib(int n) {
  if (n < 2) {
    return n;
  }
  return fib(n - 1) + fib(n - 2);
}

void main() {
  final Stopwatch sw = Stopwatch()..start();
  final int result = fib(40);
  stderr.writeln('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(result);
}
