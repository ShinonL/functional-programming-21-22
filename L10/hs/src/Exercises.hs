module Exercises where

data Op = Add | Sub | Mul | Div

instance Show Op where
    show Add = "+"
    show Sub = "-"
    show Mul = "*"
    show Div = "/"

class YesNo a where
    yesNo :: a -> Bool

instance YesNo (Maybe a) where
    yesNo (Just _) = True
    yesNo Nothing = False
