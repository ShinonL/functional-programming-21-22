module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)
import Html.Attributes exposing (default)
import Html.Attributes exposing (href)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
    let
        compareByInterval ev1 ev2 =
            Interval.compare ev1.interval ev2.interval
    in
    events
        |> List.sortWith compareByInterval
    -- Debug.todo "Implement Event.sortByInterval"


view : Event -> Html Never
view event =
    let
        defaultClass = class "event"
        importantClass = class "event-important"
        checkImportant =
            if event.important then
                [ defaultClass, importantClass ]
            else [ defaultClass ]
    in
    div (checkImportant) [
        h2 [ class "event-title" ] [ text event.title ]
    ,   p [ class "event-description" ] [ event.description ]
    ,   div [ class "event-category" ] [ 
            text "Event Category: "
        ,   categoryView event.category 
        ]
    ,   a [ class "event-url", href (Maybe.withDefault "" event.url)] [ text (Maybe.withDefault "" event.url) ] 
    ,   div [ class "event-interval" ] [ Interval.view event.interval ]
    ]
    -- Debug.todo "Implement the Model.Event.view function"
