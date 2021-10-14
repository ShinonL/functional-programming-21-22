module Cards exposing (..)

import Array exposing (..)

type alias Date = { month: Int, year: Int }
type alias CardNumber = { high: Int, low: Int }
type Issuer = Visa | Mastercard
type alias CreditCard = { issuer: Issuer, cardNumber: CardNumber, date: Date }

isDateAfter: Date -> Date -> Bool
isDateAfter referenceDate date =
    if validateDate referenceDate && validateDate date then
        if referenceDate.year < date.year then 
            True
        else if referenceDate.year == date.year && referenceDate.month < date.month then
            True
        else False
    else False

validateDate: Date -> Bool
validateDate date =
    if date.month < 1 || date.month > 12 then 
        False
    else if date.year < 2021 then
        False
    else True

isCardNumberValid: CreditCard -> Bool
isCardNumberValid card =
    let
        cardNumber = card.cardNumber
        high = cardNumber.high
        low = cardNumber.low
        sum = computeLuhnSum high (computeLuhnSum low 0 15) 7
    in
        (modBy 10 sum == 0) && checkINN card.issuer high

computeLuhnSum: Int -> Int -> Int -> Int
computeLuhnSum number sum position =
    if number == 0 then
        sum
    else if modBy 2 position == 0 then
        computeLuhnSum (number // 10) (sum + doubleDigit (modBy 10 number)) (position - 1)
    else computeLuhnSum (number // 10) (sum + (modBy 10 number)) (position - 1)

doubleDigit: Int -> Int
doubleDigit digit = 
    let 
        newDigit = digit * 2
    in
        if newDigit > 9 then
            newDigit - 9
        else newDigit

checkINN: Issuer -> Int -> Bool
checkINN issuer high =
    let
        firstDigit = high // 10000000
        fourDigits = high // 10000
        twoDigits = high // 1000000
    in
        if issuer == Visa then
            firstDigit == 4
        else if issuer == Mastercard then
            (fourDigits >= 2221 && fourDigits <= 2720) || (twoDigits >= 51 && twoDigits <= 55)
        else False


{- Varianta cu lista - Unfinished
isCardNumberValid: CardNumber -> Bool
isCardNumberValid cardNumber = 
    let
        high = cardNumber.high
        low = cardNumber.low
        digitsList = (toDigits high []) ++ (toDigits low [])
    in
        checkLuhn digitsList 0 15

checkLuhn: List Int -> Int -> Int -> Bool
checkLuhn digitsList sum position =
    let
        digitsArray = (fromList digitsList)
        current = get position digitsArray
    in 
        if modBy 2 position == 1 then
            checkLuhn digitsList (sum + current) (position - 1)
        else checkLuhn digitsList (doubleDigit current) (position - 1)

toDigits: Int -> List Int -> List Int
toDigits number list = 
    let
        digit = (modBy 10 number)
        newList = digit :: list
    in
        if number == 0 then
            List.drop 1 newList
        else toDigits (number // 10) newList
-}