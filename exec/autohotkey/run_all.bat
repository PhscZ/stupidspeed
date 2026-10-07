@echo off
setlocal enabledelayedexpansion
rem AutoHotkey is interpreted: the .ahk script is the program, there is no compiled artifact.
rem /ErrorStdOut sends the script's own errors to stderr instead of a message box, which is
rem what lets the timing line be read from a redirected stderr.
rem The row's task 11 uses AutoHotkey's own process facility, so its helper script lives
rem beside the task exactly as it does in sources/autohotkey/.
set AHK=C:\stupidspeed\tools\autohotkey\AutoHotkey64.exe
rem tools\autohotkey must be on PATH, not merely invoked by absolute path: task 11 is four
rem child processes that the parent starts by launching the interpreter by name.
set PATH=C:\stupidspeed\tools\autohotkey;%PATH%
cd /d C:\stupidspeed\exec\autohotkey
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  "%AHK%" /ErrorStdOut %%T.ahk
)
