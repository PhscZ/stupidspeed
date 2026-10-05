-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 01_branches.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build ("IO Error: Failed to open
--       file /dev/null"), so the run line passes no init file at all. The CLI CRLF-
--       translates everything it writes unless `.binary on` is in force, so every file here
--       sets `.binary on` and re-issues it after each `.output` switch: without it the
--       TIME_MS line ends in \r\n. With it, stdout and stderr are LF-only.
-- note: DuckDB is a database, not a language with a `for` statement, so the loop is the
--       engine's own range() table function, 100000000 rows, one row per iteration. That is
--       the same shape the sqlite row's counter CTE has; range() is cheaper and is DuckDB's
--       own idiom for counting, and it is neither unrolled nor memoised.
-- note: the if/else chain becomes one pass of conditional aggregates over that range: the
--       branches are disjoint, so counting each condition separately is the same walk the
--       scalar version does. x%3=0 implies the first branch and excludes the rest, which is
--       why the later sums repeat the earlier conditions.
-- note: SET threads=1 pins the engine to one core for this cell. DuckDB parallelises its own
--       operators by default (threads reports 8 on this host) and range()+aggregate is one
--       of them, so leaving the default on would have made this a four-core measurement and
--       destroyed the task-01/task-11 comparison. Every task here except 11 sets threads=1.
-- note: sum() over 100000000 rows returns HUGEINT (int128); printf('%d', ...) prints it in
--       full. The four counts are far inside int64 anyway.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE __res AS
SELECT printf('%d %d %d %d',
              sum(CASE WHEN x % 3 = 0 THEN 1 ELSE 0 END),
              sum(CASE WHEN x % 3 <> 0 AND x % 5 = 0 THEN 1 ELSE 0 END),
              sum(CASE WHEN x % 3 <> 0 AND x % 5 <> 0 AND x % 7 = 0 THEN 1 ELSE 0 END),
              sum(CASE WHEN x % 3 <> 0 AND x % 5 <> 0 AND x % 7 <> 0 THEN 1 ELSE 0 END)) AS s
FROM range(0, 100000000) r(x);

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT s FROM __res;
