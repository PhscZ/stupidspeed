// task 07 string_append — expected output: 1000000
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

void main() {
  // Dart strings are immutable, so += copies the whole string every time.
  String text = '';
  for (int i = 0; i < 1000000; i++) {
    text += 'x';
  }
  print(text.length);
}
