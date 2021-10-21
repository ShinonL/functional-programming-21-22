module Fibonacci exposing (..)

fibs : Int -> Int -> List Int
fibs start end =
    let
        fibonacci number =
            if number == 0 || number == 1 then
                1
            else (fibonacci (number - 1) + fibonacci (number - 2))
    in
        if start == end then []
        else (fibonacci start) :: (fibs (start + 1) end)

fibsTuples : Int -> Int -> List (Int, Int)
fibsTuples start end =
    let
        fibonacci number =
            if number == 0 || number == 1 then
                1
            else (fibonacci (number - 1) + fibonacci (number - 2))
    in
        if start == end then []
        else (start, fibonacci start) :: (fibsTuples (start + 1) end)