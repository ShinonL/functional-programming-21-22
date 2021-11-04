# Laboratory 5

### E 5.2.1
'applyTwice f x' applies the same function f two times on x. Meanint that it is equivalent to f(f(x)).
'(inc >> triple) x' is equivalent to triple(inc(x)). First we do the incrementation, then we triple the result.
'applyTwice (inc >> triple) x' is equivalent to triple(inc(triple(inc(x)))).

For 'applyTwice (inc >> triple) 1' first we increment the number 1, giving us 2. Then we triple the result, having a 6. Afer this, we have to reaplly the function, because of the 'applyTwice' function. Which means we increment the 6, giving us a 7, and triple the result, finally getting a 21.

### E 5.2.2
```
all predicate list = list |> List.map (\x -> predicate x) |> List.foldl (\a b -> a && b) True
any predicate list = list |> List.map (\x -> predicate x) |> List.foldl (\a b -> a || b) False
```

### Q 5.2.1
Function composition returns another function. If we compose '(f >> g) x', equivalent to g(f(x)), we can compose rwo functions f: a -> b and g: b -> c. Ths, we construct a new function g(f) : a -> c  
  
Pipeline mostly transfers the result from a function to another, but at the end of the pipwline, a final result is always returned.

### Q 5.2.2
Function composition is recomanded to be used when we wish to define a new function, which we will later use multiple times.  
  
Pipelines are recommened when the composition of functions is used only once, and the focus is on the immediate result given by it.

### Q 5.2.3
'(f >> g) x' could be written like 'x |> f |> g' and the reverse is true.

### E 5.4.1
Code:
```
moveUpdate : ColoredSphere -> Int -> Int -> ColoredSphere
moveUpdate ({center} as sphere) dx dy =
    { sphere 
        | center = 
            { center 
                | x = center.x + dx
                , y = center.y + dy
            }
    }
```
Call:
```
> s = ColoredSphere { x = 1, y=1, z=1 } Red 3
{ center = { x = 1, y = 1, z = 1 }, color = Red, radius = 3 }
    : ColoredSphere
> moveUpdate s 2 2
{ center = { x = 3, y = 3, z = 1 }, color = Red, radius = 3 }
    : ColoredSphere
```

### E 5.5.1
Code:
```
map2 : (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
map2 predicate ma mb =
  case (ma, mb) of
    (Just a, Just b) -> Just (predicate a b)
    (_, _) -> Nothing
```
Calls:
```
> map2 (+) (Just 2) (Just 1)
Just 3 : Maybe number
> map2 (-) (Just 2) (Just 1)
Just 1 : Maybe number
```

### E 5.8.1
Code:
```
countVowels : String -> Int
countVowels str =
    let
        isVowel letter = List.any ((==) letter ) ['a', 'e', 'i', 'o', 'u']
        countList list count = 
            case list of
                [] -> count
                x :: xs -> countList xs (count + 1)   
    in
        countList (str |> String.toLower |> String.toList |> List.filter isVowel) 0
```
Calls:
```
> countVowels "Andreea"
4 : Int
> countVowels "AndreeA"
4 : Int
> countVowels "Andree"
3 : Int
```
Tests:
```
, describe "Exercises.countVowels"
    [
        test "First example" <|
            \_ ->
                Expect.equal 4 <| countVowels "Andreea"
      , test "Second example" <|
            \_ ->
                Expect.equal 5 <| countVowels "AewiOun"
    ]
```

