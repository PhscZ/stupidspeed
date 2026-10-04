{-# LANGUAGE BangPatterns #-}
-- task 10 pi — expected output: 4470
-- build: ghc -O2 -threaded -o prog T10_pi.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- Haskell's Integer is arbitrary precision, so this is a built-in-bignum cell like
-- Python's rather than a hand-rolled-limb one. Gibbons' unbounded spigot, the same loop
-- every other row runs, with the state threaded through a strict tuple recursion.

module Main where

import Control.Exception (evaluate)
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.IO (stderr)
import Text.Printf (hPrintf)

-- (q, r, t, k, n, l), the spigot state
step :: (Integer, Integer, Integer, Integer, Integer, Integer) -> Bool
step (q, r, t, _, n, _) = 4 * q + r - t < n * t

emit :: (Integer, Integer, Integer, Integer, Integer, Integer)
     -> (Integer, (Integer, Integer, Integer, Integer, Integer, Integer))
emit (q, r, t, k, n, l) =
  (n, (10 * q, 10 * (r - n * t), t, k, (10 * (3 * q + r)) `div` t - 10 * n, l))

advance :: (Integer, Integer, Integer, Integer, Integer, Integer)
        -> (Integer, Integer, Integer, Integer, Integer, Integer)
advance (q, r, t, k, n, l) =
  ( q * k
  , (2 * q + r) * l
  , t * l
  , k + 1
  , (q * (7 * k + 2) + r * l) `div` (t * l)
  , l + 2
  )

spigot :: Int -> Integer
spigot digits = go 0 0 (1, 0, 1, 1, 3, 3)
  where
    go !count !acc st
      | count >= digits = acc
      | step st =
          let (d, st') = emit st
          in go (count + 1) (acc + d) st'
      | otherwise = go count acc (advance st)

main :: IO ()
main = do
  t0 <- getPOSIXTime
  !v <- evaluate (spigot 1000)
  t1 <- getPOSIXTime
  let !ms = (realToFrac (t1 - t0) :: Double) * 1000
  hPrintf stderr "TIME_MS=%.3f\n" ms
  print v
