module Main where
import Data.Time
import Lib

f :: Double -> Double
f x = 4*sin(x) + 10

g :: Double -> Double
g x= cos(x)

linear :: Double->Double
linear x=25*x+10

main :: IO ()
main = do
     start <- getCurrentTime
     print (calculate 0 10 0.001 15 f)
     end <- getCurrentTime
     print (diffUTCTime end start)