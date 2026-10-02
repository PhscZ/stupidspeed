-- task 06 char_count — expected output: 10000000
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 06_char_count.sql"
-- note: the text is 100000000 characters: "abcdefghij" repeated 10000000 times, built in
--       one set operation as the task asks -- hex(zeroblob(10000000)) is 20000000 hex
--       pairs "00", and replacing every one of them with the ten-character block gives the
--       whole text at once, with no append loop.
-- note: the scan is one character per iteration of the counter CTE, over a BLOB copy of
--       the text. That matters: substr() on a TEXT value has to walk the UTF-8 from the
--       start to find the nth character, so a per-character scan would be quadratic; on a
--       BLOB it is a byte offset. The text is pure ASCII, so one byte is one character,
--       and the character is compared against the one-byte blob x'68' ('h').
-- note: a string literal would be compared as TEXT, and in SQLite every BLOB sorts before
--       every TEXT value, so the comparison has to be blob against blob.
CREATE TABLE txt(t BLOB);
INSERT INTO txt VALUES (CAST(replace(hex(zeroblob(10000000)), '00', 'abcdefghij') AS BLOB));

WITH RECURSIVE c(i) AS (
    SELECT 1
    UNION ALL
    SELECT i + 1 FROM c WHERE i < 100000000
)
SELECT sum(substr((SELECT t FROM txt), i, 1) = x'68') FROM c;
