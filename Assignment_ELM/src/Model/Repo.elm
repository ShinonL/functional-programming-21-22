module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, hidden)
import Json.Decode as Dec


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
    div [ class "repo" ] [
        div [ class "repo-name repo-url" ] [ 
            a [ href repo.url] [text repo.name ] 
        ]
    ,   span [ class "repo-stars" ] [ text ("Stars: " ++ String.fromInt repo.stars) ]
    ,   p [ class "repo-description" ] [ text (Maybe.withDefault "" repo.description) ]
    ]


sortByStars : List Repo -> List Repo
sortByStars repos =
    repos |> (List.sortBy .stars >> List.reverse)
    -- repos 
    --     |> List.sortBy .stars
    --     |> List.reverse


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : Dec.Decoder Repo
decodeRepo =
    Dec.map5 Repo
        (Dec.field "full_name" Dec.string)
        (Dec.maybe (Dec.field "description" Dec.string))
        (Dec.field "html_url" Dec.string)
        (Dec.field "pushed_at" Dec.string)
        (Dec.field "stargazers_count" Dec.int)
    -- Debug.todo "Implement Model.Repo.decodeRepo"
