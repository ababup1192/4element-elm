module Tests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "The Main module"
        [ describe "element2SelectedElementViewModel"
            -- Nest as many descriptions as you like.
            [ test "火が選択されている！" <|
                \_ ->
                    let
                        actual =
                            element2SelectedElementViewModel Fire

                        expected =
                            SelectedElementViewModel " selected" "" "" ""
                    in
                    Expect.equal actual expected
            ]
        ]
