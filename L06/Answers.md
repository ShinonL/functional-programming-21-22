# Laboratory 6

### E 6.2.1
This exercise was done in the video given. I just modified the placement of the methods list because the given example in the video made the methods to be inside the h3 tag and I removed them from it.
```
recipeView : Recipe -> Html msg
recipeView recipe = div [] 
  ([ h1 [ style "font-family" "arial" ] 
    [ a 
      [ href recipe.linkToOriginal ]
      [ text recipe.title ]
    ]
  , h3 [] [ i [] [ text "Ingredients:" ]]
  , ul [] ( List.map (\x -> li [] [ text x ]) recipe.ingredients )
  , h3 [] [ i [] [ text "Method:" ]] 
  ] ++ ( List.map (\x ->  p [] [ text x ]) recipe.method ))
  ]
```

### E 6.2.2
```
view : Model -> Html Msg
view model =
  let
    bigFont = style "font-size" "20pt"
  in
    div []
      [ button [ bigFont, onClick Increment, disabled (model >= 10) ] [ text "+" ]
      , div [ bigFont ] [ text (String.fromInt model) ]
      , button [ bigFont, onClick Decrement, disabled (model <= -10) ] [ text "-" ]
      ]
```

### E 6.4.1
```
initialViewTest : Test
initialViewTest = 
    test "The initial value should contain the default text" <|
        \_ -> CoinFlip.view CoinFlip.initModel
            |> Q.fromHtml
            |> Q.has [S.text ("Press the flip button to get started")]
```

### E 6.4.2
The modification occurs here:  
``` ( List.map (\x -> li [class "ingredient"] [ text x ]) recipe.ingredients ) ```

### Q 6.5.1
The three components of the ELM architecture are:  
- model
- update
- view

### Q 6.5.2
We can use commands to execute operations that may cause side effects, while simple messages do not.

### Q 6.5.3
1: give the command to the ELM Runtime  
2: receive a message containing the result

### E 6.6.1
#### Method 1 - Compute the values from the flips field of the Model each time in the view
The new view function:
```
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
      [ button [ onClick Flip ] [ text "Flip" ]
      , currentFlip
      , div [] [ text ("Heads: " ++ String.fromInt headsCount) ]
      , div [] [ text ("Tails: " ++ String.fromInt tailsCount) ]
      , div [] flips
      ]
```

#### Method 2 - Keep the number in the Model and simply display it in the view
The new Model:
```
type alias Model =
  { currentFlip : Maybe CoinSide
  , flips: List CoinSide
  , headsCount: Int
  , tailsCount: Int
  }
```

The new initModel:
``` initModel = Model Nothing [] 0 0 ```

The update function using progressive increment for the count values:
```
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Flip ->
      ( model
      , Random.generate AddFlip coinFlip
      )

    AddFlip coin ->
      let
        isHeads coinSide = coinSide == Heads 
        headsInc m c = if isHeads c then m.headsCount + 1 else m.headsCount
        tailsInc m c = if isHeads c then m.tailsCount else m.tailsCount + 1
      in
      ( Model (Just coin) (coin::model.flips) (headsInc model coin) (tailsInc model coin)
      , Cmd.none
      )
```

The new view:
```
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
  in
    div []
      [ button [ onClick Flip ] [ text "Flip" ]
      , currentFlip
      , div [] [ text ("Heads: " ++ String.fromInt model.headsCount) ]
      , div [] [ text ("Tails: " ++ String.fromInt model.tailsCount) ]
      , div [] flips
      ]
```

### E 6.6.2
The modification applies to the initialization function:
```
init : () -> (Model, Cmd Msg)
init _ =
  ( initModel
  , Random.generate AddFlip coinFlip
  )
```
Before proceeding to the default case, we give the initializer a command to generate a random flip.

### E 6.6.3
The ELM RUntime msg is modified: 
```
type Msg
  = Flip Int
  | AddFlip (List CoinSide)
```

The new update function:
```
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
```

The new view buttons:
```
    div []
      [ button [ onClick (Flip 1)] [ text " Flip" ]
      , button [ onClick (Flip 10) ] [ text " Flip 10" ]
      , button [ onClick (Flip 100) ] [ text " Flip 100"]
      , currentFlip
      , div [] [ text ("Heads: " ++ String.fromInt headsCount) ]
      , div [] [ text ("Tails: " ++ String.fromInt tailsCount) ]
      , div [] flips
      ]
```