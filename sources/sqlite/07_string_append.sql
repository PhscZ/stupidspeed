-- task 07 string_append — expected output: 250000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 07_string_append.sql"
-- note: SQL strings are immutable values, so there is no growable string to append into
--       and the append really does copy the whole value every time, which is the quadratic
--       case the task is written to expose. The loop carries the string as a column of the
--       recursive CTE and appends one character per iteration, 250000 times.
-- note: the printed value is max(length(text)) rather than the last row's length, because
--       the recursive CTE is a stream that cannot be indexed from the end; the length only
--       ever grows, so the maximum is the final one.
-- timing: the clock is SQLite's own julianday('now') in milliseconds. The timer starts at
--       the entry of the script's own body and stops immediately before the final output
--       statement, so the answer is materialised into a one-row table first and the timed
--       region still contains all of the work.
CREATE TABLE __t0(t INTEGER);
INSERT INTO __t0 VALUES (cast(julianday('now')*86400000 as integer));

CREATE TABLE __res AS
WITH RECURSIVE c(n, text) AS (
    SELECT 0, ''
    UNION ALL
    SELECT n + 1, text || 'x' FROM c WHERE n < 250000
)
SELECT max(length(text)) FROM c;

.output stderr
SELECT printf('TIME_MS=%d', cast(julianday('now')*86400000 as integer) - (SELECT t FROM __t0));
.output stdout

SELECT * FROM __res;
