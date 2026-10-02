-- task 04 array_sum — expected output: 499999500000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 04_array_sum.sql"
-- note: an array in SQL is a table, so the million integers are a million rows of a
--       two-column table. The fill and the read-back are two separate statements, the way
--       the task has two separate loops: the recursive counter CTE drives the INSERT, and
--       the sum() aggregate is the second walk.
-- note: the table is an ordinary table in the main database. The run command opens
--       ":memory:", so the whole database is in memory and the row count is a RAM figure,
--       not a disk one.
-- note: the sum is 499999500000, well inside SQLite's 64-bit INTEGER.
CREATE TABLE a(i INTEGER PRIMARY KEY, v INTEGER);

INSERT INTO a(i, v)
WITH RECURSIVE c(x) AS (
    SELECT 0
    UNION ALL
    SELECT x + 1 FROM c WHERE x < 999999
)
SELECT x, x FROM c;

SELECT sum(v) FROM a;
