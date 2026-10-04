{-# LANGUAGE BangPatterns #-}
-- task 15 file_write — expected output: 52428800
-- build: ghc -O2 -threaded -o prog T15_file_write.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- 1 MiB chunks, 50 of them. ByteString.writeFile flushes and closes on return; Haskell has
-- no fsync in the standard library, so this row joins the flush-and-close group.

module Main where

import Control.Exception (evaluate)
import qualified Data.ByteString as B
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.IO (stderr)
import Text.Printf (hPrintf)

main :: IO ()
main = do
  t0 <- getPOSIXTime
  let unit = B.pack [0 .. 255]
      chunk = B.concat (replicate 4096 unit)
      total = B.concat (replicate 50 chunk)
  B.writeFile "out.bin" total
  !n <- evaluate (B.length total)
  t1 <- getPOSIXTime
  let !ms = (realToFrac (t1 - t0) :: Double) * 1000
  hPrintf stderr "TIME_MS=%.3f\n" ms
  print n
