// task 12 matrix_add — expected output: 999000000
// sources/dart/12_matrix_add.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 12_matrix_add.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 12_matrix_add.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';
import 'dart:typed_data';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  const int n = 1000;
  final Int64List a = Int64List(n * n);
  final Int64List b = Int64List(n * n);

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      a[i * n + j] = i + j;
    }
  }
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      b[i * n + j] = i - j;
    }
  }

  final Int64List c = Int64List(n * n);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      c[i * n + j] = a[i * n + j] + b[i * n + j];
    }
  }

  int total = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      total += c[i * n + j];
    }
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(total);
}
