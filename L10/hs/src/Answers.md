# Laboratory 10

### Q 10.8.1

| Type                                          | Kind                   |
| --------------------------------------------- | ---------------------- |
| data Stuff = Stuff                            | Stuff :: \*            |
| data Option a = None \| Some a                | Option :: _ -> _       |
| data Result err ok = Err err \| Ok ok         | Result :: _ -> _ -> \* |
| data Tree a = Nil \| Node (Tree a) a (Tree a) | Tree :: _ -> _         |
| data Map k v = Map [(k, v)]                   | Map :: _ -> _ -> \*    |

### Q 10.8.2

Yes it has, multiplication and addition are both monoids and semigroups (because a monoid is a semigroup).

### E 10.9.1

Code:

```
data Op = Add | Sub | Mul | Div

instance Show Op where
    show Add = "+"
    show Sub = "-"
    show Mul = "*"
    show Div = "/"
```

Test:

```
Prelude> :l Exercises
[1 of 1] Compiling Exercises        ( Exercises.hs, interpreted )
Ok, one module loaded.
*Exercises> show Add
"+"
*Exercises> show Mul
"*"
*Exercises> show Div
"/"
*Exercises> show Sub
"-"
```

### E 10.9.2

Code:

```
class YesNo a where
    yesNo :: a -> Bool

instance YesNo (Maybe a) where
    yesNo (Just _) = True
    yesNo Nothing = False
```

Test:

```
*Exercises> yesNo (Just 3)
True
*Exercises> yesNo Nothing
False
```

### E 10.9.3

Code:

```
class Container c where
  hasElem :: (Eq a) => c a -> a -> Bool
  nrElems :: c a -> Int

data Tree a = Nil | Node (Tree a) a (Tree a)

instance Container Tree where
    hasElem Nil _ = False
    hasElem (Node leftTree root rightTree) element
        | root == element = True
        | otherwise = (hasElem leftTree element) || (hasElem rightTree element)

    nrElems Nil = 0
    nrElems (Node leftTree _ rightTree) =
        (nrElems leftTree) + 1 + (nrElems rightTree)
```

Test:

```
*Exercises> :l Container
[1 of 1] Compiling Container        ( Container.hs, interpreted )
Ok, one module loaded.
*Container> t = Node (Node Nil 1 Nil) 2 (Node Nil 3 Nil)
*Container> hasElem t 2
True
*Container> hasElem t 3
True
*Container> hasElem t 4
False
*Container> nrElems t
3
```

### E 10.9.4

Code:

```
instance Ord a => Ord (Rev a) where
  compare (Rev a) (Rev b) = compare b a
```

Test:

```
*RevSort L> :l RevSort
[1 of 1] Compiling RevSort          ( RevSort.hs, interpreted )
Ok, one module loaded.
*RevSort L> import qualified Data.List as L
*RevSort L> l = [4, 2, 5, 1, 6]
*RevSort L> L.sort l
[1,2,4,5,6]
*RevSort L> sortRev l
[6,5,4,2,1]
```

### E 10.9.5

Code:

```
instance Graph TupleGraph where
  neighbors a (TupleGraph g) = L.map snd $ L.filter ((== a) . fst) g

instance Graph NeighborListGraph where
  neighbors a (NeighborListGraph g) = snd $ L.head $ L.filter ((== a) . fst) g
```

Test:

```
*Graph L> neighbors "a" tg
["b","c","d"]
*Graph L> neighbors "a" nlg
["b","c","d"]
```

#### E 10.9.5.1

Code:

```

```
