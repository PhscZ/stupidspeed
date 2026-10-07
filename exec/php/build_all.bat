@echo off
setlocal enabledelayedexpansion
rem PHP row: two toolchains from one source set.
rem   zend      php <task>.php
rem   zend+jit  php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M <task>.php
rem Interpreter: tools\php-zts\php.exe (PHP 8.5.11 ZTS) — task 11 needs the PECL
rem `parallel` extension, which stock NTS PHP cannot load. See verify.py.
rem There is no compile step: "building" a task copies its source into the task
rem directory the verifier runs it from. Tasks 14 and 15 also get the fixture.
rem Output: exec\php\<toolchain>\<task>\<task>.php
set SRC=C:\stupidspeed\sources\php
set EXEC=C:\stupidspeed\exec\php
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%C in (zend zend-jit) do (
  for %%T in (%TASKS%) do (
    mkdir "%EXEC%\%%C\%%T" 2>nul
    copy /y "%SRC%\%%T.php" "%EXEC%\%%C\%%T\" >"%EXEC%\%%C\%%T\build.log" 2>&1
    if %%T==14_file_read copy /y "C:\stupidspeed\data.bin" "%EXEC%\%%C\%%T\" >>"%EXEC%\%%C\%%T\build.log" 2>&1
    if %%T==15_file_write copy /y "C:\stupidspeed\data.bin" "%EXEC%\%%C\%%T\" >>"%EXEC%\%%C\%%T\build.log" 2>&1
    if exist "%EXEC%\%%C\%%T\%%T.php" ( echo OK %%C %%T ) else ( echo PHP-FAIL %%C %%T )
  )
)
echo ALLDONE
