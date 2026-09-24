// task 06 char_count — expected output: 10000000
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

void main() {
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
  print(count);
}
