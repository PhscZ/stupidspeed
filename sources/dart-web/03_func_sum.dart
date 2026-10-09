// task 03 func_sum — expected output: 100000000
// sources/dart/03_func_sum.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 03_func_sum.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 03_func_sum.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// note: @pragma('vm:never-inline') is a VM hint; neither web compiler honours it, so
//       addOne may be inlined here and the row measures what the compiler kept, not a
//       100000000-call loop.  The output is unaffected.
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';

@JS('console.error')
external void _stderrWrite(String message);

@pragma('vm:never-inline')
int addOne(int n) => n + 1;

void main() {
  final Stopwatch sw = Stopwatch()..start();
  int value = 0;
  for (int i = 0; i < 100000000; i++) {
    value = addOne(value);
  }
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(value);
}
