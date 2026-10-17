{-# LANGUAGE BangPatterns #-}
-- task 15 file_write — expected output: 419430400
-- build: ghc -O2 -threaded -o prog T15_file_write.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- 1 MiB chunks: 50 of them per pass, over 8 passes. Each pass rewrites out.bin from offset
-- 0 (withBinaryFile truncates on open) and flushes; Haskell has no fsync in the standard
-- library, so this row joins the flush-and-close group.

module Main where

import qualified Data.ByteString as B
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.IO (Handle, IOMode (WriteMode), hFlush, stderr, withBinaryFile)
import Text.Printf (hPrintf)

-- The 1 MiB chunk: the bytes 0..255 repeated 4096 times.
chunk :: B.ByteString
chunk = B.concat (replicate 4096 (B.pack [0 .. 255]))

chunkLen :: Int
chunkLen = B.length chunk

main :: IO ()
main = do
  t0 <- getPOSIXTime
  !n <- passes 8 0
  t1 <- getPOSIXTime
  let !ms = (realToFrac (t1 - t0) :: Double) * 1000
  hPrintf stderr "TIME_MS=%.3f\n" ms
  print n

-- One pass: reopen out.bin (withBinaryFile truncates on open), write the 1 MiB
-- chunk 50 times, then flush.
passes :: Int -> Int -> IO Int
passes 0 !w = return w
passes p !w = do
  w' <- withBinaryFile "out.bin" WriteMode (\h -> do
          w'' <- writeChunk h 50 w
          hFlush h
          return w'')
  passes (p - 1) w'

writeChunk :: Handle -> Int -> Int -> IO Int
writeChunk _ 0 !w = return w
writeChunk h k !w = do
  B.hPut h chunk
  writeChunk h (k - 1) (w + chunkLen)
