@echo off
setlocal enabledelayedexpansion
rem Build all 15 Scala (JVM) tasks (row sources\scala, toolchain "jvm").
rem Header build/run line (BUILD.md line ~589, Scala 3.9.0):
rem   scalac -release 17 -d out <task>.scala
rem   java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
rem JAVACMD is pinned at the Oracle javapath java (24): scala's libexec\common.bat
rem deliberately skips any java.exe under a "javapath" directory, so with the box's PATH
rem (javapath 24 first, java8path 8 second) it picks the Java 8 shim and scalac dies with
rem UnsupportedClassVersionError on class file 61.0.  Pinning JAVACMD is what BUILD.md's
rem "needs a JDK 17 or newer" means here.
rem Output: exec\scala\jvm\<task>\out\Main.class  (plus data.bin for 14/15, out.bin left by 15)
set "ROOT=%~dp0..\.."
set "SRC=%ROOT%\sources\scala"
set "SCALAC=%ROOT%\tools\scala\bin\scalac.bat"
set "JAVACMD=%ProgramFiles%\Common Files\Oracle\Java\javapath\java.exe"
set "SCALA=%ROOT%\tools\scala"
set "SCALA3LIB=%SCALA%\maven2\org\scala-lang\scala3-library_3\3.9.0\scala3-library_3-3.9.0.jar"
set "SCALALIB=%SCALA%\maven2\org\scala-lang\scala-library\3.9.0\scala-library-3.9.0.jar"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

echo ########## jvm
for %%T in (%TASKS%) do (
  mkdir "%~dp0jvm\%%T" 2>nul
  cd /d "%~dp0jvm\%%T"
  copy /y "%SRC%\%%T.scala" . >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" . >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" . >nul
  if not exist out mkdir out
  call "%SCALAC%" -release 17 -d out "%%T.scala" > build.log 2>&1
  if errorlevel 1 (echo SCALA-FAIL %%T) else (echo OK %%T)
)
echo ALLDONE
