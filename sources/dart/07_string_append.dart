// task 07 string_append — expected output: 250000
// build: dart compile exe -o prog 07_string_append.dart (aot; jit has no build step)    run: ./prog (aot) | dart 07_string_append.dart (jit)

import 'dart:io';

void main() {
  final Stopwatch sw = Stopwatch()..start();
  // Dart strings are immutable, so += copies the whole string every time.
  String text = '';
  for (int i = 0; i < 250000; i++) {
    text += 'x';
  }
  stderr.writeln('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(text.length);
}
