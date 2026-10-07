-- task 03 func_sum — expected output: 100000000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 03_func_sum.sql"
-- note: SQL has no way to declare a scalar function — a user-defined function in SQLite
--       exists only through the C API, and the SQL text cannot define one — so the task's
--       add_one cannot be written as SQL. The nearest thing the language does have is a
--       built-in scalar function, which the VDBE calls through its function-call path once
--       per row, and that is what is called here: abs(n) is the identity on the
--       non-negative value this loop keeps, so abs(value + 1) is add_one's body.
-- note: there is no no-inline marker to give, and none is needed: the row is interpreted
--       SQL, so there is no compiler to delete the call. What the query planner may do is
--       constant-fold the argument, which is a property of SQLite, not of this file.
-- note: the loop is the usual counter CTE carrying the accumulator as its second column;
--       the answer is the largest value it reaches, which is the last one, because the
--       the accumulator only ever increases.
-- timing: the clock is SQLite's own julianday('now') in milliseconds. The timer starts at
--       the entry of the script's own body and stops immediately before the final output
--       statement, so the answer is materialised into a one-row table first and the timed
--       region still contains all of the work.
CREATE TABLE __t0(t INTEGER);
INSERT INTO __t0 VALUES (cast(julianday('now')*86400000 as integer));
CREATE TABLE __res AS
WITH RECURSIVE c(x, value) AS (
    SELECT 0, 0
    UNION ALL
    SELECT x + 1, abs(value + 1) FROM c WHERE x < 100000000
)
SELECT max(value) AS v FROM c;

.output stderr
SELECT printf('TIME_MS=%d', cast(julianday('now')*86400000 as integer) - (SELECT t FROM __t0));
.output stdout

SELECT * FROM __res;
