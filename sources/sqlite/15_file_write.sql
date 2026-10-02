-- task 15 file_write — expected output: 52428800
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 15_file_write.sql"
-- note: out.bin is written into the working directory, 52428800 bytes: the 1 MiB buffer
--       (bytes 0..255 repeated 4096 times) written 50 times.
-- note: the buffer is built in one set operation: hex(zeroblob(4096)) is 4096 "00" pairs
--       and each one is replaced by the 512 hex digits of bytes 0..255, which is the block
--       repeat the task asks for rather than an append loop.
-- note: the fifty writes are the recursive CTE below, which appends the buffer to the
--       output value fifty times. The CLI's writefile() has no append mode -- it opens the
--       file with truncation and writes the whole value, and the third (offset) argument
--       this build accepts is ignored -- so the fifty chunks are assembled in memory and
--       handed over in one call, and the number printed is writefile()'s own return value,
--       the byte count, 52428800.
-- note: writefile() fwrite()s and fclose()s the file. The CLI exposes no fsync, so the
--       commit is the close, the same deviation the VBScript and JScript rows carry.
CREATE TABLE buf(b BLOB);
INSERT INTO buf VALUES (unhex(replace(hex(zeroblob(4096)), '00',
    '000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F'
 || '202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F'
 || '404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F'
 || '606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F'
 || '808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9F'
 || 'A0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBF'
 || 'C0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF'
 || 'E0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF')));

WITH RECURSIVE c(n, s) AS (
    SELECT 0, x''
    UNION ALL
    SELECT n + 1, s || (SELECT b FROM buf) FROM c WHERE n < 50
)
SELECT writefile('out.bin', s) FROM c WHERE n = 50;
