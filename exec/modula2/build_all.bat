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
rem source file's stem** -- 10_pi.mod's stem is five characters, so MODULE Task10 would come out
rem as Task1.obj -- which is why 10_pi's module is named T10. Task 03 compiles Func.def to
rem Func.sym, then Func.mod to Func.obj, then itself, and links Func.obj in -- its AddOne has
rem to live in a separate module for the call not to be inlined away.
rem Note the link line carries no <MODULE>.lib: a program module produces only an .obj.
rem Paths must use backslashes: the compiler's option parser splits the /sym: value on '/' too,
rem so a forward-slash path is misread as extra qualifiers ("Invalid qualifier STUPIDSPEED").
rem Output: exec\modula2\<task>\prog.exe
set ADW=C:\stupidspeed\tools\adwm2\app
set SYM=.;%ADW%\ASCII\winamd64sym
set M2=%ADW%\ASCII\m2amd64.exe
set SBLINK=%ADW%\ASCII\sblink.exe
set RTL=%ADW%\ASCII\rtl-win-amd64.lib
set API=%ADW%\ASCII\win64api.lib
set SRC=C:\stupidspeed\sources\modula2
set EXEC=C:\stupidspeed\exec\modula2

echo ########## adw
call :one 01_branches Task01
call :one 02_switch_case T64
call :task03
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
del build.log 2>nul
"%M2%" /sym:"%SYM%" %1.mod >build.log 2>&1
if exist %2.obj (
  "%SBLINK%" /machine:amd64 /out:prog.exe %2.obj %3 "%RTL%" "%API%" >>build.log 2>&1
)
if exist prog.exe ( echo OK adw %1 ) else ( echo MODULA2-FAIL %1 )
exit /b 0

:task03
rem 03_func_sum imports Func, so Func.def and Func.mod are compiled first, into the same
rem directory; the caller then links Func.obj in. All three logs land in build.log.
mkdir "%EXEC%\03_func_sum" 2>nul
cd /d "%EXEC%\03_func_sum"
copy /y "%SRC%\03_func_sum.mod" . >nul
copy /y "%SRC%\Func.def" . >nul
copy /y "%SRC%\Func.mod" . >nul
del build.log 2>nul
"%M2%" /sym:"%SYM%" Func.def >build.log 2>&1
"%M2%" /sym:"%SYM%" Func.mod >>build.log 2>&1
"%M2%" /sym:"%SYM%" 03_func_sum.mod >>build.log 2>&1
if exist Task03.obj (
  "%SBLINK%" /machine:amd64 /out:prog.exe Task03.obj Func.obj "%RTL%" "%API%" >>build.log 2>&1
)
if exist prog.exe ( echo OK adw 03_func_sum ) else ( echo MODULA2-FAIL 03_func_sum )
exit /b 0

