// task 13 matrix_mul — expected output: 599995000
// sources/dart/13_matrix_mul.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 13_matrix_mul.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 13_matrix_mul.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';
import 'dart:typed_data';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  const int n = 500;
  final Int32List a = Int32List(n * n);
  final Int32List b = Int32List(n * n);

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      a[i * n + j] = (i + j) % 7;
    }
  }
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      b[i * n + j] = (i * j) % 5;
    }
  }

  final Int64List c = Int64List(n * n);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      int sum = 0;
      for (int k = 0; k < n; k++) {
        sum += a[i * n + k] * b[k * n + j];
      }
      c[i * n + j] = sum;
    }
  }

  int total = 0;
  for (int i = 0; i < n * n; i++) {
    total += c[i];
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(total);
}
