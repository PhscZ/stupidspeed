{-# LANGUAGE BangPatterns #-}
-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: ghc -O2 -threaded -o prog T01_branches.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- The loop is an explicit strict tail recursion, and the four counters are IORefs written
-- with modifyIORef' (the strict form). This is the most procedural shape the language has.

module Main where

import Data.IORef
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.IO (stderr)
import Text.Printf (hPrintf)

main :: IO ()
main = do
  t0 <- getPOSIXTime
  a <- newIORef (0 :: Int)
  b <- newIORef (0 :: Int)
  c <- newIORef (0 :: Int)
  d <- newIORef (0 :: Int)
  let go !i
        | i > 99999999 = return ()
        | otherwise = do
            if i `mod` 3 == 0 then modifyIORef' a (+ 1)
            else if i `mod` 5 == 0 then modifyIORef' b (+ 1)
            else if i `mod` 7 == 0 then modifyIORef' c (+ 1)
            else modifyIORef' d (+ 1)
            go (i + 1)
  go 0
  [va, vb, vc, vd] <- mapM readIORef [a, b, c, d]
  let !out = unwords (map show [va, vb, vc, vd])
  t1 <- getPOSIXTime
  let !ms = (realToFrac (t1 - t0) :: Double) * 1000
  hPrintf stderr "TIME_MS=%.3f\n" ms
  putStrLn out
