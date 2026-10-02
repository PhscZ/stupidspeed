-- task 05 alloc_churn — expected output: 1274991808
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 05_alloc_churn.sql"
-- note: the 256-element slots array is a 256-row table with a primary key on the slot
--       index, and one iteration of the loop is one row of the INSERT ... SELECT. The
--       buffer is a 64-byte BLOB built with unhex(), its first byte is i mod 256, and the
--       row is written into slot i mod 256 with an UPSERT, so the buffer it replaces is
--       dropped exactly as the task describes. The accumulator is a column of the same
--       UPSERT, so the whole loop is one statement and each iteration really allocates,
--       stores and drops one 64-byte buffer.
-- note: the read of buf[0] is done on the buffer, not on i: instr() against the 256-byte
--       lookup blob 00 01 02 .. FF returns the byte's value plus one. char() cannot be used
--       instead, because char(0) is the empty string in SQLite and would lose the i = 0
--       buffer's first byte.
-- note: the accumulator is per slot (256 of them) because an UPSERT updates one row at a
--       time; the printed total is their sum, which is the same number the scalar loop's
--       single accumulator reaches.
-- note: the 64-byte buffer is the hex text of its first byte followed by 126 zeros, which
--       unhex() turns into 64 bytes.
CREATE TABLE slots(id INTEGER PRIMARY KEY, buf BLOB, acc INTEGER);
CREATE TABLE lk(b BLOB);
INSERT INTO lk VALUES (unhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F'
                          || '202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F'
                          || '404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F'
                          || '606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F'
                          || '808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9F'
                          || 'A0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBF'
                          || 'C0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF'
                          || 'E0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF'));

INSERT INTO slots(id, buf, acc)
WITH RECURSIVE c(x) AS (
    SELECT 0
    UNION ALL
    SELECT x + 1 FROM c WHERE x < 9999999
)
SELECT x % 256,
       unhex(printf('%02X%0126d', x % 256, 0)),
       instr((SELECT b FROM lk),
             substr(unhex(printf('%02X%0126d', x % 256, 0)), 1, 1)) - 1
FROM c WHERE 1
ON CONFLICT(id) DO UPDATE SET buf = excluded.buf, acc = slots.acc + excluded.acc;

SELECT sum(acc) FROM slots;
