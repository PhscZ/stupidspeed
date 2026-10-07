-- task 11 parallel_sum — expected output: 7500000075000000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 11_parallel_sum.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. Only the parent prints a
--         TIME_MS line: the four workers are separate duckdb processes whose stdout goes to
--         a partial-result file and whose stderr is discarded, so this script's stderr
--         carries exactly one line. The one statement before the timer -- SET threads=1 --
--         is configuration, the same place the sqlite row's PRAGMA would sit, and is
--         outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each .output switch.
-- note: DuckDB is a database, not a language with threads. SET threads=N parallelises
--       DuckDB's own operators -- scans, joins, aggregates, sorts -- and never arbitrary
--       user computation, so it cannot express four workers that each compute a quarter of
--       the range: any single query over range(0,100000000) is one operator the engine
--       splits on its own terms, and the split would not be the task's four fixed quarters.
--       There is no thread to start from SQL and no way to declare one.
-- note: so this is four child processes, the same mechanism the sqlite, VBScript and JScript
--       rows use: the script writes one worker program per quarter, starts all four with a
--       generated batch file that uses "start /b" (which does not wait), and blocks until
--       each child has renamed its partial-result file into place. Four processes on four
--       cores is real parallelism, not cooperative scheduling, and each worker owns a fixed
--       quarter so which one finishes first cannot change the answer. The parent then reads
--       the four partials and prints their sum. Measured: the four workers' own start
--       timestamps are within 0.6 s of one another and their intervals overlap, the four
--       quarters run serially inside one process take 10.5 s, and the four-process version
--       takes about 6 s of wall time (5.7-10.7 s depending on what else is on the box) --
--       so the four really are on four cores at once. It is not 4x, because each worker
--       pays duckdb's ~0.6 s start-up and the four contend for memory bandwidth; the
--       answer is what the task fixes, and the concurrency is real.
-- note: the workers are the same duckdb executable. The batch files look for duckdb.exe on
--       PATH first and fall back to the absolute path of the toolchain this row was measured
--       with, because the CLI has no way to ask a running process for its own image path.
-- note: the rename is the join signal: the shell creates the redirect target before the
--       process has produced anything, so the parent must not read the partial until the
--       child has moved it into place. The parent polls for the four renamed files, with a
--       1 ms ping to loopback as the yield (the sqlite row's `ping -n 2` idiom, but with
--       -n 1 -w 1): a full one-second sleep between checks cost two seconds of wall time on
--       a run that only takes six.
-- note: each worker's range is task 02's switch over one quarter, x + t*25000000 for x in
--       0..24999999, so the four partials sum to exactly task 02's total. Each worker sets
--       threads=1, so the four together use four cores and are comparable with the
--       single-core task 02 cell.
-- note: the scratch files (t11_*) are written into the working directory and deleted at the
--       end of the run; out.bin and data.bin are the only files this row expects to find
--       there. The cleanup is one .shell line handing the whole command to cmd, because
--       DuckDB's .shell does not run its argument through cmd.exe -- it quotes each
--       argument and executes the first one directly -- so a cmd builtin like del is not
--       reachable from .shell otherwise. The launcher is deleted from there rather than
--       from inside itself, because a batch file that deletes itself stops cmd reading its
--       own remaining lines and fails with "could not find the batch file".
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

-- the four worker programs, one per quarter
CREATE TABLE wk(t BIGINT, prog VARCHAR);
INSERT INTO wk
SELECT x,
       '.binary on' || chr(10) ||
       '.mode list' || chr(10) ||
       '.headers off' || chr(10) ||
       'SET threads=1;' || chr(10) ||
       'SELECT sum(CASE (x + ' || (x * 25000000) || ') % 4 ' ||
       'WHEN 0 THEN 1 ' ||
       'WHEN 1 THEN x + ' || (x * 25000000) || ' ' ||
       'WHEN 2 THEN 2 * (x + ' || (x * 25000000) || ') ' ||
       'ELSE 3 * (x + ' || (x * 25000000) || ') END) ' ||
       'FROM range(0, 25000000) r(x);' || chr(10)
FROM range(0, 4) r(x);

COPY (SELECT prog FROM wk WHERE t = 0) TO 't11_w0.sql' (FORMAT csv, HEADER false, DELIMITER '', QUOTE '', ESCAPE '');
COPY (SELECT prog FROM wk WHERE t = 1) TO 't11_w1.sql' (FORMAT csv, HEADER false, DELIMITER '', QUOTE '', ESCAPE '');
COPY (SELECT prog FROM wk WHERE t = 2) TO 't11_w2.sql' (FORMAT csv, HEADER false, DELIMITER '', QUOTE '', ESCAPE '');
COPY (SELECT prog FROM wk WHERE t = 3) TO 't11_w3.sql' (FORMAT csv, HEADER false, DELIMITER '', QUOTE '', ESCAPE '');

-- one worker: run it, then rename the partial into place
CREATE TABLE one(txt VARCHAR);
INSERT INTO one VALUES ('@echo off
set DQ=duckdb.exe
if exist "C:\stupidspeed\tools\duckdb\duckdb.exe" set DQ=C:\stupidspeed\tools\duckdb\duckdb.exe
"%DQ%" -no-init :memory: ".read t11_w%1.sql" > t11_p%1.txt 2>nul
move /y t11_p%1.txt t11_r%1.txt >nul
exit /b 0
');
COPY (SELECT txt FROM one) TO 't11_one.bat' (FORMAT csv, HEADER false, DELIMITER '', QUOTE '', ESCAPE '');

-- the launcher: start all four, then wait for all four to have renamed their partial
CREATE TABLE run(txt VARCHAR);
INSERT INTO run VALUES ('@echo off
start /b "" cmd /c "t11_one.bat 0 >nul 2>nul"
start /b "" cmd /c "t11_one.bat 1 >nul 2>nul"
start /b "" cmd /c "t11_one.bat 2 >nul 2>nul"
start /b "" cmd /c "t11_one.bat 3 >nul 2>nul"
set N=0
:wait
if exist t11_r0.txt if exist t11_r1.txt if exist t11_r2.txt if exist t11_r3.txt goto done
ping -n 1 -w 1 127.0.0.1 >nul
set /a N+=1
if %N% LSS 100000 goto wait
:done
exit /b 0
');
COPY (SELECT txt FROM run) TO 't11_run.bat' (FORMAT csv, HEADER false, DELIMITER '', QUOTE '', ESCAPE '');

.shell t11_run.bat

-- the join: all four partials exist, so sum them
CREATE TABLE __res AS
SELECT sum(v) AS v
FROM read_csv(['t11_r0.txt', 't11_r1.txt', 't11_r2.txt', 't11_r3.txt'],
              header = false, columns = {'v': 'BIGINT'});

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;

-- cleanup: DuckDB's .shell does not run its argument through cmd.exe -- it quotes each
-- argument and executes the first one directly -- so a cmd builtin like del is only
-- reachable by handing the whole command line to cmd. The launcher is deleted from here
-- rather than from inside itself, because a batch file that deletes itself stops cmd from
-- reading its own remaining lines and prints "could not find the batch file".
.shell cmd /c "del t11_w0.sql t11_w1.sql t11_w2.sql t11_w3.sql t11_one.bat t11_run.bat t11_r0.txt t11_r1.txt t11_r2.txt t11_r3.txt t11_p0.txt t11_p1.txt t11_p2.txt t11_p3.txt 2>nul"
