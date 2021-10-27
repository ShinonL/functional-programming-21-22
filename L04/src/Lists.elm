module Lists exposing (..)

import Functions exposing (..)
import Html.Attributes exposing (list)
import Html.Events exposing (stopPropagationOn)
import Html exposing (li)
import Html.Attributes exposing (start)
import List exposing (length)
import List exposing (reverse)

take : Int -> List a -> List a
take n l =
  if n <= 0 then
    []
  else
    case l of
      [] -> []
      x::xs -> x :: take (n - 1) xs

drop : Int -> List a -> List a
drop n l =
  if n <= 0 then
    l
  else
    case l of
      [] -> []
      _::xs -> drop (n - 1) xs

checkTakeDrop : Int -> List a -> Bool
checkTakeDrop n l =
  let
    prefix = take n l
    suffix = drop n l
  in
    Debug.todo "Complete this with prefix and suffix and l such that it always returns true"

takeWhile : (a -> Bool) -> List a -> List a
takeWhile p l =
  case l of
    [] -> []
    x::xs -> 
      if p x then
        x :: takeWhile p xs
      else
        []

dropWhile : (a -> Bool) -> List a -> List a
dropWhile p l =
  case l of
    [] -> []
    x::xs -> 
      if p x then
        dropWhile p xs
      else
        x::xs

zip : List a -> List b -> List (a, b)
zip lx ly =
  case (lx, ly) of
    (x::xs, y::ys) -> (x, y)::(zip xs ys)
    _ -> []

unzip : List (a, b) -> (List a, List b)
unzip l =
  case l of
    [] -> ([], [])
    (x, y)::ls -> 
      let
        (xs, ys) = unzip ls
      in
        (x::xs, y::ys)

map : (a -> b) -> List a -> List b
map fn l =
  case l of 
    [] -> []
    x::xs -> (fn x)::map fn xs

filter : (a -> Bool) -> List a -> List a
filter pred l =
  case l of 
    [] -> []
    x::xs -> 
      if (pred x) then
        x::filter pred xs
      else
        filter pred xs

foldr : (a -> b -> b) -> b -> List a -> b
foldr op start l =
  case l of
    [] -> start
    x::xs -> op x (foldr op start xs)

foldl : (a -> b -> b) -> b -> List a -> b
foldl op start l =
  case l of
    [] -> start
    x::xs -> foldl op (op x start) xs


all : (a -> Bool) -> List a -> Bool
all pred l =
  case l of 
    [] -> True
    x::xs -> 
      if pred x then
        all pred xs
      else
        False

any : (a -> Bool) -> List a -> Bool
any pred l =
  case l of
    [] -> False
    x::xs -> 
      if pred x then
        True
      else
        any pred xs

partition : comparable -> List comparable -> (List comparable, List comparable)
partition pivot l = 
  (filter (\x -> x < pivot) l, filter (\x -> x >= pivot) l)

homemadePartition : comparable -> List comparable -> (List comparable, List comparable)
homemadePartition pivot list =
  let
    partitionHelper piv l left right =
      case l of
         [] -> (left, right)
         x :: xs ->
          if x < pivot then
            partitionHelper piv xs (x :: left) right
          else partitionHelper piv xs left (x :: right)
  in partitionHelper pivot list [] []

quicksort : List comparable -> List comparable
quicksort l =
  case l of
    [] -> []
    x::xs -> 
      let
        (less, greater) = homemadePartition x xs
      in
        (quicksort less) ++ [x] ++ (quicksort greater)

enumerate: List a -> List (number, a)
enumerate list = 
  let
    enumerateHelper l index acc = 
      case l of
        [] -> acc
        x :: xs -> enumerateHelper xs (index + 1) ((index, x) :: acc)
  in enumerateHelper list 0 []

repeat : Int -> a -> List a
repeat numberOfRepetitions element =
  case numberOfRepetitions of
    0 -> []
    _ -> element :: repeat (numberOfRepetitions - 1) element

countriesWithCapital : List(String, String) -> (String -> Bool) -> List String
countriesWithCapital countriesList predicate =
  map (\(country, _) -> country) (filter (\(_, capital) -> predicate capital) countriesList)

filterMap : (a -> Maybe b) -> List a -> List b 
filterMap function list = 
    case list of 
        [] -> []
        x :: xs -> 
          case function x of
            Nothing -> filterMap function xs
            Just value -> value :: filterMap function xs

homemadeAll : (a -> Bool) -> List a -> Bool
homemadeAll predicate list = foldl (\a b -> a && b) True (map (\x -> predicate x) list)

homemadeAny : (a -> Bool) -> List a -> Bool
homemadeAny predicate list = foldl (\a b -> a || b) False (map (\x -> predicate x) list)

chunks : Int -> List a -> List (List a)
chunks size list =
  let
    chunk = List.take size list
  in
    case chunk of
      [] -> []
      listHead -> listHead :: chunks size (List.drop size list)

foldlEnumerate : List a -> List (Int, a)
foldlEnumerate list =
  foldl (\x xs -> (length xs, x) :: xs) [] list |> reverse

collect : List (Result err ok) -> Result err (List ok)
collect list =
  let
    helper l acc =
      case l of
        [] -> Ok (acc |> reverse)
        x :: xs -> 
          case x of
             Ok a -> helper xs (a :: acc)
             Err b-> Err b
  in
    helper list []