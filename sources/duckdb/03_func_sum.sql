-- task 03 func_sum — expected output: 100000000
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 03_func_sum.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each .output switch.
-- note: SQL cannot declare a scalar function -- a user-defined function exists only through
--       the C API, and the SQL text cannot define one -- so the task's add_one cannot be
--       written as SQL. DuckDB does have CREATE MACRO, but a macro is a bind-time text
--       substitution: `CREATE MACRO add_one(n) AS n + 1` is expanded by the binder and no
--       call survives into the plan, so it would measure nothing. The nearest thing the
--       language has to a real per-row call is a built-in scalar function, which the engine
--       calls through its function-call path once per row; that is what is called here:
--       abs(n) is the identity on the non-negative value this loop keeps, so abs(value + 1)
--       is add_one's body. This is the same choice the sqlite row records.
-- note: there is no no-inline marker to give, and none is needed: this is interpreted SQL,
--       so there is no compiler to delete the call.
-- note: the loop is range(0, 100000000), one row per iteration, which is the engine's own
--       way to count; the accumulator's final value is the largest value it reaches, because
--       it only ever increases.
-- note: SET threads=1 pins this cell to one core, as in task 01. The engine would otherwise
--       split the range across 8 cores.
-- note: max(abs(x+1)) returns HUGEINT (int128) and printf-free printing shows it in full.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE __res AS
SELECT max(abs(x + 1)) AS v
FROM range(0, 100000000) r(x);

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
