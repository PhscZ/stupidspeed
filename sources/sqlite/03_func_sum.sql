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
--       accumulator only ever increases.
WITH RECURSIVE c(x, value) AS (
    SELECT 0, 0
    UNION ALL
    SELECT x + 1, abs(value + 1) FROM c WHERE x < 100000000
)
SELECT max(value) FROM c;
