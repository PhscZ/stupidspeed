// task 11 parallel_sum — expected output: 7500000075000000
// build: dart compile exe -o prog 11_parallel_sum.dart (aot; jit has no build step)    run: ./prog (aot) | dart 11_parallel_sum.dart (jit)
// Isolate.run spawns a real worker thread; isolates have separate heaps and communicate by message passing.

import 'dart:isolate';

int work(int t) {
  int acc = 0;
  final int start = t * 25000000;
  final int end = (t + 1) * 25000000;
  for (int i = start; i < end; i++) {
    switch (i % 4) {
      case 0:
        acc += 1;
        break;
      case 1:
        acc += i;
        break;
      case 2:
        acc += 2 * i;
        break;
      case 3:
        acc += 3 * i;
        break;
    }
  }
  return acc;
}

Future<void> main() async {
  final List<Future<int>> futures = <Future<int>>[];
  for (int t = 0; t < 4; t++) {
    futures.add(Isolate.run(() => work(t)));
  }
  final List<int> parts = await Future.wait(futures);
  int total = 0;
  for (final int part in parts) {
    total += part;
  }
  print(total);
}
