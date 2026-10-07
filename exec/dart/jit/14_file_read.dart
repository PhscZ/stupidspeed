// task 14 file_read — expected output: 2389704704
// build: dart compile exe -o prog 14_file_read.dart (aot; jit has no build step)    run: ./prog (aot) | dart 14_file_read.dart (jit)

import 'dart:io';
import 'dart:typed_data';

void main() {
  final Stopwatch sw = Stopwatch()..start();
  const int chunk = 1048576; // 1 MiB
  final RandomAccessFile file = File('data.bin').openSync();
  final Uint8List buf = Uint8List(chunk);

  int total = 0;
  while (true) {
    final int read = file.readIntoSync(buf, 0, chunk);
    if (read <= 0) {
      break;
    }
    for (int i = 0; i < read; i++) {
      total += buf[i];
    }
  }
  file.closeSync();

  stderr.writeln('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(total & 0xFFFFFFFF);
}
