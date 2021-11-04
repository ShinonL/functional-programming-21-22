
module Exercises exposing (..)

import Theme exposing (ThemeConfig(..))
import List exposing (foldl)

type alias UserDetails = 
  { firstName: String
  , lastName: String
  , phoneNumber: Maybe String
  }
type alias User = {id: String, email: String, details: UserDetails}

makeUser id email firstName lastName phoneNumber = 
  User id email (UserDetails firstName lastName phoneNumber)

usersWithPhoneNumbers : List User -> List String
usersWithPhoneNumbers users = 
  (List.filter (\x -> x.details.phoneNumber /= Nothing) >> List.map (\x -> x.email)) users

type alias AccountConfiguration = 
  { preferredTheme: ThemeConfig
  , subscribedToNewsletter: Bool
  , twoFactorAuthOn: Bool
  }

changePreferenceToDarkTheme : List AccountConfiguration -> List AccountConfiguration
changePreferenceToDarkTheme accounts = 
  accounts |> List.map (\x -> {x | preferredTheme = Dark})

map2 : (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
map2 predicate ma mb =
  case (ma, mb) of
    (Just a, Just b) -> Just (predicate a b)
    (_, _) -> Nothing

countVowels : String -> Int
countVowels str =
  let
      isVowel letter = List.any ((==) letter ) ['a', 'e', 'i', 'o', 'u']
      countList list count = 
        case list of
          [] -> count
          x :: xs -> countList xs (count + 1)
    in
    countList (str |> String.toLower |> String.toList |> List.filter isVowel) 0