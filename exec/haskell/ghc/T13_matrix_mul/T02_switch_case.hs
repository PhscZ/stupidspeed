{-# LANGUAGE BangPatterns #-}
-- task 02 switch_case — expected output: 7500000075000000
-- build: ghc -O2 -threaded -o prog T02_switch_case.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- `case` on `i mod 4` is the switch. The accumulator is an Integer, which is arbitrary
-- precision, so the total is exact with no workaround.

module Main where

import Data.IORef
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.IO (stderr)
import Text.Printf (hPrintf)

main :: IO ()
main = do
  t0 <- getPOSIXTime
  acc <- newIORef (0 :: Integer)
  let go !i
        | i > 99999999 = return ()
        | otherwise = do
            let !v = case i `mod` 4 of
                       0 -> 1
                       1 -> toInteger i
                       2 -> 2 * toInteger i
                       _ -> 3 * toInteger i
            modifyIORef' acc (+ v)
            go (i + 1)
  go 0
  v <- readIORef acc
  t1 <- getPOSIXTime
  let !ms = (realToFrac (t1 - t0) :: Double) * 1000
  hPrintf stderr "TIME_MS=%.3f\n" ms
  print v
