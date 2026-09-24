// task 14 file_read — expected output: 484442112
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

import 'dart:io';
import 'dart:typed_data';

void main() {
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

  print(total & 0xFFFFFFFF);
}
