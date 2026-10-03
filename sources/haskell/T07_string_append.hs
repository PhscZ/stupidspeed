{-# LANGUAGE BangPatterns #-}
-- task 07 string_append — expected output: 250000
-- build: ghc -O2 -threaded -o prog T07_string_append.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- The accumulator is a ByteString, not a String. That is the honest choice for this task:
-- a Haskell String is a linked list of characters, so `++` on it is quadratic with a
-- per-character pointer chase, and at 250000 appends it does not finish in any useful time.
-- ByteString's append copies the whole accumulator into a fresh buffer on every step, which
-- is exactly the quadratic copy the task exists to measure, at memcpy speed. Measured, 250000
-- appends take about 5 s. Text gives the same shape at about 6 s.

module Main where

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import Data.IORef

main :: IO ()
main = do
  s <- newIORef B.empty
  let go !i | i > 250000 = return ()
            | otherwise = do
                modifyIORef' s (`B.append` BC.pack "x")
                go (i + 1)
  go 1
  print . B.length =<< readIORef s
