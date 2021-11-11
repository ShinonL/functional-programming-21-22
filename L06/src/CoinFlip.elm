
module CoinFlip exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type CoinSide
  = Heads
  | Tails

type alias Model =
  { currentFlip : Maybe CoinSide
  , flips: List CoinSide
  }

initModel = Model Nothing []

init : () -> (Model, Cmd Msg)
init _ =
  ( initModel
  , Cmd.none
  )

type Msg
  = Flip Int
  | AddFlip (List CoinSide)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Flip count ->
      ( model
      , Random.generate AddFlip (Random.list count coinFlip)
      )

    AddFlip coins ->
      let
        lastCoin = coins |> List.reverse |> List.head

      in
      ( Model lastCoin (coins ++ model.flips)
      , Cmd.none
      )

coinFlip : Random.Generator CoinSide
coinFlip =
  Random.uniform Heads
    [ Tails ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  let
    currentFlip = 
      model.currentFlip 
      |> Maybe.map viewCoin
      |> Maybe.withDefault (text "Press the flip button to get started")
    flips = 
      model.flips 
      |> List.map coinToString
      |> List.intersperse " "
      |> List.map text
    headsCount = model.flips
      |> List.filter (\x -> x == Heads)
      |> List.length
    tailsCount = model.flips
      |> List.filter (\x -> x == Tails)
      |> List.length
  in
    div []
      [ button [ onClick (Flip 1)] [ text " Flip" ]
      , button [ onClick (Flip 10) ] [ text " Flip 10" ]
      , button [ onClick (Flip 100) ] [ text " Flip 100"]
      , currentFlip
      , div [] [ text ("Heads: " ++ String.fromInt headsCount) ]
      , div [] [ text ("Tails: " ++ String.fromInt tailsCount) ]
      , div [] flips
      ]

coinToString : CoinSide -> String
coinToString coin =
  case coin of
    Heads -> "h"
    Tails -> "t"

viewCoin : CoinSide -> Html Msg
viewCoin coin =
  let
    name = coinToString coin
  in
    div [ style "font-size" "4em" ] [ text name ]

