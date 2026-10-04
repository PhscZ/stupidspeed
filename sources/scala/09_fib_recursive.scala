// task 09 fib_recursive — expected output: 102334155
// build: scalac -release 17 -d out 09_fib_recursive.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// [native build: scala-cli --power package 09_fib_recursive.scala --native -S 3.9.0 --native-version 0.5.12 --native-mode release-fast --native-clang <llvm-mingw>/bin/clang.exe --native-clangpp <llvm-mingw>/bin/clang++.exe --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe    native run: prog.exe]
// note: the native row reuses this file unchanged; <llvm-mingw> is the tree BUILD.md names,
//       and BUILD.md explains the two llvm-mingw flags.
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

object Main {
  private def fib(n: Long): Long =
    if (n < 2L) n else fib(n - 1L) + fib(n - 2L)

  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(fib(40L))
  }
}
