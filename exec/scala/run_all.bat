@echo off
rem Run all fifteen scala tasks the way exec\scala\verify.py does.
setlocal
set ROOT=%~dp0..\..
set JAVA=%ProgramFiles%\Common Files\Oracle\Java\javapath\java.exe
set CP=out;%ROOT%\tools\scala\maven2\org\scala-lang\scala3-library_3\3.9.0\scala3-library_3-3.9.0.jar;%ROOT%\tools\scala\maven2\org\scala-lang\scala-library\3.9.0\scala-library-3.9.0.jar
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\scala\jvm\%%T"
  "%JAVA%" -cp "%CP%" Main
  popd
)
endlocal
