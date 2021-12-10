
module Container where

class Container c where
  hasElem :: (Eq a) => c a -> a -> Bool
  nrElems :: c a -> Int

instance Container Maybe where
  hasElem (Just x) e = x == e
  hasElem _ _ = False

  nrElems (Just _) = 1
  nrElems _ = 0

instance Container [] where
  hasElem l e = elem e l

  nrElems l = length l

data Tree a = Nil | Node (Tree a) a (Tree a)

instance Container Tree where
    hasElem Nil _ = False
    hasElem (Node leftTree root rightTree) element 
        | root == element = True
        | otherwise = (hasElem leftTree element) || (hasElem rightTree element)

    nrElems Nil = 0
    nrElems (Node leftTree _ rightTree) =
        (nrElems leftTree) + 1 + (nrElems rightTree)