-- task 04 array_sum — expected output: 499999500000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 04_array_sum.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each `.output` switch.
-- note: the array is a real table, `arr(i, v)`, materialised with 1000000 rows; the fill pass
--       writes v = i and the read-back pass is a separate statement that sums the column.
--       That is the two passes the task describes, and the table is left at a million rows
--       on purpose. DuckDB stores a BIGINT column contiguously, so the read-back is the
--       sequential memory walk the task is measuring.
-- note: SET threads=1 pins this cell to one core, as in task 01.
-- note: 499999500000 needs 39 bits, so it is exact in int64; sum() widens it to HUGEINT
--       (int128) and printf('%d', ...) prints it in full.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE arr(i BIGINT, v BIGINT);
INSERT INTO arr SELECT x, x FROM range(0, 1000000) r(x);

CREATE TABLE __res AS
SELECT sum(v) AS v FROM arr;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
