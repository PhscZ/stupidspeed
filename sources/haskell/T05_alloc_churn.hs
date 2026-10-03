{-# LANGUAGE BangPatterns #-}
-- task 05 alloc_churn — expected output: 1274991808
-- build: ghc -O2 -threaded -o prog T05_alloc_churn.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- Ten million short-lived 64-element buffers, each with its first cell set. The `slots`
-- array keeps the buffer reachable, so the one it replaces becomes garbage.

module Main where

import Data.Array.IO
import Data.IORef

main :: IO ()
main = do
  total <- newIORef (0 :: Integer)
  slots <- newArray (0, 255) (0 :: Int) :: IO (IOUArray Int Int)
  let go !i
        | i > 9999999 = return ()
        | otherwise = do
            buf <- newArray (0, 63) (0 :: Int) :: IO (IOUArray Int Int)
            let !v = i `mod` 256
            writeArray buf 0 v
            x <- readArray buf 0
            modifyIORef' total (+ toInteger x)
            writeArray slots (v) x
            go (i + 1)
  go 0
  print =<< readIORef total
