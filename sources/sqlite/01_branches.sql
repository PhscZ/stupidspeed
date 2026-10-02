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
