@echo off
setlocal
rem Luau row: no build step. luau.exe compiles the chunk to bytecode and runs it on its VM,
rem so build_all stages the fifteen scripts into exec\luau\luau\<task>\.
rem   tasks 01-10, 12, 13   tools\luau\luau.exe <task>.luau
rem   tasks 11, 14, 15      tools\lute\lute.exe run <task>.luau
rem The plain Luau CLI has no file I/O and no process API at all -- its `os` is
rem {clock, date, difftime, time}, with no io, no os.execute and no package -- so data.bin,
rem out.bin and task 11's four child processes are unreachable under luau.exe. Those three
rem tasks need Lute, the Luau team's own runtime, which supplies @lute/fs and @lute/process.
rem Tasks 14 and 15 therefore get the 50 MiB fixture copied into their task directories.
set SRC=C:\stupidspeed\sources\luau
set EXEC=C:\stupidspeed\exec\luau
set DATA=C:\stupidspeed\data.bin
set LUAU=C:\stupidspeed\tools\luau\luau.exe
set LUTE=C:\stupidspeed\tools\lute\lute.exe

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  mkdir "%EXEC%\luau\%%T" 2>nul
  copy /y "%SRC%\%%T.luau" "%EXEC%\luau\%%T\" >nul
  echo no build step: interpreted by "%LUAU%" -- tasks 11, 14, 15 by "%LUTE%" run > "%EXEC%\luau\%%T\build.log"
  if exist "%EXEC%\luau\%%T\%%T.luau" ( echo OK %%T ) else ( echo LUAU-FAIL %%T )
)

rem Task 14 reads data.bin; task 15 writes out.bin.
copy /y "%DATA%" "%EXEC%\luau\14_file_read\" >nul
copy /y "%DATA%" "%EXEC%\luau\15_file_write\" >nul
if exist "%EXEC%\luau\14_file_read\data.bin" ( echo OK 14_file_read-data ) else ( echo LUAU-FAIL 14_file_read-data )
if exist "%EXEC%\luau\15_file_write\data.bin" ( echo OK 15_file_write-data ) else ( echo LUAU-FAIL 15_file_write-data )
echo ALLDONE
