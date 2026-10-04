-- task 09 fib_recursive — expected output: 102334155
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 09_fib_recursive.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each `.output` switch.
-- note: SQL has no function calls, so the recursion cannot be written as fib(n-1) + fib(n-2).
--       What a recursive CTE can express is the recursion tree itself, and that is what this
--       is: the seed row is the call fib(40), and each row that still needs splitting
--       produces the two rows of its own two sub-calls, n-1 and n-2, so the CTE enumerates
--       the 331160281 calls the naive recursion makes, one row each. The answer is the sum of
--       the values at the leaves, which is fib(40) because a leaf is 0 or 1 and the leaves'
--       values are exactly the additions the scalar version does.
-- note: DuckDB allows only ONE recursive self-reference in the recursive term -- writing
--       `SELECT n-1 FROM t WHERE n>=2 UNION ALL SELECT n-2 FROM t WHERE n>=2` fails to bind
--       with "Circular reference to CTE t, use WITH RECURSIVE to use recursive CTEs" even
--       though WITH RECURSIVE is there. The two-way split is therefore a cross join against
--       a two-row `dd` table of the deltas 1 and 2, which produces the same two rows per
--       node. That is the one place this file departs from the sqlite row's text.
-- note: this is breadth-first where the scalar recursion is depth-first, and the row count is
--       the call count either way. There is no memo table: the same n is expanded again at
--       every place the tree reaches it, which is the point of the task.
-- note: SET threads=1 pins this cell to one core, as in task 01.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE __res AS
WITH RECURSIVE t(n) AS (
    SELECT 40
    UNION ALL
    SELECT n - d FROM t, (SELECT 1 AS d UNION ALL SELECT 2) dd WHERE n >= 2
)
SELECT sum(n) AS v FROM t WHERE n < 2;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
