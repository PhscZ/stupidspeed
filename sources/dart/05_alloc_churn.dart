// task 05 alloc_churn — expected output: 1274991808
// build: dart compile exe -o prog 05_alloc_churn.dart (aot; jit has no build step)    run: ./prog (aot) | dart 05_alloc_churn.dart (jit)

import 'dart:typed_data';

void main() {
  int total = 0;
  final List<Uint8List?> slots = List<Uint8List?>.filled(256, null);
  for (int i = 0; i < 10000000; i++) {
    final Uint8List buf = Uint8List(64);
    buf[0] = i % 256;
    total += buf[0];
    slots[i % 256] = buf; // keeps buf reachable, drops the buffer it replaces
  }
  print(total);
}
