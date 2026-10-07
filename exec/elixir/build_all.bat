@echo off
setlocal
rem NOTE: delayed expansion stays OFF on purpose -- the parse check below contains `!`
rem       (Code.string_to_quoted!/File.read!), which cmd would eat as a delayed variable.
rem Build all 15 Elixir tasks (row sources\elixir, toolchain "elixir").
rem   run: C:\stupidspeed\tools\elixir\bin\elixir.bat <task>.exs
rem Elixir has no build step -- elixir compiles the script on every run -- so the
rem "build" here is a parse check (Code.string_to_quoted!) whose log lands in build.log,
rem the same shape the ruby/perl interpreted rows use.  Elixir needs Erlang's erl.exe on
rem PATH: elixir.bat invokes it bare, so tools\erlang\bin goes first.
rem TIME_MS is printed to stderr by every task (the header says so; no time.txt here).
rem Output: exec\elixir\elixir\<task>\<task>.exs  (plus data.bin for 14/15, out.bin left by 15)
set "ROOT=%~dp0..\.."
set "SRC=%ROOT%\sources\elixir"
set "ELIXIR=%ROOT%\tools\elixir\bin\elixir.bat"
set "PATH=%ROOT%\tools\erlang\bin;%PATH%"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

echo ########## elixir
for %%T in (%TASKS%) do (
  mkdir "%~dp0elixir\%%T" 2>nul
  cd /d "%~dp0elixir\%%T"
  copy /y "%SRC%\%%T.exs" . >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" . >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" . >nul
  call "%ELIXIR%" -e "Code.string_to_quoted!(File.read!(~s|%%T.exs|))" > build.log 2>&1
  if errorlevel 1 (echo ELIXIR-FAIL %%T) else (echo OK %%T)
)
echo ALLDONE
