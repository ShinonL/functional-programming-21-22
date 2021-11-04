module ListsTests exposing (..)

import Expect exposing (Expectation)
import Lists exposing (..)
import Test exposing (..)
import Fuzz exposing (..)
import String exposing (split)

suite : Test
suite =
    describe "Lists module"
    [
        describe "Lists.chunks"
        [
            test "First example" <|
                \_ ->
                    Expect.equal [[1, 2], [3, 4], [5, 6]] <| chunks 2 [1, 2, 3, 4, 5, 6],
            test "Second example" <|
                \_ ->
                    Expect.equal [[1, 2, 3], [4]] <| chunks 3 [1, 2, 3, 4],
            test "Empty List example" <|
                \_ ->
                    Expect.equal [] <| chunks 4 [],
            test "Fourth example" <|
                \_ ->
                    Expect.equal [[1, 2], [3, 4], [5, 6], [7]] <| chunks 2 [1, 2, 3, 4, 5, 6, 7],
            test "Fifth example" <|
                \_ ->
                    Expect.equal [[1]] <| chunks 2 [1]
        ], 
        describe "Lists.splitLast"
        [
            fuzz (list int) "Return a tuple with the list and the last element" <|
                \l ->
                    if l == [] then
                        Expect.equal Nothing <| splitLast l
                    else
                        let
                            listSize = List.length l
                            lastElement = List.head (List.reverse l)
                        in
                            Expect.equal (Just ((List.take (listSize - 1) l), lastElement)) <| splitLast l
        ]
    ]
    