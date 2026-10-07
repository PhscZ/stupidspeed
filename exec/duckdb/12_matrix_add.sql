-- task 12 matrix_add — expected output: 999000000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 12_matrix_add.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each `.output` switch.
-- note: A and B are real 1000x1000 tables (one million rows each, i and j columns), built by
--       the cross product of two range() counters. C is built from them by the join on
--       (i, j), so the add really happens once per element of C and the three eight-megabyte
--       arrays the task is about all exist. Nothing is fused: the build of A, the build of B
--       and the C = A + B pass are three separate statements.
-- note: the printed total is the sum of C. sum() over one million BIGINTs widens to HUGEINT
--       (int128), and 999000000 is far inside int64 either way.
-- note: SET threads=1 pins this cell to one core, as in task 01.
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
SELECT r.x, c.y, r.x + c.y
FROM range(0, 1000) r(x), range(0, 1000) c(y);

INSERT INTO B(i, j, v)
SELECT r.x, c.y, r.x - c.y
FROM range(0, 1000) r(x), range(0, 1000) c(y);

INSERT INTO C(i, j, v)
SELECT a.i, a.j, a.v + b.v
FROM A a JOIN B b ON b.i = a.i AND b.j = a.j;

CREATE TABLE __res AS SELECT sum(v) AS v FROM C;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
