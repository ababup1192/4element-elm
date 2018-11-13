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


twoElements2CompatibilityTest : TestCase -> Element -> Element -> Compatibility -> Test
twoElements2CompatibilityTest testCase element element2 compatibility =
    test testCase <|
        \_ ->
            let
                actual =
                    twoElements2Compatibility element element2

                expected =
                    compatibility
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
            , element2SelectedElementViewModelTest
                "風が選択されている！"
                Wind
                (SelectedElementViewModel "" "" " selected" "")
            , element2SelectedElementViewModelTest
                "土が選択されている！"
                Ground
                (SelectedElementViewModel "" "" "" " selected")
            , twoElements2CompatibilityTest
                "火と火で、活性だ！"
                Fire
                Fire
                Activity
            , twoElements2CompatibilityTest
                "水と水で、調和だ！"
                Water
                Water
                Harmony
            ]
        ]
