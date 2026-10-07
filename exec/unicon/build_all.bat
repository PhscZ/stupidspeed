@echo off
setlocal
rem Unicon row: the build is `unicon -s <task>.icn`, which compiles to icode and writes
rem <task>.exe (the runtime is appended to the icode, so the exe is self-contained).
rem tools\unicon\bin must be on PATH for the compile; the exe needs nothing at run time.
rem Task 03 also names 03_func_sum_add_one.icn on the same command line -- add_one lives in
rem that second file and the icode is named after the first file.
rem Both the compiler and the executables it produces read their own appended image through
rem argv[0], so they must be invoked with a Windows-style backslash path.
rem Tasks 14 and 15 open their files in untranslated mode ("u"/"wu") and run in their own
rem directory, so the 50 MiB fixture is copied into those two task directories.
rem TIME_MS goes to stderr (&errout), so verify.py reads the run's stderr.
set SRC=C:\stupidspeed\sources\unicon
set EXEC=C:\stupidspeed\exec\unicon
set DATA=C:\stupidspeed\data.bin
set UNICON=C:\stupidspeed\tools\unicon\bin\unicon.exe
set PATH=C:\stupidspeed\tools\unicon\bin;%PATH%

for %%T in (01_branches 02_switch_case 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  mkdir "%EXEC%\unicon\%%T" 2>nul
  copy /y "%SRC%\%%T.icn" "%EXEC%\unicon\%%T\" >nul
  pushd "%EXEC%\unicon\%%T"
  "%UNICON%" -s %%T.icn > build.log 2>&1
  popd
  if exist "%EXEC%\unicon\%%T\%%T.exe" ( echo OK %%T ) else ( echo UNICON-FAIL %%T )
)

rem Task 03: two source files on one command line.
mkdir "%EXEC%\unicon\03_func_sum" 2>nul
copy /y "%SRC%\03_func_sum.icn" "%EXEC%\unicon\03_func_sum\" >nul
copy /y "%SRC%\03_func_sum_add_one.icn" "%EXEC%\unicon\03_func_sum\" >nul
pushd "%EXEC%\unicon\03_func_sum"
"%UNICON%" -s 03_func_sum.icn 03_func_sum_add_one.icn > build.log 2>&1
popd
if exist "%EXEC%\unicon\03_func_sum\03_func_sum.exe" ( echo OK 03_func_sum ) else ( echo UNICON-FAIL 03_func_sum )

rem Task 14 reads data.bin; task 15 reads nothing but writes out.bin beside it.
copy /y "%DATA%" "%EXEC%\unicon\14_file_read\" >nul
copy /y "%DATA%" "%EXEC%\unicon\15_file_write\" >nul
if exist "%EXEC%\unicon\14_file_read\data.bin" ( echo OK 14_file_read-data ) else ( echo UNICON-FAIL 14_file_read-data )
if exist "%EXEC%\unicon\15_file_write\data.bin" ( echo OK 15_file_write-data ) else ( echo UNICON-FAIL 15_file_write-data )
echo ALLDONE
