{-# LANGUAGE BangPatterns #-}
-- task 13 matrix_mul — expected output: 599995000
-- build: ghc -O2 -threaded -o prog T13_matrix_mul.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- The plain triple loop over flat 500x500 arrays, no reordering and no blocking.

module Main where

import Data.Array.IO
import Data.IORef

main :: IO ()
main = do
  let n = 500
      size = n * n
  a <- newArray (0, size - 1) (0 :: Int) :: IO (IOUArray Int Int)
  b <- newArray (0, size - 1) (0 :: Int) :: IO (IOUArray Int Int)
  c <- newArray (0, size - 1) (0 :: Int) :: IO (IOUArray Int Int)
  let build !i !j
        | i >= n = return ()
        | j >= n = build (i + 1) 0
        | otherwise = do
            writeArray a (i * n + j) ((i + j) `mod` 7)
            writeArray b (i * n + j) ((i * j) `mod` 5)
            build i (j + 1)
  build 0 0
  let mul !i !j
        | i >= n = return ()
        | j >= n = mul (i + 1) 0
        | otherwise = do
            acc <- newIORef (0 :: Int)
            let inner !k | k >= n = return ()
                         | otherwise = do
                             x <- readArray a (i * n + k)
                             y <- readArray b (k * n + j)
                             modifyIORef' acc (+ x * y)
                             inner (k + 1)
            inner 0
            writeArray c (i * n + j) =<< readIORef acc
            mul i (j + 1)
  mul 0 0
  tot <- newIORef (0 :: Integer)
  let sumAll !k | k >= size = return ()
                | otherwise = do
                    x <- readArray c k
                    modifyIORef' tot (+ toInteger x)
                    sumAll (k + 1)
  sumAll 0
  print =<< readIORef tot