### E 5.8.2
Code:
```
changePreferenceToDarkTheme : List AccountConfiguration -> List AccountConfiguration
changePreferenceToDarkTheme accounts = 
    accounts |> List.map (\x -> {x | preferredTheme = Dark})
```
Tests:
```
describe "Exercises.changePreferenceToDarkTheme"
      [ test "First example" <| 
          \_ -> 
            let 
              config1 = AccountConfiguration Theme.Light True False
              config1Dark = AccountConfiguration Theme.Dark True False
              config2 = AccountConfiguration Theme.Dark False False
              config3 = AccountConfiguration Theme.Dark False True
            in
              Expect.equal [config1Dark, config2, config3] <| changePreferenceToDarkTheme [config1, config2, config3]
      , test "Second example" <| 
          \_ -> 
            let 
              config1 = AccountConfiguration Theme.Light True False
              config1Dark = AccountConfiguration Theme.Dark True False
              config2 = AccountConfiguration Theme.Light False False
              config2Dark = AccountConfiguration Theme.Dark False False
              config3 = AccountConfiguration Theme.Dark False True
            in
              Expect.equal [config1Dark, config2Dark, config3] <| changePreferenceToDarkTheme [config1, config2, config3]
      ]
```

### E 5.8.3
Code:
```
usersWithPhoneNumbers : List User -> List String
usersWithPhoneNumbers users = 
  (List.filter (\x -> x.details.phoneNumber /= Nothing) >> List.map (\x -> x.email)) users
```
Test:
```
describe "Exercises.usersWithPhoneNumbers"
      [ test "First example" <| 
          \_ -> 
            let 
              user1 = makeUser "john00" "johndoe@gmail.com" "John" "Doe" (Just "0123456789")
              user2 = makeUser "jane12" "jane12@yahoo.com" "Jane" "Doe" Nothing
              user3 = makeUser "jacob14" "jacobh@yahoo.com" "Jacob" "Hunt" (Just "345870481")
            in
              Expect.equal [user1.email, user3.email] <| usersWithPhoneNumbers [user1, user2, user3]
      , test "Second example" <| 
          \_ -> 
            let 
              user1 = makeUser "john00" "johndoe@gmail.com" "John" "Doe" (Just "0123456789")
              user2 = makeUser "jane12" "jane12@yahoo.com" "Jane" "Doe" Nothing
              user3 = makeUser "jacob14" "jacobh@yahoo.com" "Jacob" "Hunt" (Just "345870581")
              user4 = makeUser "jacob14" "jacobh@yahoo.com" "Jacob" "Hunt" (Just "345873481")
              user5 = makeUser "jacob14" "jacobh@yahoo.com" "Jaob" "Hunt" Nothing
              user6 = makeUser "jacob14" "jacobh@yahoo.com" "Jacob" "Hunt" Nothing
              user7 = makeUser "jacob14" "jacobh@yahoo.com" "Jacob" "Hunt" (Just "345870481")
            in
              Expect.equal [user1.email, user3.email, user4.email, user7.email] 
                <| usersWithPhoneNumbers [user1, user2, user3, user4, user5, user6, user7]
      ]
```

### E 5.8.4
Created a new test file named `ListsTests.elm` with the following code:
```
module ListsTests exposing (..)

import Expect exposing (Expectation)
import Lists exposing (..)
import Test exposing (..)

suite : Test
suite =
    describe "Lists module"
    [
        describe "Lists.chunks"
        [
            test "First example" <|
                \_ ->
                    Expect.equal [[1, 2], [3, 4], [5, 6]] <| chunks 2 [1, 2, 3, 4, 5, 6],
            test "Second example" <|
                \_ ->
                    Expect.equal [[1, 2, 3], [4]] <| chunks 3 [1, 2, 3, 4],
            test "Empty List example" <|
                \_ ->
                    Expect.equal [] <| chunks 4 [],
            test "Fourth example" <|
                \_ ->
                    Expect.equal [[1, 2], [3, 4], [5, 6], [7]] <| chunks 2 [1, 2, 3, 4, 5, 6, 7],
            test "Fifth example" <|
                \_ ->
                    Expect.equal [[1]] <| chunks 2 [1]
        ]
```

### E 5.8.5
Function code:
```
splitLast : List a -> Maybe (List a, a)
splitLast list =
  case List.reverse list of
    [] -> Nothing
    x :: xs -> Just (List.reverse xs, x)
```