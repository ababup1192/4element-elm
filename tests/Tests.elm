module Tests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (..)
import Test exposing (..)


type alias TestCase =
    String


element2SelectedElementViewModelTest : TestCase -> Element -> SelectedElementViewModel -> Test
element2SelectedElementViewModelTest testCase element selectedElementViewModel =
    test testCase <|
        \_ ->
            let
                actual =
                    element2SelectedElementViewModel element

                expected =
                    selectedElementViewModel
            in
            Expect.equal actual expected


suite : Test
suite =
    describe "The Main module"
        [ describe "element2SelectedElementViewModel"
            -- Nest as many descriptions as you like.
            [ element2SelectedElementViewModelTest
                "火が選択されている！"
                Fire
                (SelectedElementViewModel " selected" "" "" "")
            , element2SelectedElementViewModelTest
                "水が選択されている！"
                Water
                (SelectedElementViewModel "" " selected" "" "")
            ]
        ]
