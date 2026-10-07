{-# LANGUAGE BangPatterns #-}
-- task 14 file_read — expected output: 2389704704
-- build: ghc -O2 -threaded -o prog T14_file_read.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- The 50 MiB fixture is read with ByteString, so the bytes are a real contiguous buffer and
-- the scan is an index walk over it.

module Main where

import qualified Data.ByteString as B
import Data.IORef
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.IO (stderr)
import Text.Printf (hPrintf)

main :: IO ()
main = do
  t0 <- getPOSIXTime
  bs <- B.readFile "data.bin"
  tot <- newIORef (0 :: Integer)
  let go !i | i >= B.length bs = return ()
            | otherwise = do
                modifyIORef' tot (\s -> (s + toInteger (B.index bs i)) `mod` 4294967296)
                go (i + 1)
  go 0
  v <- readIORef tot
  t1 <- getPOSIXTime
  let !ms = (realToFrac (t1 - t0) :: Double) * 1000
  hPrintf stderr "TIME_MS=%.3f\n" ms
  print v
