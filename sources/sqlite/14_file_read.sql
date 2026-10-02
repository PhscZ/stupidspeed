-- task 14 file_read — expected output: 2389704704
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 14_file_read.sql"
-- note: data.bin must be in the working directory: 52428800 bytes, the bytes 0 through 255
--       repeating. readfile() returns the whole file as a BLOB, and the scan then reads it
--       one byte per iteration of the counter CTE, exactly as the task describes.
-- note: the byte is turned into its value with instr() against the 256-byte lookup blob
--       00 01 02 .. FF, which returns the value plus one. hex() would need two more
--       function calls per byte and CAST(blob AS INTEGER) reads a blob as text, which is
--       not the byte value.
-- note: substr() on a BLOB is a byte offset, so the per-byte walk is linear; on a TEXT
--       value it would have to scan the UTF-8 from the start for every byte, which is
--       quadratic. The file is not valid UTF-8, so it could not be TEXT anyway.
-- note: the byte total is 204800 * 32640 = 6684672000, which is below 2^63, and the
--       printed value is that total mod 4294967296.
CREATE TABLE f(d BLOB);
INSERT INTO f VALUES (readfile('data.bin'));
CREATE TABLE lk(b BLOB);
INSERT INTO lk VALUES (unhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F'
                          || '202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F'
                          || '404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F'
                          || '606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F'
                          || '808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9F'
                          || 'A0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBF'
                          || 'C0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF'
                          || 'E0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF'));

WITH RECURSIVE c(i) AS (
    SELECT 1
    UNION ALL
    SELECT i + 1 FROM c WHERE i < 52428800
)
SELECT sum(instr((SELECT b FROM lk), substr((SELECT d FROM f), i, 1)) - 1) % 4294967296
FROM c;
