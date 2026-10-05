@echo off
setlocal enabledelayedexpansion
rem Dyalog APL is interpreted: dyascript runs the .dyalog source, there is no compiled
rem artifact, so exec\dyalog holds the sources plus this runner. dyascript.exe is the
rem console build (dyalog.exe is GUI-subsystem and never prints); -script is mandatory.
rem The answer goes to stdout; each task also writes "TIME_MS=<ms>" to time.txt in the
rem working directory with ⎕NPUT (flag 1 = overwrite), which this runner types out.
set DYASCRIPT=C:\stupidspeed\tools\dyalog\tree\ProgramFiles64Folder\Dyalog\Dyalog APL-64 20.0 Unicode\dyascript.exe
cd /d C:\stupidspeed\exec\dyalog
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  "%DYASCRIPT%" -script %%T.dyalog
  if exist time.txt ( type time.txt & del time.txt )
)
