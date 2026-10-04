-- task 14 file_read — expected output: 2389704704
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 14_file_read.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each .output switch.
-- note: data.bin must be in the working directory: 52428800 bytes, the bytes 0 through 255
--       repeating. read_blob() reads the whole file as a BLOB, hex() renders it as 100000000
--       hexadecimal characters, and lower() folds it to one case so the nibble lookup below
--       has a single alphabet to match.
-- note: the byte sum is then the sum over the 256 possible byte values of (value x how often
--       it occurs). The occurrences come from one histogram of the 52428800 two-character
--       hex pairs, so the file is walked once and each byte is visited once; the 256
--       histogram entries are then turned back into values with two strpos() lookups each.
-- note: this is the route the row takes because DuckDB has no per-byte accessor at all: it
--       has no byte[] cast, substr()/strpos() refuse BLOB arguments, and its string
--       subscript is not O(1), so a per-byte loop over the blob -- the shape the sqlite row
--       uses -- would be quadratic here. The histogram is the same sum over the same bytes,
--       reached in one pass. Measured: 27-44 s for the whole cell on this host.
-- note: the total is 204800 * 32640 = 6684672000, which is below 2^63, and the printed value
--       is that total mod 4294967296.
-- note: SET threads=1 pins this cell to one core, as in task 01.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE H AS
SELECT lower(hex(content)) AS h FROM read_blob('data.bin');

CREATE TABLE __res AS
WITH p AS (SELECT regexp_extract_all(h, '..') AS pr FROM H),
     hi AS (SELECT list_histogram(pr) AS m FROM p),
     k AS (SELECT unnest(map_keys(m)) AS hx, unnest(map_values(m)) AS cnt FROM hi)
SELECT sum(cnt * ((strpos('0123456789abcdef', substr(hx, 1, 1)) - 1) * 16
                + (strpos('0123456789abcdef', substr(hx, 2, 1)) - 1))) % 4294967296 AS v
FROM k;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
