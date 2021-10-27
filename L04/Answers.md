# Laboratory

I ran all the examples of the lab, so I will not specify this aspect for each chapter.

### Q 4.1.1
By declaring the said type as `private`.

### Q 4.4.1
foldl -> the execution finishes when reaching the last element -> Tail recursive  
foldr -> the `op` function is applied only as the stack is emptying -> Non-Tail recursive

### E 4.6.1
```
enumerate: List a -> List (number, a)
enumerate list = 
  let
    enumerateHelper l index acc = 
      case l of
        [] -> acc
        x :: xs -> enumerateHelper xs (index + 1) ((index, x) :: acc)
  in enumerateHelper list 0 []
```

### E 4.6.2
```
repeat : Int -> a -> List a
repeat numberOfRepetitions element =
  case numberOfRepetitions of
    0 -> []
    _ -> element :: repeat (numberOfRepetitions - 1) element
```

### E 4.6.3
```
countVowels : String -> Int
countVowels str = 
    let
      isVowel letter = any ((==) letter ) ['a', 'e', 'i', 'o', 'u']
      countList list count = 
        case list of
          [] -> count
          x :: xs -> countList xs (count + 1)
        
    in
    countList (str |> String.toList |> filter isVowel) 0 
```

### E 4.6.4
```
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
```

### E 4.6.5
```
countriesWithCapital : List(String, String) -> (String -> Bool) -> List String
countriesWithCapital countriesList predicate =
  map (\(country, _) -> country) (filter (\(_, capital) -> predicate capital) countriesList)
```

### E 4.6.6
```
filterMap : (a -> Maybe b) -> List a -> List b 
filterMap function list = 
    case list of 
        [] -> []
        x :: xs -> 
          case function x of
            Nothing -> filterMap function xs
            Just value -> value :: filterMap function xs
```

### E 4.6.7
```
homemadeAll : (a -> Bool) -> List a -> Bool
homemadeAll predicate list = foldl (\a b -> a && b) True (map (\x -> predicate x) list)

homemadeAny : (a -> Bool) -> List a -> Bool
homemadeAny predicate list = foldl (\a b -> a || b) False (map (\x -> predicate x) list)
```

### E 4.6.8
```
chunks : Int -> List a -> List (List a)
chunks size list =
  let
    chunk = List.take size list
  in
    case chunk of
      [] -> []
      listHead -> listHead :: chunks size (List.drop size list)
```

### E 4.6.9
The `isLeapYear` function:
```
isLeapYear : Int -> Bool
isLeapYear year =
  let
    between start end num = (start <= num) && (num <= end)
  in
    if between 1970 3000 year then
      (modBy 4 year == 0) && (modBy 100 year /= 0) || (modBy 400 year == 0)
    else False
```

The `daysInMonth` function suffers the next modifications:  
- The signature becomes: `daysInMonth : Month -> Int -> Int`
- A new parameter is added: `daysInMonth month year`
- The days remain the same, except the ones for the Feb month. This becomes a choice, depending whether the year is a leap year or not: `Feb -> if isLeapYear year then 29 else 28`

### E 4.6.10
```
foldlEnumerate : List a -> List (Int, a)
foldlEnumerate list =
  foldl (\x xs -> (length xs, x) :: xs) [] list |> reverse
```

### E 4.6.11
```
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
```