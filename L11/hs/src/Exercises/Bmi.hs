module Exercises.Bmi where

main = do
    putStrLn "Please enter your weight:"
    weightStr <- getLine
    let weight = read weightStr :: Double
    putStrLn "Please enter your height:"
    heightStr <- getLine 
    let height = read heightStr :: Double
    let bmi = weight / (height * height)
    putStrLn $ "Your BMI is: " ++ (show bmi)