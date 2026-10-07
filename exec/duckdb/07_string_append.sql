-- task 07 string_append — expected output: 250000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 07_string_append.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each .output switch.
-- note: DuckDB strings are immutable values, so there is no growable string to append into
--       and the append really does copy the whole value every time, which is the quadratic
--       case the task is written to expose. The loop carries the string as a column of the
--       recursive CTE and appends one character per iteration, 250000 times. Measured: the
--       whole cell is 106-167 s on this host, and it is the slowest of the fifteen.
-- note: the printed value is max(length(text)) rather than the last row's length, because
--       the recursive CTE is a stream that cannot be indexed from the end; the length only
--       ever grows, so the maximum is the final one.
-- note: SET threads=1 pins this cell to one core, as in task 01.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE __res AS
WITH RECURSIVE c(n, text) AS (
    SELECT 0, ''
    UNION ALL
    SELECT n + 1, text || 'x' FROM c WHERE n < 250000
)
SELECT max(length(text)) AS v FROM c;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
