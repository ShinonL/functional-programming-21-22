module Lists exposing (..)
import Html exposing (a)

countFromTo : Int -> Int -> List Int
countFromTo from to =
  if from >= to then
    []
  else
    from :: countFromTo (from + 1) to

sumOfElements : List Int -> Int
sumOfElements list =
  case list of
    [] -> 0
    x::xs -> x + sumOfElements xs

len: List Int -> Int
len list = 
  case list of 
    [] -> 0
    _ :: xs -> 1 + len xs

lenTail: List Int -> Int
lenTail list = 
  let
    lenAux l length =
      case l of 
        [] -> length
        _ :: xs -> lenAux xs (length + 1)
  in
    lenAux list 0

countFromToTail : Int -> Int -> List Int
countFromToTail from to =
  let
    cnt a b acc = 
      if a >= b then
        acc
      else
        cnt a (b - 1) ((b - 1)::acc)
  in
    cnt from to []

append : List a -> List a -> List a
append lx ly =
  case lx of
    [] -> ly
    x::xs -> x :: append xs ly

reverse : List a -> List a
reverse list =
  let
    reverseAcc lx acc = 
      case lx of
        [] -> acc
        x::xs -> reverseAcc xs (x::acc)
  in
    reverseAcc list []

appendTail : List a -> List a -> List a
appendTail la lb =
  let
    appTail lx acc =
      case lx of 
        [] -> acc
        x::xs -> appTail xs (x::acc)
  in
    appTail (reverse la) lb

head : List a -> Maybe a
head list =
  case list of
    [] -> Nothing
    x::_ -> Just x

tail : List a -> Maybe (List a)
tail list =
  case list of
    [] -> Nothing
    _::xs -> Just xs

last : List a -> Maybe a
last list =
  case list of
     [] -> Nothing
     x :: [] -> Just x
     _ :: xs -> last xs

indexList : Int -> List a -> Maybe a
indexList index list =
  case list of
    [] -> Nothing
    x :: xs -> 
      if index == 0 then Just x
      else indexList (index - 1) xs
