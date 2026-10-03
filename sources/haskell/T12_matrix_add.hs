{-# LANGUAGE BangPatterns #-}
-- task 12 matrix_add — expected output: 999000000
-- build: ghc -O2 -threaded -o prog T12_matrix_add.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- Three 1000x1000 matrices as flat mutable arrays indexed i*n+j, which is the layout the
-- C row uses and the one that measures memory bandwidth rather than pointer chasing.

module Main where

import Data.Array.IO
import Data.IORef

main :: IO ()
main = do
  let n = 1000
      size = n * n
  a <- newArray (0, size - 1) (0 :: Int) :: IO (IOUArray Int Int)
  b <- newArray (0, size - 1) (0 :: Int) :: IO (IOUArray Int Int)
  c <- newArray (0, size - 1) (0 :: Int) :: IO (IOUArray Int Int)
  let build !i !j
        | i >= n = return ()
        | j >= n = build (i + 1) 0
        | otherwise = do
            writeArray a (i * n + j) (i + j)
            writeArray b (i * n + j) (i - j)
            build i (j + 1)
  build 0 0
  let add !k | k >= size = return ()
             | otherwise = do
                 x <- readArray a k
                 y <- readArray b k
                 writeArray c k (x + y)
                 add (k + 1)
  add 0
  tot <- newIORef (0 :: Integer)
  let sumAll !k | k >= size = return ()
                | otherwise = do
                    x <- readArray c k
                    modifyIORef' tot (+ toInteger x)
                    sumAll (k + 1)
  sumAll 0
  print =<< readIORef tot
