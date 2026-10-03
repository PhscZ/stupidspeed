// task 07 string_append — expected output: 250000
// build: dart compile exe -o prog 07_string_append.dart (aot; jit has no build step)    run: ./prog (aot) | dart 07_string_append.dart (jit)

void main() {
  // Dart strings are immutable, so += copies the whole string every time.
  String text = '';
  for (int i = 0; i < 250000; i++) {
    text += 'x';
  }
  print(text.length);
}
