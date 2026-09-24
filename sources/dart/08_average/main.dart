// task 08 average — expected output: 0.498046875
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

void main() {
  double total = 0.0;
  for (int i = 0; i < 100000000; i++) {
    final double reading = (i % 256) / 256.0;
    total += reading;
  }
  // Exact decimal, 9 digits after the point, no exponent and no locale commas.
  print((total / 100000000).toStringAsFixed(9));
}
