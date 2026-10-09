// task 09 fib_recursive — expected output: 102334155
// sources/dart/09_fib_recursive.dart, recompiled for the `dart` row's two web targets.
// build: dart compile js -O4 09_fib_recursive.dart -o prog.js        (dart2js)
//        dart compile wasm -O4 09_fib_recursive.dart -o prog.wasm    (dart2wasm)
// run:   node prog.js   |   node exec/dart/dart2wasm/run.mjs
// dart:io does not exist on either web target.  The one thing these tasks need from it
// is a stderr line, and Node's console.error writes to fd 2, so dart:js_interop supplies it.

import 'dart:js_interop';

@JS('console.error')
external void _stderrWrite(String message);

int fib(int n) {
  if (n < 2) {
    return n;
  }
  return fib(n - 1) + fib(n - 2);
}

void main() {
  final Stopwatch sw = Stopwatch()..start();
  final int result = fib(40);
  _stderrWrite('TIME_MS=${(sw.elapsedMicroseconds / 1000).toStringAsFixed(3)}');
  print(result);
}
