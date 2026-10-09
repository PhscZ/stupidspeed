// task 04 array_sum — expected output: 499999500000
// sources/dart/04_array_sum.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 04_array_sum.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 04_array_sum.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';
import 'dart:typed_data';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  const int n = 1000000;
  final Int64List array = Int64List(n);
  for (int i = 0; i < n; i++) {
    array[i] = i;
  }

  int total = 0;
  for (int i = 0; i < n; i++) {
    total += array[i];
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(total);
}
