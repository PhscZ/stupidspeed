// task 07 string_append — expected output: 250000
// sources/dart/07_string_append.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 07_string_append.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 07_string_append.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  // Dart strings are immutable, so += copies the whole string every time.
  String text = '';
  for (int i = 0; i < 250000; i++) {
    text += 'x';
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(text.length);
}
