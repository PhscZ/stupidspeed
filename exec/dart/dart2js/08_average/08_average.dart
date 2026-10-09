// task 08 average — expected output: 0.498046875
// sources/dart/08_average.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 08_average.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 08_average.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';

@JS('console.error')
external void _stderrWrite(String message);

void main() {
  final Stopwatch sw = Stopwatch()..start();
  double total = 0.0;
  for (int i = 0; i < 100000000; i++) {
    final double reading = (i % 256) / 256.0;
    total += reading;
  }
  // Exact decimal, 9 digits after the point, no exponent and no locale commas.
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print((total / 100000000).toStringAsFixed(9));
}
