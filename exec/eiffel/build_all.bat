@echo off
setlocal enabledelayedexpansion
rem Build all 15 EiffelStudio targets into exec\eiffel\EIFGENs\<target>\F_code\prog.exe
rem   ec -batch -finalize -c_compile -config stupidspeed.ecf -target <target>
rem -finalize is the optimisation (EiffelStudio has no -O level; its knob is the compilation
rem mode). One ECF carries all 15 targets; the system is named "prog", so every target's
rem executable is prog.exe in its own EIFGENs\<target>\F_code\.
rem Four environment variables, per BUILD.md: ISE_EIFFEL and ISE_LIBRARY both point at the
rem tree root (ISE_LIBRARY must NOT be the library subdirectory, because the ECF refers to
rem $ISE_LIBRARY\library\base\base.ecf), ISE_PLATFORM is win64, and ISE_C_COMPILER=mingw
rem selects the MinGW gcc 4.4.5 the delivery ships under gcc\win64\mingw\bin (plain "gcc"
rem leaves the compiler path empty and ec stops with "Cannot start "".").
rem The target's EIFGENs directory is wiped first: a partial/stale one makes the generated
rem E2 Makefile fail with "No rule to make target 'big_file_E2_c.obj'".
set ISE_EIFFEL=C:\stupidspeed\tools\eiffel\Eiffel_25.12
set ISE_LIBRARY=C:\stupidspeed\tools\eiffel\Eiffel_25.12
set ISE_PLATFORM=win64
set ISE_C_COMPILER=mingw
set PATH=%ISE_EIFFEL%\studio\spec\win64\bin;%PATH%
set EXEC=C:\stupidspeed\exec\eiffel
cd /d "%EXEC%"

for %%T in (t01_branches t02_switch_case t03_func_sum t04_array_sum t05_alloc_churn t06_char_count t07_string_append t08_average t09_fib_recursive t10_pi t11_parallel_sum t12_matrix_add t13_matrix_mul t14_file_read t15_file_write) do (
  echo === %%T
  if exist "%EXEC%\EIFGENs\%%T" rmdir /s /q "%EXEC%\EIFGENs\%%T"
  ec -batch -finalize -c_compile -config stupidspeed.ecf -target %%T >"%EXEC%\%%T.build.log" 2>&1
  if exist "%EXEC%\EIFGENs\%%T\F_code\prog.exe" ( echo OK %%T ) else ( echo EIFFEL-FAIL %%T )
)
echo ALLDONE
