module Exercises where

cycl :: [a] -> [a]
cycl list = list ++ (cycl list)

series :: [[Int]]
series = [1] : (map (\xs -> ((head xs) + 1) : xs) series)