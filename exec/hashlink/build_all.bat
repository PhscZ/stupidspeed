@echo off
setlocal enabledelayedexpansion
rem Build all 15 Haxe-on-HashLink tasks into exec\hashlink\<task>\<task>.hl
rem   haxe -cp <dir> -main T<NN>_<name> -hl <task>.hl
rem   hl <task>.hl
rem -hl emits HashLink bytecode for the VM instead of C++, so no C toolchain and no hxcpp
rem are involved. Every source file is copied into each task directory so the class name
rem (T01_branches etc.) resolves from the compile path; AddOne.hx is task 03's second module.
set HAXE=C:\stupidspeed\tools\haxe\haxe.exe
set HL=C:\stupidspeed\tools\hashlink\hl.exe
set SRC=C:\stupidspeed\sources\hashlink
set EXEC=C:\stupidspeed\exec\hashlink

for %%T in (T01_branches T02_switch_case T03_func_sum T04_array_sum T05_alloc_churn T06_char_count T07_string_append T08_average T09_fib_recursive T10_pi T11_parallel_sum T12_matrix_add T13_matrix_mul T14_file_read T15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\*.hx" . >nul
  "%HAXE%" -cp . -main %%T -hl %%T.hl >build.log 2>&1
  if exist %%T.hl ( echo OK %%T ) else ( echo HASHlink-FAIL %%T )
)
echo ALLDONE
