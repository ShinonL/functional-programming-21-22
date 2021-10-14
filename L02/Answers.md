### Laboratory 2

On my OS, I don't have mush space left and I'mi not using IntelliJ for anything at the moment. That is why I decided to use Visual Studio Code for these laboratories.

At your suggestion, I tried to learn how to use MarkDown for the answers, but I can't figure out how to insert an image saved locally. I hope its okay anyway.

## <span style="color: #6a6a6a"> Ch 2.1 </span>
I ran the example with the Records module.

## <span style="color: #6a6a6a"> Ch 2.2 </span>
I ran the examples with the ELM tuples and records in command line.
Remember: for string concatenation use  ++

### <span style="color: #3f9100"> E 2.2.1 </span>
Copied the give code as requested by the exercise.
In order to get the message "Dr4. Haskell Curry" displayed, I called the function like this:

    > fullTitle { firstName = "Haskel", idDr = True, lstName = "Curry" }

The result was the desired one.
Extra fact learnt: _Bool_ cannot be equal with 0 or 1. It is _True_ or _False_ with caps lock.

## <span style="color: #6a6a6a"> Ch 2.3 </span>
I ran the example with the User type alias.

### <span style="color: #3f9100"> E 2.3.1 </span>
The exercse asks us to call the given fullName function:

**First Call** (_ERROR_)

    > fullName User "Haskell" "Curry"
This call resulted in an error saying that we passed too many arguments to the **`fullName`** function.

**Second Call** (_SUCCESS_)

    > fullName (User "Haskell" "Curry")
The call was a succes because now the arguments are well specified.

### <span style="color: #e07b07"> Q 2.3.1 </span>
For C++ there is

    typedef

### <span style="color: #3f9100"> E 2.3.2 </span>

    > type alias Address = { street: String, number: Int, city: String, country: String }

### <span style="color: #3f9100"> E 2.3.3 </span>

    > formatAddress: Address -> String
    | formatAddress address = address.street ++ " " ++ String.fromInt address.number ++ ", " ++ address.city ++ ", " ++ address.country
    |
</br>

Then I ran the examples given for the type definitions for _Color_ and _Point_. Also, I created the `.elm` files given as examples.

## <span style="color: #6a6a6a"> Ch 2.4 </span>
I ran all the given examples.

## <span style="color: #6a6a6a"> Ch 2.5 </span>
I ran the examples for `Types.elm` and `Shapes.elm`.

### <span style="color: #3f9100"> E 2.5.1 </span>
By removing the line of code

    > _ -> "Better luck next time"
    
and testing the code with the call:

    > numberToMedal 5

The program gave an error specifying **_MISSING PATTERNS_** and it suggests me to add the '_' branch.
That is because it does not find any pattern that marches the given input.

### <span style="color: #3f9100"> E 2.5.2 </span>
By moving the line of code

    > _ -> "Better luck next time"

and testing the new code with the call:

    > numberToMedal 1

I encoutred another error, this time named **_REDUNDANT PATTERN_** refering to the following lines of code.
That is because **`case`** works as a waterfall. It will first chesck if the argument matches the '_' pattern, which means **any pattern**, and it does. So the code won't check the other patterns because it has already found a match.

## <span style="color: #6a6a6a"> Ch 2.6 </span>
Tried the examples.

## <span style="color: #6a6a6a"> Ch 2.7 </span>
### <span style="color: #e07b07"> Q 2.7.1 </span>
The Bool type is a sum type => its cardinality is the number of variants => _The **cardinality of Bool** is 2_.

### <span style="color: #e07b07"> Q 2.7.2 </span>
A way to define `Int` as a sum type is to write all the numbers from -2<sup>31</sup> to 2<sup>31</sup>-1 as in the example:

    type Int = -2147483648 | -2147483647 | -2147483646 | ... | -1 | 0 | 1 | ... | 2147483647

But this means we have to manually write 2<sup>32</sup> numbers which is too much so I'm glad that this type is already defined.

### <span style="color: #e07b07"> Q 2.7.3 </span>
The built in type with cardinality 0 is **Never**.  
The built in type with cardinality 1 is **()**.

## <span style="color: #6a6a6a"> Ch 2.8 </span>
### <span style="color: #3f9100"> E 2.8.1 </span>

    type Die = One | Two | Three | Four | Five | Six

### <span style="color: #3f9100"> E 2.8.2 </span>

    type alias DicePair = { die_1: Die, die_2: Die }
    type DicePair_Def = Dice { die_1: Die, die_2: Die }

### <span style="color: #3f9100"> E 2.8.3 </span>

    luckyRoll: DicePair -> String
    luckyRoll dice = 
        if dice.die_1 == Six || dice.die_2 == Six then
            "Lucky"
        else "Meh"

