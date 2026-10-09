// task 02 switch_case — expected output: 7500000075000000
// sources/dart/02_switch_case.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 02_switch_case.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 02_switch_case.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  int acc = 0;
  for (int i = 0; i < 100000000; i++) {
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
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(acc);
}
