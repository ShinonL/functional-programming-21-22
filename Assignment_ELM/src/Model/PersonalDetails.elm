module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, width, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
    div [] [
        h1 [ id "name" ] [ text details.name ]
    ,   em [ id "intro" ] [ text details.intro ]
    ,   div [ class "contact-detail" ] (
            h3 [] [ text "Contact Details"]
            :: List.map (\contact ->
                div [] [
                    span [] [ text (contact.name ++ " ") ]
                ,   span [] [ text contact.detail ]
                ]
            ) details.contacts
        )
    ,   div [ class "social-link" ] (
            h3 [] [ text "Social Links"]
            :: List.map (\social ->
                div [] [
                    a [ href social.detail ] [ text social.name ]
                ]
            ) details.socials
        )
    ]
    -- Debug.todo "Implement the Model.PersonalDetails.view function"
