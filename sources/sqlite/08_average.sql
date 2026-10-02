-- task 08 average — expected output: 0.498046875
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 08_average.sql"
-- note: every reading is a multiple of 1/256, which is exact in binary, and the running
--       total stays below 2^53, so the sum is exact and order-independent. SQLite's sum()
--       accumulates in a 64-bit integer while every value it has seen is an integer, and
--       switches to a double as soon as one is not; here the first value already is not,
--       so the whole accumulation is in double and exact.
-- note: the division by 256.0 forces REAL arithmetic on the reading; an integer division
--       would truncate it to zero.
-- note: the printed form is SQLite's default REAL rendering, which is the shortest form
--       that round-trips, so the expected digits appear exactly.
WITH RECURSIVE c(x) AS (
    SELECT 0
    UNION ALL
    SELECT x + 1 FROM c WHERE x < 99999999
)
SELECT sum((x % 256) / 256.0) / 100000000.0 FROM c;
