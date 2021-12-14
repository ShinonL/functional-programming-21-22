
module RevSort where

import Data.List as L

newtype Rev a = Rev a deriving (Show, Eq)

sortRev :: (Ord a) => [a] -> [a]
sortRev = L.sortOn Rev

instance Ord a => Ord (Rev a) where
  compare (Rev a) (Rev b) = compare b a