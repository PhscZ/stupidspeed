-- task 02 switch_case — expected output: 7500000075000000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 02_switch_case.sql"
-- note: SQLite has no switch statement; the four-way decision is a CASE expression, which
--       is the SQL spelling of the same dispatch. The loop is the same recursive counter
--       CTE as task 01, and the accumulator is the sum of the CASE over the counter.
-- note: the total is 7500000075000000, which is below 2^63, so SQLite's INTEGER holds it
--       exactly. SQLite switches to REAL only past 9223372036854775807, and this sum is
--       8.1x below that.
-- note: task 11 does exactly this work split four ways, and prints the same number.
WITH RECURSIVE c(x) AS (
    SELECT 0
    UNION ALL
    SELECT x + 1 FROM c WHERE x < 99999999
)
SELECT sum(CASE x % 4
               WHEN 0 THEN 1
               WHEN 1 THEN x
               WHEN 2 THEN 2 * x
               ELSE 3 * x
           END)
FROM c;
