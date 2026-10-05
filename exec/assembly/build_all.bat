@echo off
setlocal enabledelayedexpansion
rem Build all 15 nasm tasks into exec\assembly\<task>\prog.exe
rem Two stages: nasm -f win64 assembles to an .obj, then MSVC link.exe links it against
rem kernel32.lib into a freestanding PE32+ console executable. No C runtime, so link.exe
rem needs the MSVC and Windows SDK lib directories in LIB.
rem NOTE: the linker path is spelled inline, not via a variable. `LINK` is a reserved name
rem in some Windows shells and setting it produced LNK1107 (invalid or corrupt input) when
rem the variable was expanded into the command line.
set MSVC=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207
set SDK=C:\stupidspeed\tools\msvc\Windows Kits\10
set LIB=%MSVC%\lib\x64;%SDK%\Lib\10.0.26100.0\ucrt\x64;%SDK%\Lib\10.0.26100.0\um\x64
set PATH=C:\mingw64\bin;%PATH%
set SRC=C:\stupidspeed\sources\assembly
set EXEC=C:\stupidspeed\exec\assembly

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.asm" . >nul
  nasm -f win64 %%T.asm -o %%T.obj >nasm.log 2>&1
  if not exist %%T.obj (
    echo NASM-FAIL %%T & type nasm.log
  ) else (
    "%MSVC%\bin\Hostx64\x64\link.exe" /nologo /subsystem:console /entry:main /out:prog.exe %%T.obj kernel32.lib >link.log 2>&1
    if exist prog.exe ( echo OK %%T ) else ( echo LINK-FAIL %%T & type link.log )
  )
)
echo ALLDONE
