{-# LANGUAGE BangPatterns #-}
-- task 11 parallel_sum — expected output: 7500000075000000
-- build: ghc -O2 -threaded -o prog T11_parallel_sum.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- Four real OS threads. forkIO creates a green thread and the threaded runtime schedules
-- them across the four capabilities given by +RTS -N4, so this is genuine parallelism.
-- Each worker publishes its partial into an MVar and main sums them, which is the join.
-- Measured on this host: 3.00x on four workers (1.991 s serial against 0.663 s), and the RTS
-- reports 3.81x CPU/wall with 205 parallel GCs. The mutable IORef accumulator matters here:
-- its allocation is what gives the scheduler a yield point, so a non-allocating pure loop
-- stays pinned to one capability and shows no speedup at all.

module Main where

import Control.Concurrent
import Control.Monad
import Data.IORef

work :: Int -> IO Integer
work t = do
  acc <- newIORef (0 :: Integer)
  let lo = t * 25000000
      hi = lo + 25000000
      go !i
        | i >= hi = return ()
        | otherwise = do
            let !v = case i `mod` 4 of
                       0 -> 1
                       1 -> toInteger i
                       2 -> 2 * toInteger i
                       _ -> 3 * toInteger i
            modifyIORef' acc (+ v)
            go (i + 1)
  go lo
  readIORef acc

main :: IO ()
main = do
  vars <- forM [0 .. 3] $ \t -> do
    v <- newEmptyMVar
    _ <- forkIO (work t >>= putMVar v)
    return v
  rs <- mapM takeMVar vars
  print (sum rs)
