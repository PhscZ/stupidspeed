-- task 02 switch_case — expected output: 7500000075000000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 02_switch_case.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each `.output` switch.
-- note: the switch is written as a CASE expression over i mod 4, DuckDB's own spelling of
--       the four-way decision, and the loop is range(0, 100000000) -- one row per iteration,
--       the same shape the sqlite row uses, and the engine's own way to count.
-- note: SET threads=1 pins this cell to one core, as in task 01; DuckDB would otherwise run
--       the range scan and the aggregate on all 8 cores and this would stop being a
--       single-core measurement.
-- note: the accumulator is int64 and the total 7500000075000000 needs 53 bits, which is
--       inside it. sum() promotes to HUGEINT (int128), so the answer is exact either way;
--       2*i and 3*i are computed in int64 before the sum widens.
-- note: 7500000075000000 is the same number task 11 prints, so the two are directly
--       comparable: this cell is one core, task 11 is four child processes.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE __res AS
SELECT sum(CASE x % 4
             WHEN 0 THEN 1
             WHEN 1 THEN x
             WHEN 2 THEN 2 * x
             ELSE 3 * x
           END) AS v
FROM range(0, 100000000) r(x);

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
