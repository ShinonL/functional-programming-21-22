# Laboratory 8

### Q 8.3.1
First, `Date.elm` is in laboratory 4

The differences spotted occur to the exporting of the module and the way type annotation is made.

### Q 8.5.1
"otherwise" is a wildcard which catches all the patterns (as "_" did in ELM)

### E 8.8.1
For `fact 10000` the printing took just a bit longer.  
However, for `fact 100000`, computing the result took a lot longer.

### Q 8.13.1

Haskell vs ELM:  
- The list append in ELM is done by ' :: ' while in Haskell, we use ' : '
- Haskell accepts refutable patterns, while ELM does not.
  
Haskell, but not SML:  
- lazy evaluation
- list comprehension
- purity => no side effects
  
SML, but not Haskell:
- type annotations can be embedded in the declaration of the function
- constant declarations with `val`

### E 8.14.1
```
sudan :: Int -> Int -> Int -> Int
sudan 0 x y = x + y
sudan n x 0 = x
sudan n x y = 
    sudan (n-1) s (y + s) where
        s = sudan n x (y - 1)
```

### E 8.14.2
```
infixl 3 !& 
True !& True = False
_ !& _ = True 
```

### E 8.14.3
```
safeHead [] = Nothing
safeHead (x : xs) = Just x

safeTail [] = Nothing
safeTail (x : xs) = Just xs
```

### E 8.14.4
```
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
```

### E 8.14.8
```
fun countChar (c: char) (str: string) =
  length (List.filter (fn x => x = c) (explode str));
```