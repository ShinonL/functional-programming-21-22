module Types exposing (..)

-- Person Section
type Person =  Person String String

type alias PersonRec = { firstName: String, lastName: String }

fullName: Person -> String
fullName (Person firstName lastName) = firstName ++ " " ++ lastName

fullNameLetIn: Person -> String
fullNameLetIn person =
    let (Person firstName lastName) = person
    in firstName ++ " " ++ lastName

fullNameRec: PersonRec -> String
fullNameRec { firstName, lastName } = firstName ++ " " ++ lastName

greet: Person -> String
greet (Person firstName _ ) = "Hello, " ++ firstName

greetRec: PersonRec -> String
greetRec { firstName } = "Hello, " ++ firstName


-- Color Section
type Color = Red | Green | Blue

colorToHexString: Color -> String
colorToHexString color = 
    case color of
        Red -> "FF0000"
        Green -> "00FF00"
        Blue -> "0000FF"


-- Medal Section
numberToMedal: Int -> String
numberToMedal n =
    case n of
        1 -> "Gold"
        2 -> "Silver"
        3 -> "Bronze"
        _ -> "Better luck next time"


-- Weather Section
type WeatherConditions = WeatherConditions { windSpeed: Int, cloudLayer: Int }

launchCommit : WeatherConditions -> (String, Bool)
launchCommit (WeatherConditions {windSpeed, cloudLayer}) =
    case (windSpeed < 61, cloudLayer < 1400) of
        (True, True) -> ("Launch can proceed", True)
        (False, True) -> ("Wind speeds are too high", False)
        (True, False) -> ("Cloud layer is too thick", False)
        (_, _) -> ("Suboptimal conditions", False)