// task 06 char_count — expected output: 10000000
// sources/dart/06_char_count.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 06_char_count.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 06_char_count.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  // Built once, by repeating the whole block in one operation.
  final String text = 'abcdefghij' * 10000000;

  int count = 0;
  for (int i = 0; i < text.length; i++) {
    final int ch = text.codeUnitAt(i);
    if (ch == 0x61) {
      // 'a': skip
    } else if (ch == 0x65) {
      // 'e': skip
    } else if (ch == 0x68) {
      count += 1; // 'h'
    }
    // anything else: skip
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(count);
}
