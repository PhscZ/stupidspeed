-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 01_branches.sql"
-- note: SQLite is a library with an SQL front end, not a language with a `for` statement,
--       so every loop in this row is a recursive CTE: WITH RECURSIVE c(x) AS (SELECT 0
--       UNION ALL SELECT x+1 FROM c WHERE x < N). That is the language's own way to
--       count, and it is not unrolled or memoised.
-- note: the one if/else chain becomes one pass of conditional aggregates over the counter
--       table: the branches are disjoint, so counting each condition separately is the
--       same walk the scalar version does. x%3 = 0 implies the first branch and excludes
--       the rest, which is why the later sums repeat the earlier conditions.
-- note: 100000000 rows, one row per iteration; this is the slowest shape in the row and
--       the same counter CTE appears in tasks 02, 03, 06, 08 and 11.
-- timing: the clock is SQLite's own julianday('now') in milliseconds, the same clock the
--       row's notes record. The timer starts at the entry of the script's own body and
--       stops immediately before the final output statement, so the answer is materialised
--       into a one-row table first and the timed region still contains all of the work.
CREATE TABLE __t0(t INTEGER);
INSERT INTO __t0 VALUES (cast(julianday('now')*86400000 as integer));
CREATE TABLE __res AS
WITH RECURSIVE c(x) AS (
    SELECT 0
    UNION ALL
    SELECT x + 1 FROM c WHERE x < 99999999
)
SELECT printf('%d %d %d %d',
              sum(x % 3 = 0),
              sum(x % 3 <> 0 AND x % 5 = 0),
              sum(x % 3 <> 0 AND x % 5 <> 0 AND x % 7 = 0),
              sum(x % 3 <> 0 AND x % 5 <> 0 AND x % 7 <> 0))
FROM c;

.output stderr
SELECT printf('TIME_MS=%d', cast(julianday('now')*86400000 as integer) - (SELECT t FROM __t0));
.output stdout

SELECT * FROM __res;
