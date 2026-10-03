{-# LANGUAGE BangPatterns #-}
-- task 06 char_count — expected output: 10000000
-- build: ghc -O2 -threaded -o prog T06_char_count.hs    run: prog
-- Imperative Haskell: mutable state in IORef/IOUArray, strict accumulators (BangPatterns),
-- explicit loops. No foldl, no laziness in any timed path, no list-based text.
-- The 100 MB text is built in one call, so the build is not the benchmark, and the scan
-- walks it one byte at a time.

module Main where

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import Data.Word

main :: IO ()
main = do
  let text = B.concat (replicate 10000000 (BC.pack "abcdefghij"))
      h = 104 :: Word8
  print (B.length (B.filter (== h) text))
