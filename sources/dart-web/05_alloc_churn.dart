// task 05 alloc_churn — expected output: 1274991808
// sources/dart/05_alloc_churn.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 05_alloc_churn.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 05_alloc_churn.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';
import 'dart:typed_data';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  int total = 0;
  final List<Uint8List?> slots = List<Uint8List?>.filled(256, null);
  for (int i = 0; i < 10000000; i++) {
    final Uint8List buf = Uint8List(64);
    buf[0] = i % 256;
    total += buf[0];
    slots[i % 256] = buf; // keeps buf reachable, drops the buffer it replaces
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(total);
}
