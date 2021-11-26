# Laboratory 9

### Q 9.1.1
Debug.todo

### Q 9.1.2
Exceptions are given through a bottom value.  
Some languages that have exceptions are Java, C#, SML and Python.  

### Q 9.1.3
Exceptions:  
+: we can send custom information about the error  
+: it is faster  
-: its hard too jump through the code to find it  
-: we can forget to catch it  
  
Option / Maybe:  
+: Easy to use  
-: slower  
-: not customizable  

### E 9.4.1
```
Prelude> l = [1, 3..] :: [Int]

Prelude> take 3 (filter (\x -> mod (x - 1) 2 == 0) l)
[1,3,5]

Prelude> :sprint l
l = 1 : 3 : 5 : _
```

### E 9.4.2
```
Prelude> l = [1, 3..] :: [Int]

Prelude> take 3 (filter (\x -> mod (x - 1) 2 == 0) l)
[1,3,5]

Prelude> :sprint l
l = 1 : 3 : 5 : _
```

### E 9.5.1 && E 9.5.2
#### twos
`twos` is a function that appends 2 to the list given by the same function. So it will just make a list where all elements are 2.  
Trace:  
- 2 : 2 : 2 : twos
- 2 : 2 : 2 : 2
- [2,2,2,2]  
  
Test:
```
*Circular> take 10 twos
[2,2,2,2,2,2,2,2,2,2]

*Circular> take 3 twos
[2,2,2]
```
  
'rep' is a function that creates a list where all the elements are the `e` element given as an argument.  
Trace:  
- e : e : e : rep e
- e : e : e : e
- [e,e,e,e]  
  
Test:
```
*Circular> take 3 (rep "test")
["test","test","test"]

*Circular> take 1 (rep "test")
["test"]
```
  
`fibs` creates a list with all Fibonacci numbers.  
Trace:  
-  0:1:(zipWith (+) (0:1:(zipWith (+) fibs (tail fibs)) ) (tail (0:1:(zipWith (+) fibs (tail fibs))) ))
-  0:1:(zipWith (+) (0:1:(zipWith (+) [0, 1] [1])) (tail 0:1:(zipWith (+) [0, 1] [1])) )
-  0:1:(zipWith (+) (0:1:[1]) (tail 0:1:[1])) 
-  0:1:(zipWith (+) [0,1,2] [1,1])
-  0:1:[1,2]
-  [0,1,1,2]  
  
Test:
```
*Circular> take 4 fibs
[0,1,1,2]

*Circular> take 7 fibs
[0,1,1,2,3,5,8]
```
  
`count` is a list in which the elements are incremented one by one with one.  
Trace:  
- 1:(map (+1) 1:(map (+1) 1:(map (+1) count)))
- 1:(map (+1) 1:(map (+1) 1:(map (+1) [1])))
- 1:(map (+1) 1:(map (+1) 1:[2]))
- 1:(map (+1) 1:[2,3])
- 1:[2,3,4]
- [1,2,3,4]  
  
Test:  
```
*Circular> take 4 count
[1,2,3,4]

*Circular> take 10 count
[1,2,3,4,5,6,7,8,9,10]
```
  
`powsOf2` creates a list of powers of 2.  
Trace:  
- 2:(map (*2) 2:(map (*2) 2:(map (*2) 2:(map (*2) powsOf2))))
- 2:(map (*2) 2:(map (*2) 2:(map (*2) 2:(map (*2) 2))))
- 2:(map (*2) 2:(map (*2) 2:(map (*2) 2:[4])))
- 2:(map (*2) 2:(map (*2) 2:[4,8]))
- 2:(map (*2) 2:[4,8,16])
- 2:[4,8,16,32]
- [2,4,8,16,32]  
  
Test:  
```
*Circular> take 5 powsOf2
[2,4,8,16,32]

*Circular> take 3 powsOf2
[2,4,8]
```
  
`oneList` creates a list of lists of 1s where the size of the lists increases by 1.  
Trace:  
- [1]:(map (1:) [1]:(map (1:) [1]:(map (1:) [1]:(map (1:) oneList))))
- [1]:(map (1:) [1]:(map (1:) [1]:(map (1:) [1]:(map (1:) [1]))))
- [1]:(map (1:) [1]:(map (1:) [1]:(map (1:) [1]:[1,1])))
- [1]:(map (1:) [1]:(map (1:) [1]:[[1,1],[1,1,1]]))
- [1]:(map (1:) [1]:[[1,1],[1,1,1],[1,1,1,1]])
- [1]:[[1,1],[1,1,1],[1,1,1,1],[1,1,1,1,1]])
- [ [1], [1,1], [1,1,1], [1,1,1,1], [1,1,1,1,1]]
  
Test:  
```
*Circular> take 5 oneList
[[1],[1,1],[1,1,1],[1,1,1,1],[1,1,1,1,1]]

*Circular> take 3 oneList
[[1],[1,1],[1,1,1]]
```
  
`primes` creates a list of prime numbers.  
Trace:  
- sieve [2..] where sieve (x:xs) = x:sieve [ y | y <- xs, mod y x /= 0]
- 2:sieve [ y | y <- [3..], mod y 2 /= 0]
- 2:sieve [3,5...]
- 2:3:sieve [ y | y <- [5..], mod y 3 /= 0]
- 2:3:sieve [5,7,11, ..]
- 2:3:5:7:11
  
Test:
```
*Circular> take 5 primes
[2,3,5,7,11]

*Circular> take 7 primes
[2,3,5,7,11,13,17]
```

### Q 9.7.1
`take` and `head`  

### E 9.8.1
```
cycl :: [a] -> [a]
cycl list = list ++ (cycl list)
```
  
Test:
```
*Exercises> take 10 (cycl [1, 2, 3])
[1,2,3,1,2,3,1,2,3,1]
```
The result is different from the one given as example in the lab. But I believe that the one in the lab is worng, because it takes only 7 elements.

### E 9.8.2
```
series :: [[Int]]
series = [1] : (map (\xs -> ((head xs) + 1) : xs) series)
```
  
Test:
```
*Exercises> take 3 series
[[1],[2,1],[3,2,1]]

*Exercises> take 6 series
[[1],[2,1],[3,2,1],[4,3,2,1],[5,4,3,2,1],[6,5,4,3,2,1]]
```