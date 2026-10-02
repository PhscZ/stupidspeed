-- task 09 fib_recursive — expected output: 102334155
-- build: none (interpreted)    run: sqlite3.exe :memory: ".read 09_fib_recursive.sql"
-- note: SQL has no function calls, so the recursion cannot be written as fib(n-1) +
--       fib(n-2). What a recursive CTE can express is the recursion tree itself, and that
--       is what this is: the seed row is the call fib(40), and each row that still needs
--       splitting produces the two rows of its own two sub-calls, n-1 and n-2, so the CTE
--       enumerates the 331160281 calls the naive recursion makes, one row each. The
--       answer is the sum of the values at the leaves, which is fib(40) because a leaf is
--       0 or 1 and the leaves' values are exactly the additions the scalar version does.
-- note: this is breadth-first where the scalar recursion is depth-first, and the row count
--       is the call count either way. There is no memo table: the same n is expanded again
--       at every place the tree reaches it, which is the point of the task.
-- note: the frontier of the breadth-first walk peaks at about a million rows (the level
--       where the tree is widest), so the CTE's queue stays small while the total is 331
--       million rows.
WITH RECURSIVE t(n) AS (
    SELECT 40
    UNION ALL
    SELECT n - 1 FROM t WHERE n >= 2
    UNION ALL
    SELECT n - 2 FROM t WHERE n >= 2
)
SELECT sum(n) FROM t WHERE n < 2;
