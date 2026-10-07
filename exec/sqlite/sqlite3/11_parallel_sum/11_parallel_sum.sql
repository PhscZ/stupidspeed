-- task 11 parallel_sum — expected output: 7500000075000000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 11_parallel_sum.sql"
-- note: SQLite is a library, not a language with threads. PRAGMA threads=N only
--       parallelises SQLite's own sort and index building, never arbitrary user
--       computation, so it cannot express four workers each computing a quarter of the
--       range. There is no thread to start from SQL and no way to declare one.
-- note: so this is four child processes, the same mechanism the VBScript and JScript rows
--       use: the script writes one worker program per quarter, starts all four with a
--       generated batch file that uses "start /b" (which does not wait), and blocks until
--       each child has renamed its partial-result file into place. Four processes on four
--       cores is real parallelism, not cooperative scheduling, and each worker owns a
--       fixed quarter so which one finishes first cannot change the answer. The parent
--       then reads the four partials and prints their sum.
-- note: the workers are the same sqlite3 executable. The batch file looks for it on PATH
--       first and falls back to the absolute path of the toolchain this row was measured
--       with, because the CLI has no way to ask a running process for its own image path.
-- note: each worker's range is task 02's switch over one quarter, x + t*25000000 for
--       x in 0..24999999, so the four partials sum to exactly task 02's total.
-- note: the scratch files (t11_*) are written into the working directory and deleted at
--       the end of the run; out.bin and data.bin are the only files this row expects to
--       find there.

-- timing: the clock is SQLite's own julianday('now') in milliseconds. The timer starts at
--       the entry of the script's own body and stops immediately before the final output
--       statement, which here is the join-and-sum that prints the answer. The four worker
--       processes are separate sqlite3 runs and print only their partial to a file, so this
--       script emits exactly one TIME_MS line.
CREATE TABLE __t0(t INTEGER);
INSERT INTO __t0 VALUES (cast(julianday('now')*86400000 as integer));

-- the four worker programs, one per quarter.  The writefile() calls return the byte
-- count of what they wrote, and that return value is not part of the row's stdout, so
-- the setup statements run with .output off.
.output off
SELECT writefile('t11_w' || t || '.sql',
                 'WITH RECURSIVE c(x) AS (SELECT 0 UNION ALL SELECT x+1 FROM c WHERE x < 24999999) '
                 || 'SELECT sum(CASE (x+' || (t * 25000000) || ')%4 '
                 || 'WHEN 0 THEN 1 '
                 || 'WHEN 1 THEN x+' || (t * 25000000) || ' '
                 || 'WHEN 2 THEN 2*(x+' || (t * 25000000) || ') '
                 || 'ELSE 3*(x+' || (t * 25000000) || ') END) FROM c;')
FROM (SELECT 0 AS t UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3);

-- one worker: run it, then rename the partial into place. The rename is the join signal,
-- because the shell creates the redirect target before the process has produced anything.
SELECT writefile('t11_one.bat',
'@echo off
"%SQ%" :memory: ".read t11_w%1.sql" > t11_p%1.txt
move /y t11_p%1.txt t11_r%1.txt >nul
');

-- the launcher: start all four, then wait for all four to have renamed their partial
SELECT writefile('t11_run.bat',
'@echo off
set SQ=sqlite3.exe
if exist "C:\stupidspeed\tools\msys64\msys64\ucrt64\bin\sqlite3.exe" set SQ=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin\sqlite3.exe
if exist "C:\stupidspeed\tools\sqlite\sqlite3.exe" set SQ=C:\stupidspeed\tools\sqlite\sqlite3.exe
start /b "" cmd /c "t11_one.bat 0 >nul 2>nul"
start /b "" cmd /c "t11_one.bat 1 >nul 2>nul"
start /b "" cmd /c "t11_one.bat 2 >nul 2>nul"
start /b "" cmd /c "t11_one.bat 3 >nul 2>nul"
set N=0
:wait
if exist t11_r0.txt if exist t11_r1.txt if exist t11_r2.txt if exist t11_r3.txt goto done
ping -n 2 127.0.0.1 >nul
set /a N+=1
if %N% LSS 900 goto wait
:done
');

.shell t11_run.bat

-- the join: all four partials exist, so sum them
.output stderr
SELECT printf('TIME_MS=%d', cast(julianday('now')*86400000 as integer) - (SELECT t FROM __t0));
.output stdout
SELECT sum(CAST(readfile('t11_r' || t || '.txt') AS INTEGER))
FROM (SELECT 0 AS t UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3);

.shell del t11_w0.sql t11_w1.sql t11_w2.sql t11_w3.sql t11_one.bat t11_run.bat t11_r0.txt t11_r1.txt t11_r2.txt t11_r3.txt t11_p0.txt t11_p1.txt t11_p2.txt t11_p3.txt 2>nul
