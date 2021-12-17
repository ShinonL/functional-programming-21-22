module Exercises.PasswordEx where

validCharacters = ['0'..'9'] ++ ['a'..'z'] ++ ['A'..'Z']
passwords :: Int -> [String]
passwords n = sequenceA (replicate n validCharacters)