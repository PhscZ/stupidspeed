-- task 10 pi — expected output: 4470
-- build: none (interpreted)    run: duckdb.exe :memory: ".read 10_pi.sql"
-- timing: the clock is DuckDB's epoch_ms(now()), integer milliseconds, read at the entry of
--         the script's own body into __t0 and again immediately before the final output
--         statement; TIME_MS goes to stderr via .output stderr. The one statement
--         before the timer -- SET threads=1 -- is configuration, the same place the
--         sqlite row's PRAGMA would sit, and is outside the timed region.
-- note: `duckdb.exe -init /dev/null` FAILS on this Windows build, so the run line passes no
--       init file. `.binary on` is mandatory or the CLI CRLF-translates its output; it is
--       re-issued after each .output switch.
-- note: the algorithm is Gibbons' unbounded spigot, the same loop as every other row. It is
--       run in base 10, so the emitted "digits" are single decimal digits and 1000 of them
--       need 4313 steps; the loop below is fixed at 4400 so there is margin, and once the
--       1000th digit is in every remaining step is a no-op. The digit sum is accumulated as
--       the digits come out, so no big number is ever converted to text.
-- note: DuckDB 1.5.6 DOES have an arbitrary-precision type -- VARINT, reported as BIGNUM --
--       and it is used here, but only its `+` and `-` are exact: `*`, `/`, `//` and `%` on
--       VARINT all return DOUBLE (3::VARINT * 7::BIGINT comes back as 8.64e29, a float), so
--       no multiplication or division in this file uses the operator. That is the deviation
--       worth recording: the bignum type is present, its arithmetic is not, so this is the
--       hand-rolled route even though a bignum type exists. Where the sqlite row hand-rolls
--       base-1e9 limbs, this file hands the limbs to the engine and hand-rolls only the two
--       operators, which is why it is shorter.
-- note: `*` is replaced by repeated addition of an exact value, and by double-and-add when
--       the multiplier is a column: x*c for a small constant c is c exact additions
--       (list_sum(list_transform(range(0, c), lambda j: x))), and x*m for a column m walks
--       the 15 bits of m once, doubling the running power and adding it in when the bit is
--       set. Every multiplier the spigot uses is small -- 2, 3, 4, 10, n (< 10), k, l and
--       7k+2, with k reaching 3314 and l 6629 -- so 15 bits covers 7k+2 = 23200 at the top.
-- note: `//` is replaced by greedy subtraction over the powers of two of the divisor, which
--       is a division because both quotients here are known to be small: the emit branch
--       asks for (10*(3q+r))//t, at most 99 over the whole run, and the other branch asks
--       for (q*(7k+2) + r*l)//(t*l), at most 9. Eight bits cover the first, four the second.
-- note: only q, r and t are VARINT; k, l and n stay BIGINT, because in base 10 n is a single
--       digit and k and l are the algorithm's own counters. r is negative on 1895 of the
--       steps, and VARINT is signed, so the subtractions are exact with no sign flag to
--       carry -- unlike the sqlite row, which has to record one.
-- note: the whole spigot is ONE recursive CTE over the step counter, with q, r, t, k, n, l
--       as its columns, so there is no per-step statement and no .read ping-pong. Two
--       DuckDB restrictions shape the text: a recursive CTE may contain only one recursive
--       self-reference (so the two branches of the spigot are a CASE, not two UNION ALL
--       arms), and a lambda body can only see a column that comes from a FROM clause, so
--       the condition is materialised as `c` in the derived table `(SELECT sp.*, ... FROM
--       sp ...)` before the CASEs use it.
-- note: SET threads=1 pins this cell to one core, as in task 01. The recursive CTE is
--       serial anyway, but the flag keeps the row's convention uniform.
.binary on
.mode list
.headers off

SET threads=1;

CREATE TABLE __t0(t BIGINT);
INSERT INTO __t0 VALUES (epoch_ms(now()));

