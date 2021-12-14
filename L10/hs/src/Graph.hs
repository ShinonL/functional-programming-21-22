
module Graph where
import Distribution.Simple.Utils (safeHead)
import Data.Maybe (fromMaybe)
import Data.List as L
import Data.Function

g = [
  ("a", "b"), ("a", "c"), ("a", "d"),
  ("b", "e"),
  ("c", "f"),
  ("d", "e"),
  ("e", "f"), ("e", "g")
  ]

g' = [
  ("a", ["b", "c", "d"]),
  ("b", ["e"]),
  ("c", ["f"]),
  ("d", ["e"]),
  ("e", ["f" , "g"])
  ]

tg = TupleGraph g

nlg = NeighborListGraph g'

class Graph g where
  neighbors :: Eq a => a -> g a -> [a]

newtype TupleGraph a = TupleGraph [(a, a)]

newtype NeighborListGraph a = NeighborListGraph [(a, [a])]

instance Graph TupleGraph where
  neighbors a (TupleGraph g) = L.map snd $ L.filter ((== a) . fst) g

instance Graph NeighborListGraph where
  neighbors a (NeighborListGraph g) = snd $ L.head $ L.filter ((== a) . fst) g


-- >>> neighbors "a" nlg
-- ["b","c","d"]

-- >>> neighbors "a" tg
-- ["b","c","d"]

{-
>>> bf "a" tg
["a","b","c","d","e","f","g"]
-}
bf :: (Graph g, Eq a) => a -> g a -> [a]
bf start g = undefined

{-
>>> df "a" tg
["a","b","e","f","g","c","d"]
-}
df :: (Graph g, Eq a) => a -> g a -> [a]
df start g = undefined
