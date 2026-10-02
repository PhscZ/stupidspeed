-- task 12 matrix_add — expected output: 999000000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 12_matrix_add.sql"
-- note: a 1000x1000 array is a million-row table, and building it is a cross join of the
--       two recursive counter CTEs -- the SQL spelling of the two nested loops that fill
--       A and B. A[i][j] = i + j and B[i][j] = i - j, and C is the row-wise join of the
--       two, so the three eight-megabyte arrays the task describes are three tables.
-- note: the tables are ordinary tables in the ":memory:" database, so the whole 24 MB is
--       in RAM, which is what makes this a bandwidth test rather than a disk test.
-- note: sum over C is 999000000: A's total is 999000000 and B's is 0, and they are
--       disjoint row-wise only in value, so the join is a real per-element add.
CREATE TABLE A(i INTEGER, j INTEGER, v INTEGER, PRIMARY KEY(i, j));
CREATE TABLE B(i INTEGER, j INTEGER, v INTEGER, PRIMARY KEY(i, j));
CREATE TABLE C(i INTEGER, j INTEGER, v INTEGER, PRIMARY KEY(i, j));

INSERT INTO A(i, j, v)
WITH RECURSIVE r(x) AS (SELECT 0 UNION ALL SELECT x + 1 FROM r WHERE x < 999),
               c(y) AS (SELECT 0 UNION ALL SELECT y + 1 FROM c WHERE y < 999)
SELECT r.x, c.y, r.x + c.y FROM r, c;

INSERT INTO B(i, j, v)
WITH RECURSIVE r(x) AS (SELECT 0 UNION ALL SELECT x + 1 FROM r WHERE x < 999),
               c(y) AS (SELECT 0 UNION ALL SELECT y + 1 FROM c WHERE y < 999)
SELECT r.x, c.y, r.x - c.y FROM r, c;

INSERT INTO C(i, j, v)
SELECT a.i, a.j, a.v + b.v
FROM A a JOIN B b ON b.i = a.i AND b.j = a.j;

SELECT sum(v) FROM C;
