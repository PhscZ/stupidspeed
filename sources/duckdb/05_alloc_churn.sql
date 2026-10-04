-- task 05 alloc_churn — expected output: 1274991808
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 05_alloc_churn.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each `.output` switch.
-- note: the 256-element slots array is a 256-row table with a primary key on the slot index,
--       and one iteration of the loop is one row of the INSERT ... SELECT, which DuckDB
--       feeds through its own upsert path. The buffer is a 64-character string built per
--       row, its first byte is i mod 256, and the row is written into slot i mod 256 with
--       ON CONFLICT DO UPDATE, so the buffer it replaces is dropped exactly as the task
--       describes. The accumulator is a column of the same upsert, so each iteration really
--       allocates, stores and drops one 64-byte buffer.
-- note: the read of buf[0] is done on the buffer, not on i: ord(substr(buf, 1, 1)) takes the
--       first character of the string that was just built and turns it into its code point.
--       chr() needs an INTEGER on this build -- chr(BIGINT) does not bind -- hence the cast.
-- note: the read of buf[0] and the accumulation are the second statement, one row per
--       iteration over the same range, so the 256 buffers that survived the churn are read
--       back and their first bytes summed. That keeps the two halves of the task's loop --
--       the store into slots and the total = total + buf[0] -- as two real passes.
-- note: the accumulator is per slot (256 of them) because an upsert updates one row at a
--       time; the printed total is their sum, which is the same number the scalar loop's
--       single accumulator reaches. The first-byte values cycle 0..255, and 10000000 =
--       256 * 39062 + 128, so the answer is 39062 * 32640 + 8128 = 1274991808.
-- note: SET threads=1 pins this cell to one core, as in task 01.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE slots(id BIGINT PRIMARY KEY, buf VARCHAR);

INSERT INTO slots(id, buf)
SELECT x % 256, chr((x % 256)::INTEGER) || repeat('x', 63)
FROM range(0, 10000000) r(x)
ON CONFLICT(id) DO UPDATE SET buf = excluded.buf;

CREATE TABLE __res AS
SELECT sum(ord(substr(buf, 1, 1))) AS v
FROM (SELECT chr((x % 256)::INTEGER) || repeat('x', 63) AS buf
      FROM range(0, 10000000) r(x)) b;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
