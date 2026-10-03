{-# LANGUAGE BangPatterns #-}
-- task 09 fib_recursive — expected output: 102334155
-- build: ghc -O2 -threaded -o prog T09_fib_recursive.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- Naive recursion, about 331 million calls. fib is deliberately not marked NOINLINE: the
-- two recursive calls cannot be folded, so the call path is exercised either way.

module Main where

fib :: Int -> Int
fib n | n < 2 = n
      | otherwise = fib (n - 1) + fib (n - 2)

main :: IO ()
main = print (fib 40)
