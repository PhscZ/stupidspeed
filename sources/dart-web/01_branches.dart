// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// sources/dart/01_branches.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 01_branches.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 01_branches.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  for (int i = 0; i < 100000000; i++) {
    if (i % 3 == 0) {
      a += 1;
    } else if (i % 5 == 0) {
      b += 1;
    } else if (i % 7 == 0) {
      c += 1;
    } else {
      d += 1;
    }
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print('$a $b $c $d');
}
