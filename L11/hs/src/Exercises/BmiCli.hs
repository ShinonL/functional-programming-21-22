module Exercises.BmiCli where

import System.Environment (getArgs)

main = do
    weightStr:heightStr:_ <- getArgs
    let weight = read weightStr :: Double
    let height = read heightStr :: Double
    let bmi = weight / (height * height)
    putStrLn $ show bmi

