-- task 13 matrix_mul — expected output: 599995000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 13_matrix_mul.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each `.output` switch.
-- note: the triple loop is the join of A and B on the shared index k, grouped by the output
--       cell (i, j): one group per cell of C, and one multiply-add per row of that group.
--       That is 500 * 500 * 500 = 125000000 multiply-adds, and no reordering or blocking is
--       applied, which is the point of the task.
-- note: A[i][j] = (i + j) mod 7 and B[i][j] = (i * j) mod 5, so both tables are 250000 rows
--       and C is another 250000 rows.
-- note: the aggregate is over the join, so C is built first and then summed, matching the
--       task's two steps; the group-by is what makes the inner sum a scalar sum. The query
--       planner is free to pick the join order, which is the engine's business, not a trick
--       in this file: nothing is blocked, tiled or reordered by hand.
-- note: SET threads=1 pins this cell to one core, as in task 01. Left at DuckDB's default of
--       8 threads this join would be a parallel measurement and not comparable with the
--       single-threaded rows.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE A(i BIGINT, j BIGINT, v BIGINT, PRIMARY KEY(i, j));
CREATE TABLE B(i BIGINT, j BIGINT, v BIGINT, PRIMARY KEY(i, j));
CREATE TABLE C(i BIGINT, j BIGINT, v BIGINT, PRIMARY KEY(i, j));

INSERT INTO A(i, j, v)
SELECT r.x, c.y, (r.x + c.y) % 7
FROM range(0, 500) r(x), range(0, 500) c(y);

INSERT INTO B(i, j, v)
SELECT r.x, c.y, (r.x * c.y) % 5
FROM range(0, 500) r(x), range(0, 500) c(y);

INSERT INTO C(i, j, v)
SELECT a.i, b.j, sum(a.v * b.v)
FROM A a JOIN B b ON b.i = a.j
GROUP BY a.i, b.j;

CREATE TABLE __res AS SELECT sum(v) AS v FROM C;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
