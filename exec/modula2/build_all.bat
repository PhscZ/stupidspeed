@echo off
setlocal
rem Build all 15 Modula-2 tasks with ADW's Modula-2 for Windows x64 (m2amd64.exe).
rem   m2amd64.exe /sym:.;<adw>\ASCII\winamd64sym <task>.mod   -> <MODULE>.obj beside the source
rem   sblink.exe /machine:amd64 /out:prog.exe <MODULE>.obj rtl-win-amd64.lib win64api.lib
rem The `.` in /sym: is load-bearing: the compiler does NOT search the working directory for
rem symbol files by default, so a module whose definition module was compiled in the same
rem directory cannot be imported without it ("Could not open SYM file. 2 Func").
rem /machine:amd64 is mandatory too: the default linker machine type rejects the 64-bit object
rem with "Incorrect Machine Type". The compiler writes the .obj beside the SOURCE file and
rem names it after the MODULE, not the file (01_branches.mod is MODULE Task01), which is why
rem each task is built in its own directory. **That name is truncated to the length of the
rem source file's stem** — 10_pi.mod's stem is five characters, so MODULE Task10 would come out
rem as Task1.obj — which is why 10_pi's module is named T10. Task 03 compiles Func.def to
rem Func.sym, then Func.mod to Func.obj, then itself, and links Func.obj in — its AddOne has
rem to live in a separate module for the call not to be inlined away.
rem Note the link line carries no <MODULE>.lib: a program module produces only an .obj. The
rem BUILD.md line that named one was written before the toolchain was ever run.
rem Output: exec\modula2\<task>\prog.exe
set ADW=D:\Users\pedro.cardoso\stupidspeed\tools\adwm2
set SYM=.;%ADW%\ASCII\winamd64sym
set M2=%ADW%\ASCII\m2amd64.exe
set SBLINK=%ADW%\ASCII\sblink.exe
set RTL=%ADW%\ASCII\rtl-win-amd64.lib
set API=%ADW%\ASCII\win64api.lib
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\modula2
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\modula2

echo ########## adw
call :one 01_branches Task01
call :one 02_switch_case T64
call :func
call :one 03_func_sum Task03 Func.obj
call :one 04_array_sum Task04
call :one 05_alloc_churn Task05
call :one 06_char_count Task06
call :one 07_string_append Task07
call :one 08_average Task08
call :one 09_fib_recursive Task09
call :one 10_pi T10
call :one 11_parallel_sum TThread
call :one 12_matrix_add Task12
call :one 13_matrix_mul Task13
call :one 14_file_read Task14
call :one 15_file_write Task15
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
copy /y "%SRC%\%1.mod" . >nul
"%M2%" /sym:"%SYM%" %1.mod >compile.log 2>&1
if exist %2.obj (
  "%SBLINK%" /machine:amd64 /out:prog.exe %2.obj %3 "%RTL%" "%API%" >link.log 2>&1
)
if exist prog.exe ( echo OK adw %1 ) else ( echo M2-FAIL %1 )
exit /b 0

:func
mkdir "%EXEC%\03_func_sum" 2>nul
cd /d "%EXEC%\03_func_sum"
copy /y "%SRC%\Func.def" . >nul
copy /y "%SRC%\Func.mod" . >nul
"%M2%" /sym:"%SYM%" Func.def >func.log 2>&1
"%M2%" /sym:"%SYM%" Func.mod >>func.log 2>&1
exit /b 0
