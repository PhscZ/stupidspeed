-- task 02 switch_case — expected output: 7500000075000000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 02_switch_case.sql"
-- note: SQLite has no switch statement; the four-way decision is a CASE expression, which
--       is the SQL spelling of the same dispatch. The loop is the same recursive counter
--       CTE as task 01, and the accumulator is the sum of the CASE over the counter.
-- note: the total is 7500000075000000, which is below 2^63, so SQLite's INTEGER holds it
--       exactly. SQLite switches to REAL only past 9223372036854775807, and this sum is
--       8.1x below that.
--       task 11 does exactly this work split four ways, and prints the same number.
-- timing: the clock is SQLite's own julianday('now') in milliseconds. The timer starts at
--       the entry of the script's own body and stops immediately before the final output
--       statement, so the answer is materialised into a one-row table first and the timed
--       region still contains all of the work.
CREATE TABLE __t0(t INTEGER);
INSERT INTO __t0 VALUES (cast(julianday('now')*86400000 as integer));
CREATE TABLE __res AS
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
           END) AS total
FROM c;

.output stderr
SELECT printf('TIME_MS=%d', cast(julianday('now')*86400000 as integer) - (SELECT t FROM __t0));
.output stdout

SELECT * FROM __res;
