{-# LANGUAGE BangPatterns #-}
-- task 04 array_sum — expected output: 499999500000
-- build: ghc -O2 -threaded -o prog T04_array_sum.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- A mutable unboxed array (IOUArray), filled and then read back one element at a time.
-- An IOUArray of Int is a real contiguous block of machine words, so this measures the same
-- thing the C row's int array does.

module Main where

import Data.Array.IO
import Data.IORef

main :: IO ()
main = do
  arr <- newArray (0, 999999) (0 :: Int) :: IO (IOUArray Int Int)
  let fill !i | i > 999999 = return ()
              | otherwise = writeArray arr i i >> fill (i + 1)
  fill 0
  tot <- newIORef (0 :: Integer)
  let readBack !i | i > 999999 = return ()
                  | otherwise = do
                      x <- readArray arr i
                      modifyIORef' tot (+ toInteger x)
                      readBack (i + 1)
  readBack 0
  print =<< readIORef tot
