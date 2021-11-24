module Exercises where

import Data.Char

sudan :: Int -> Int -> Int -> Int
sudan 0 x y = x + y
sudan n x 0 = x
sudan n x y = 
    sudan (n-1) s (y + s) where
        s = sudan n x (y - 1)

infixl 3 !& 
True !& True = False
_ !& _ = True

average :: [Int] -> Float
average list = listSum / listLength where
    listSum = fromIntegral (sum list)
    listLength = fromIntegral (length list)

countVowels :: String -> Int
countVowels str = 
    let 
        isVowel letter = any ((==) ( toLower letter) ) ['a', 'e', 'i', 'o', 'u']
        count array = 
            case array of
                [] -> 0
                x:xs -> 1 + count xs
    in
     count (filter isVowel str)