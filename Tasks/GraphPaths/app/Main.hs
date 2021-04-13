module Main where

import Data.Graph
import Data.Array
import Lib

connect x y g = helper x y g [x]
  where
      helper a b g visited
        | a == b    = [[]]
        | otherwise = [(a, c) : path | c <- (g !a), c `notElem` visited, path <- helper c b g (c : visited)]

main :: IO ()
main = do
    let g = buildG (1,6) [(1,2),(2,3),(3,4),(4,5),(2,5)]
    print (connect 1 5 g)