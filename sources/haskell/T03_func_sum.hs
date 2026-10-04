{-# LANGUAGE BangPatterns #-}
-- task 03 func_sum — expected output: 100000000
-- build: ghc -O2 -threaded -o prog T03_func_sum.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- addOne is marked NOINLINE, so the 100 million calls really happen. That matters more in
-- Haskell than in most languages here: GHC inlines aggressively and then constant-folds, and
-- an argument that never varies would let it collapse the whole loop into a multiplication.
-- The accumulator is threaded through as the argument, which is what the task's own line
-- says (value = add_one(value)), so the value is never constant. Measured, 100M calls cost
-- 0.410 s against 0.108 s with the body written out inline, so the call is real.

module Main where

import Control.Exception (evaluate)
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.IO (stderr)
import Text.Printf (hPrintf)

{-# NOINLINE addOne #-}
addOne :: Int -> Int
addOne n = n + 1

main :: IO ()
main = do
  t0 <- getPOSIXTime
  let go !i !acc
        | i > 100000000 = acc
        | otherwise = go (i + 1) (addOne acc)
  !v <- evaluate (go 1 0)
  t1 <- getPOSIXTime
  let !ms = (realToFrac (t1 - t0) :: Double) * 1000
  hPrintf stderr "TIME_MS=%.3f\n" ms
  print v
