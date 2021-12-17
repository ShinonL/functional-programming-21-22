module Exercises.TreeEx where

data Tree a = Nil | Node (Tree a) a (Tree a) deriving (Show)

instance Functor Tree where
    fmap _ Nil = Nil
    fmap func (Node leftTree root rightTree) = Node (fmap func leftTree) (func root) (fmap func rightTree)