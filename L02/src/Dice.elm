module Dice exposing (..)

type Die = One | Two | Three | Four | Five | Six

type alias DicePair = { die_1: Die, die_2: Die }
type DicePair_Def = Dice Die Die

luckyRoll: DicePair -> String
luckyRoll dice = 
    if dice.die_1 == Six || dice.die_2 == Six then
        "Lucky"
    else "Meh"