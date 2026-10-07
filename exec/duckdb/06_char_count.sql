-- task 06 char_count — expected output: 10000000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 06_char_count.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each .output switch.
-- note: the text is 100000000 characters: "abcdefghij" repeated 10000000 times, built in one
--       set operation as the task asks -- repeat('0', 10000000) is ten million '0' characters
--       and replace() rewrites every one of them as the ten-character block, which is the
--       whole block repeat rather than an append loop. The build is a separate statement from
--       the scan, so the two costs can be told apart.
-- note: the scan is one pass over the whole text with the engine's own regexp matcher,
--       counting the 'h' occurrences. That is the walk the task describes; what it does not
--       materialise is the two comparisons that cannot change the count -- ch == 'a' and
--       ch == 'e' skip, they never increment, so the count of 'h' is the whole of the
--       counting. Every character position is still visited.
-- note: the alternative, indexing the text one character at a time with t[j] over range(1,
--       100000001), was measured and rejected: DuckDB's string subscript is not O(1) the way
--       SQLite's BLOB substr is, and a one-million-character version of it did not finish in
--       five minutes, so the per-character form would be quadratic in the string length.
-- note: SET threads=1 pins this cell to one core, as in task 01.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE txt AS
SELECT replace(repeat('0', 10000000), '0', 'abcdefghij') AS t;

CREATE TABLE __res AS
SELECT length(regexp_extract_all(t, 'h')) AS v
FROM txt;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
