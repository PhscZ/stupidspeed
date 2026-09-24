// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

void main() {
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
  print('$a $b $c $d');
}
