-- task 15 file_write — expected output: 52428800
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 15_file_write.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each .output switch.
-- note: out.bin is written into the working directory, 52428800 bytes: the 1 MiB buffer
--       (bytes 0..255 repeated 4096 times) written 50 times.
-- note: the buffer is built in one set operation, not an append loop: string_agg over
--       range(0,256) produces the 512 hexadecimal characters of bytes 0..255, repeat() makes
--       4096 copies of that 512-character block, and unhex() turns the whole 2097152 hex
--       characters into the 1048576-byte BLOB.
-- note: the 50 chunk writes are the 50 rows of the COPY below: DuckDB's blob format writes
--       each row's value as it comes, so the engine issues fifty writes of the same 1 MiB
--       buffer rather than one 50 MiB write. The printed value is the byte count those fifty
--       chunks add up to; out.bin was verified to be exactly 52428800 bytes on disk.
-- note: the CLI exposes no fsync, and COPY opens the file with truncation, so the commit is
--       the close at the end of the COPY -- this row is in the flush-and-close group, the
--       same deviation the VBScript, JScript, sqlite and gforth rows carry.
-- note: SET threads=1 pins this cell to one core, as in task 01.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE buf AS
SELECT unhex(repeat((SELECT string_agg(printf('%02X', i), '' ORDER BY i)
                     FROM range(0, 256) r(i)), 4096)) AS b;

COPY (SELECT b FROM buf, range(0, 50) r(x)) TO 'out.bin' (FORMAT blob);

CREATE TABLE __res AS
SELECT octet_length(b) * 50 AS v FROM buf;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
