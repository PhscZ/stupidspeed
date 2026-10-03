{-# LANGUAGE BangPatterns #-}
-- task 08 average — expected output: 0.498046875
-- build: ghc -O2 -threaded -o prog T08_average.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- Double accumulation. Every reading is an exact multiple of 1/256 and the total stays
-- under 2^53, so the sum is exact and the printed digits do not depend on the order of
-- addition.

module Main where

import Data.IORef

main :: IO ()
main = do
  total <- newIORef (0.0 :: Double)
  let go !i
        | i > 99999999 = return ()
        | otherwise = do
            let !r = fromIntegral (i `mod` 256) / 256.0 :: Double
            modifyIORef' total (+ r)
            go (i + 1)
  go 0
  t <- readIORef total
  print (t / 100000000)
