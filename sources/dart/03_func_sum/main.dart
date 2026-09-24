// task 03 func_sum — expected output: 100000000
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)
// note: a plain top-level function; the AOT compiler may inline the call away, the JIT keeps it.

int addOne(int n) => n + 1;

void main() {
  int value = 0;
  for (int i = 0; i < 100000000; i++) {
    value = addOne(value);
  }
  print(value);
}
