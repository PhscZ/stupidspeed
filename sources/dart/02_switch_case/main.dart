// task 02 switch_case — expected output: 7500000075000000
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)

void main() {
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
  print(acc);
}
