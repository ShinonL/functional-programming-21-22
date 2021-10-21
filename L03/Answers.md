# Laboratory 3

## Type Variables an Constraints

I ran all the given examples.

### Q 3.1.1 
The way I understood these type variables is as a variable similar to the placeholders in the generic type of Java. We know that for example, the type `java.util.List<E>` is a generic type: a list that holds elements of some type represented by the placeholder E. The same could be represented in elm by `List a`.  
The equivalent from C++ is the `template`.

### Q 3.1.2
The placeholders of generic types in Java can be imposed constraints by forcing them to extend a special class. For example, if we wish to make an object whose fields should be compared:  
```class GenricCompare<T extends Comparable>```

In C++, the same constraints for a template could be done like this:
```
template<class T1, class T2> struct Can_Compare {
    static void constraints(T1 a, T2 b) {
        a == b;
        a != b;
        a < b;
    }
    Can_Compare() {
        void (*p) (T1, T2) = constraints;
    }
```

## Equality

I ran all the given examples.

### Q 3.2.1
The floating types have a limited amount of decimals it can hold after the decimal point (the "virgula"). For ELM, that number seems to be 16.  
For the REPL evaluation:

    > (0/0)
    NaN: Float
    > (0/0) == (0/0)
    False: Bool

So, by dividing 0 by 0, we get a "Not a Number" exception. Because of this, the "==" operator cannot compare the results so it would return false.

## Case study: types of error handling

### Q 3.3.1
" While undefined has been in existence since the creation of coding, null is the misguided invention of British computer scientist Tony Hoare (most famous for his Quicksort algorithm) in 1964, who coined his invention of null references as his “billion dollar mistake”. "

### Q 3.3.2
The Null Pointer Exception is a runtime exception in C/C++. THus, we cannot know whether we would encounter this exception just from compiling the project.

### Q 3.3.3
Beside ELM, there is Haskell.
#### String Approach 
+: We can print custom messages for the errors occured  
+: The messages can be detailed  
-: The error propagation has to be checked because the string could be any value  
-: The caller of the function has to process the string in order to handle the error  
  
#### Enum Approach 
+: We can return errors by functions. This cand be done through strings also, but a string can be anything, while the enum error is just the enum pre-defined by us  
+: Errors could be propagated to other functions  
-: The vague details about the error  
-: We have to define a special type for these errors

## Lists

### E 3.4.1
A non-tail recursive approach:
```
len: List Int -> Int
len list = 
  case list of 
    [] -> 0
    _ :: xs -> 1 + len xs
```
A tail recursive approach:
```
lenTail: List Int -> Int -> Int
lenTail list length = 
  case list of 
    [] -> length
    _ :: xs -> lenTail xs (length + 1)
```

### Q 3.4.1
Insert at the biginning (head)  -> O(1)  
Insert at the end (tail)        -> O(n)  
Get the i<sup>th</sup> element  -> O(n)  

### E 3.4.2
For b = 4081, the countFromTo function works  
For b = 4082, the function returns:   
```RangeError: Maximum call stack size exceeded```

### Q 3.4.2
I think the complexity is O(n)
First the ```reverse la``` function which just reverses the ls list, having O(n) complexity.
Then to the resulted list, we apply the appTail function, meaning that we append to a list in antoher O(n) complexity.  

The total is: O(n) + O(n) = O(2n) = O(n)

### E 3.5.1
The function code:
```
> safeDiv : Int -> Int -> Maybe Int
| safeDiv a b =
|   if b == 0 then
|   Nothing
|   else
|   Just (a // b)
|   
<function> : Int -> Int -> Maybe Int
```

The test calls:
```
> safeDiv 4 3
Just 1 : Maybe Int
> safeDiv 4 0
Nothing : Maybe Int
```

### E 3.5.2
Remade the tail rcursive len function:
```
lenTail: List Int -> Int
lenTail list = 
  let
    lenAux l length =
      case l of 
        [] -> length
        _ :: xs -> lenAux xs (length + 1)
  in
    lenAux list 0
```

### E 3.5.3
```
last : List a -> Maybe a
last list =
  case list of
     [] -> Nothing
     x :: [] -> Just x
     _ :: xs -> last xs
```

### E 3.5.4
```
indexList : Int -> List a -> Maybe a
indexList index list =
  case list of
    [] -> Nothing
    x :: xs -> 
      if index == 0 then Just x
      else indexList (index - 1) xs
```

### E 3.5.5
```
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
```

### E 3.5.6
To keep the previous implementation, I made a new function named `fibsTuples`:  
```
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
```

### E 3.5.7
```
cmpShapes : Shape -> Shape -> Result String Order
cmpShapes shape1 shape2 =
  let
    resultShape1 = safeArea shape1
    resultShape2 = safeArea shape2
  in
    case (resultShape1, resultShape2) of
      (Ok res1, Ok res2) ->
        if res1 < res2 then Ok LT
        else if res1 == res2 then Ok EQ
        else Ok GT
      (Err message, _) -> Err ("Invalid input for left shape: " ++ message)
      (_, Err message) -> Err ("Invalid input for right shape: " ++ message)
```

### E 3.5.8
```
totalArea : List Shape -> Result (Int, InvalidShapeError) Float
totalArea list =
  let
    customFilter l area index =
      case l of
         [] ->  Ok area
         (Ok x) :: xs -> customFilter xs (area + x) (index + 1)
         (Err msg) :: xs -> Err (index, msg)
  in 
    customFilter (list |> map (\x -> safeAreaEnum x)) 0 0
```