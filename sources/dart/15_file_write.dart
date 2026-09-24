// task 15 file_write — expected output: 104857600
// build: dart compile exe -o prog 15_file_write.dart (aot; jit has no build step)    run: ./prog (aot) | dart 15_file_write.dart (jit)
// note: dart:io has no separate fsync call; flushSync() flushes the file's contents to disk.

import 'dart:io';
import 'dart:typed_data';

void main() {
  const int chunk = 1048576; // 1 MiB
  final Uint8List buf = Uint8List(chunk);
  for (int i = 0; i < chunk; i++) {
    buf[i] = i % 256;
  }

  final RandomAccessFile out = File('out.bin').openSync(mode: FileMode.write);
  int written = 0;
  for (int i = 0; i < 100; i++) {
    out.writeFromSync(buf, 0, chunk);
    written += chunk;
  }
  out.flushSync();
  out.closeSync();

  print(written);
}
