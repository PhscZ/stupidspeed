-- task 08 average — expected output: 0.498046875
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 08_average.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each `.output` switch.
-- note: the loop is range(0, 100000000), one row per iteration, and the reading is
--       (i mod 256) / 256.0. The division is done in DOUBLE: x % 256 is an int64 and the
--       literal 256.0 makes the expression DOUBLE, so the / is a floating-point divide, not
--       DuckDB's `//` integer divide.
-- note: every reading is a multiple of 1/256, which is exact in binary, and the total stays
--       well under 2^53, so the sum is exact and the order the rows are added in cannot
--       change it. That matters here because DuckDB's aggregate is not order-guaranteed;
--       with an exact total the printed digits are the same either way.
-- note: SET threads=1 pins this cell to one core, as in task 01.
-- note: DuckDB prints DOUBLE 0.498046875 as "0.498046875" -- shortest round-trip form, no
--       trailing zeros and no exponent.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE __res AS
SELECT sum((x % 256) / 256.0) / 100000000 AS v
FROM range(0, 100000000) r(x);

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