CREATE TABLE __res AS
WITH RECURSIVE sp(step, cnt, s, q, r, t, k, n, l) AS (
    SELECT 0, 0, 0::BIGINT, 1::VARINT, 0::VARINT, 1::VARINT, 1::BIGINT, 3::BIGINT, 3::BIGINT
    UNION ALL
    SELECT z.step + 1,
           z.cnt + CASE WHEN z.c THEN 1 ELSE 0 END,
           z.s + CASE WHEN z.c AND z.cnt < 1000 THEN z.n ELSE 0 END,
           CASE WHEN z.c THEN COALESCE(list_sum(list_transform(range(0, 10), lambda j: q)), 0::VARINT) ELSE list_reduce(list_transform(range(0, 15), lambda b: [b::VARINT, 0::VARINT, 0::VARINT]), lambda acc, e: [acc[1] + CASE WHEN ((k >> (e[1]::BIGINT)) & 1) = 1 THEN acc[2] ELSE 0 END, acc[2] + acc[2], 0::VARINT], [0::VARINT, q, 0::VARINT])[1] END,
           CASE WHEN z.c THEN COALESCE(list_sum(list_transform(range(0, 10), lambda j: (r - COALESCE(list_sum(list_transform(range(0, n), lambda j: t)), 0::VARINT)))), 0::VARINT) ELSE list_reduce(list_transform(range(0, 15), lambda b: [b::VARINT, 0::VARINT, 0::VARINT]), lambda acc, e: [acc[1] + CASE WHEN ((l >> (e[1]::BIGINT)) & 1) = 1 THEN acc[2] ELSE 0 END, acc[2] + acc[2], 0::VARINT], [0::VARINT, (COALESCE(list_sum(list_transform(range(0, 2), lambda j: q)), 0::VARINT) + r), 0::VARINT])[1] END,
           CASE WHEN z.c THEN t ELSE list_reduce(list_transform(range(0, 15), lambda b: [b::VARINT, 0::VARINT, 0::VARINT]), lambda acc, e: [acc[1] + CASE WHEN ((l >> (e[1]::BIGINT)) & 1) = 1 THEN acc[2] ELSE 0 END, acc[2] + acc[2], 0::VARINT], [0::VARINT, t, 0::VARINT])[1] END,
           CASE WHEN z.c THEN k ELSE k + 1 END,
           CASE WHEN z.c THEN (list_reduce(list_reverse(list_reduce(list_transform(range(0, 8), lambda b: [[0::VARINT, 0::VARINT]]), lambda acc, e: list_append(acc, [list_last(acc)[1] + list_last(acc)[1], list_last(acc)[2] + list_last(acc)[2]]), [[t, 1::VARINT]])), lambda acc, e: [acc[1] - CASE WHEN acc[1] >= e[1] THEN e[1] ELSE 0 END, acc[2] + CASE WHEN acc[1] >= e[1] THEN e[2] ELSE 0 END], [COALESCE(list_sum(list_transform(range(0, 10), lambda j: (COALESCE(list_sum(list_transform(range(0, 3), lambda j: q)), 0::VARINT) + r))), 0::VARINT), 0::VARINT])[2] - COALESCE(list_sum(list_transform(range(0, 10), lambda j: n)), 0::VARINT)) ELSE list_reduce(list_reverse(list_reduce(list_transform(range(0, 4), lambda b: [[0::VARINT, 0::VARINT]]), lambda acc, e: list_append(acc, [list_last(acc)[1] + list_last(acc)[1], list_last(acc)[2] + list_last(acc)[2]]), [[list_reduce(list_transform(range(0, 15), lambda b: [b::VARINT, 0::VARINT, 0::VARINT]), lambda acc, e: [acc[1] + CASE WHEN ((l >> (e[1]::BIGINT)) & 1) = 1 THEN acc[2] ELSE 0 END, acc[2] + acc[2], 0::VARINT], [0::VARINT, t, 0::VARINT])[1], 1::VARINT]])), lambda acc, e: [acc[1] - CASE WHEN acc[1] >= e[1] THEN e[1] ELSE 0 END, acc[2] + CASE WHEN acc[1] >= e[1] THEN e[2] ELSE 0 END], [(list_reduce(list_transform(range(0, 15), lambda b: [b::VARINT, 0::VARINT, 0::VARINT]), lambda acc, e: [acc[1] + CASE WHEN ((7*k+2 >> (e[1]::BIGINT)) & 1) = 1 THEN acc[2] ELSE 0 END, acc[2] + acc[2], 0::VARINT], [0::VARINT, q, 0::VARINT])[1] + list_reduce(list_transform(range(0, 15), lambda b: [b::VARINT, 0::VARINT, 0::VARINT]), lambda acc, e: [acc[1] + CASE WHEN ((l >> (e[1]::BIGINT)) & 1) = 1 THEN acc[2] ELSE 0 END, acc[2] + acc[2], 0::VARINT], [0::VARINT, r, 0::VARINT])[1]), 0::VARINT])[2] END,
           CASE WHEN z.c THEN l ELSE l + 2 END
    FROM (SELECT sp.*, (COALESCE(list_sum(list_transform(range(0, 4), lambda j: q)), 0::VARINT) + r - t < COALESCE(list_sum(list_transform(range(0, n), lambda j: t)), 0::VARINT)) AS c FROM sp WHERE step < 4400) z
)
SELECT s AS v FROM sp WHERE step = 4400;

.output stderr
.binary on
SELECT printf('TIME_MS=%d', epoch_ms(now()) - (SELECT t FROM __t0));
.output stdout
.binary on
SELECT v FROM __res;
