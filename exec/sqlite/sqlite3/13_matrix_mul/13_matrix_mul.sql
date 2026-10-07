-- task 13 matrix_mul — expected output: 599995000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 13_matrix_mul.sql"
-- note: the triple loop is the join of A and B on the shared index k, grouped by the
--       output cell (i, j): one group per cell of C, and one multiply-add per row of that
--       group. That is 500 * 500 * 500 = 125000000 multiply-adds, and no reordering or
--       blocking is applied, which is the point of the task.
-- note: A[i][j] = (i + j) mod 7 and B[i][j] = (i * j) mod 5, so both tables are 250000
--       rows and C is another 250000 rows.
-- note: the aggregate is over the join, so C is built first and then summed, matching the
--       task's two steps; the group-by is what makes the inner sum a scalar sum.
-- timing: the clock is SQLite's own julianday('now') in milliseconds. The timer starts at
--       the entry of the script's own body and stops immediately before the final output
--       statement, so the answer is materialised into a one-row table first and the timed
--       region still contains all of the work.
CREATE TABLE __t0(t INTEGER);
INSERT INTO __t0 VALUES (cast(julianday('now')*86400000 as integer));
CREATE TABLE A(i INTEGER, j INTEGER, v INTEGER, PRIMARY KEY(i, j));
CREATE TABLE B(i INTEGER, j INTEGER, v INTEGER, PRIMARY KEY(i, j));
CREATE TABLE C(i INTEGER, j INTEGER, v INTEGER, PRIMARY KEY(i, j));

INSERT INTO A(i, j, v)
WITH RECURSIVE r(x) AS (SELECT 0 UNION ALL SELECT x + 1 FROM r WHERE x < 499),
               c(y) AS (SELECT 0 UNION ALL SELECT y + 1 FROM c WHERE y < 499)
SELECT r.x, c.y, (r.x + c.y) % 7 FROM r, c;

INSERT INTO B(i, j, v)
WITH RECURSIVE r(x) AS (SELECT 0 UNION ALL SELECT x + 1 FROM r WHERE x < 499),
               c(y) AS (SELECT 0 UNION ALL SELECT y + 1 FROM c WHERE y < 499)
SELECT r.x, c.y, (r.x * c.y) % 5 FROM r, c;

INSERT INTO C(i, j, v)
SELECT a.i, b.j, sum(a.v * b.v)
FROM A a JOIN B b ON b.i = a.j
GROUP BY a.i, b.j;

CREATE TABLE __res AS SELECT sum(v) AS v FROM C;

.output stderr
SELECT printf('TIME_MS=%d', cast(julianday('now')*86400000 as integer) - (SELECT t FROM __t0));
.output stdout

SELECT * FROM __res;
