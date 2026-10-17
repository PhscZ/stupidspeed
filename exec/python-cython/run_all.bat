@echo off
rem Run all fifteen cython programs the way exec\python-cython\verify.py does:
rem prog.exe in its own task directory, with the CPython 3.13 installation the
rem registry's env names on PATH, because the executables import python313.dll.
setlocal
set ROOT=%~dp0..\..
set PY=C:\Users\pz020\AppData\Local\Programs\Python\Python313
set "PATH=%PY%;%PY%\DLLs;%PATH%"
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\python-cython\cython\%%T"
  prog.exe
  popd
)
endlocal