### <span style="color: #3f9100"> E 2.8.4 </span>

    areaRec: ShapeRec -> Float
    areaRec shape = 
        case shape of
            CircleRec { radius } -> pi * radius * radius
            RectangleRec { width, height } -> width * height
            TriangleRec { sideA, sideB, sideC } -> heron sideA sideB sideC

### <span style="color: #3f9100"> E 2.8.5 </span>
The requested function is written in the `PointInShape.elm` file. There you coulf find the definitions for the 2 requeste types (`Point` and `Shape2D`) and the implementation of the `pointInShape` function. 

The way I thought this function is:  
Based on the type of the shape (circle, rectangle or triangle) choose the propriate way of checking if the given point is inside the shape.

For the **circle**:  
I compute the distance between the point and the center of the circle and check if the distance is smaller than the radius of the circle.

The tests I ran:

    > pointInShape (Point 3 2) (Circle { center = (Point 3 3), radius = 5})
    True : Bool
    > pointInShape (Point 3 2) (Circle { center = (Point 13 13), radius = 5})
    False : Bool

For the **rectangle**:
I simply check that the coordinates of the point are between the the opposite corners of the rectangle.

The tests I ran:

    > pointInShape (Point 3 3) (Rectangle { topLeftCorner = (Point 1 5), bottomRightCorner = (Point 5 0) })
    True : Bool
    > pointInShape (Point 3 3) (Rectangle { topLeftCorner = (Point 1 15), bottomRightCorner = (Point 5 11) }) 
    False : Bool

For the **triangle**:
I use the given formula:
> Area<sub>ABC</sub> == Area<sub>PAB</sub> + Area<sub>PAC</sub> + Area<sub>PBC</sub>

To compute the areas, I use heron's formula. The `heron` function receives the vertices of the triangle and then defines local variables that are given the lengths of the edges. Then the formula is implemented as in the example given in the laboratory.

**Heron Function**

    heron pointA pointB pointC =
        let 
            a = computeDistance pointB pointC
            b = computeDistance pointA pointC
            c = computeDistance pointA pointB
            semiPerimeter = (a + b + c) / 2
        in
            sqrt (semiPerimeter * (semiPerimeter - a) * (semiPerimeter - b) * (semiPerimeter - c))

The tests I ran:

    > pointInShape (Point 13 3) (Triangle { pointA = (Point 1 5), pointB = (Point 5 0), pointC = (Point 5 5)})
    False : Bool
    > pointInShape (Point 3 3) (Triangle { pointA = (Point 1 5), pointB = (Point 5 0), pointC = (Point 5 5)})  
    True : Bool

### <span style="color: #3f9100"> E 2.8.6 </span>
**First Try**:  
Fisrt I tried using lists. I managed to decompose the card number into a list of digits and then convert the said list to an array. However, the `Array get` function returns a `Maybe Int`, a type which can't be used in a sum (+). I aksed the professor for some advice and he suggested either waiting until the next lab to learn more about lists or to try another approach which is not using them. 

I commented the lists code and tried again

**Second Try**  
This time I tried a recursive approach based on the fact that the cardnumber has exactly 16 digits.
For the Luhn's sum computation I start with an 8-digit number and compute the sum recursively starting with a sum of a given value and position.
The recursive call will decide based on the parity of the position whether to double or not the last digit of the number given and then it will call again, but this thime the number lost its last digit and the sum increased with it. This is done until the number is 0.

    computeLuhnSum: Int -> Int -> Int -> Int
    computeLuhnSum number sum position =
        if number == 0 then
            sum
        else if modBy 2 position == 0 then
            computeLuhnSum (number // 10) (sum + doubleDigit (modBy 10 number)) (position - 1)
        else computeLuhnSum (number // 10) (sum + (modBy 10 number)) (position - 1)

Because the credit card number is an 16-digit one, I first compute the sum for the lower part, starting with value 0 and position 15. Then for the higher part I use the previously computed sum (lower part one) and the position 7.

    sum = computeLuhnSum high (computeLuhnSum low 0 15) 7

For the card to be valid, we need this sum to be divisible by 10 and to have a valid INN. So the `isCardNumberValid` function works like this:

    isCardNumberValid: CreditCard -> Bool
    isCardNumberValid card =
        let
            cardNumber = card.cardNumber
            high = cardNumber.high
            low = cardNumber.low
            sum = computeLuhnSum high (computeLuhnSum low 0 15) 7
        in
            (modBy 10 sum == 0) && checkINN card.issuer high

The `checkINN` function:

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

I would love to give you the way I called the function, but I used my real card details. This is a template:

    isCardNumberValid { issuer = <Issuer>, cardNumber = { high = <Int>, low = <Int> }, date = { month = <Int>, year = <Int> } }