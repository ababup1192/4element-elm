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
                "地が選択されている！"
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
            , twoElements2CompatibilityTest
                "風と風で、自由だ！"
                Wind
                Wind
                Freedom
            , twoElements2CompatibilityTest
                "土と土で、信頼だ！"
                Ground
                Ground
                Trust
            , twoElements2CompatibilityTest
                "火と水で、強敵だ！"
                Fire
                Water
                Rival
            , twoElements2CompatibilityTest
                "火と風で、刺激だ！"
                Fire
                Wind
                Stimulation
            , twoElements2CompatibilityTest
                "火と地で、包容だ！"
                Fire
                Ground
                Inclusion
            , twoElements2CompatibilityTest
                "水と風で、恩恵だ！"
                Water
                Wind
                Benefit
            , twoElements2CompatibilityTest
                "水と地で、共生だ！"
                Water
                Ground
                Symbiosis
            , twoElements2CompatibilityTest
                "地と風で、解放だ！"
                Ground
                Wind
                Release
            , test "最初と2つ目の元素が火のとき、最初に水を入れられたら、最初が水で2つ目が火になる。" <|
                \_ ->
                    let
                        actual =
                            updateElement First Water { firstElement = Fire, secondElement = Fire }

                        expected =
                            { firstElement = Water, secondElement = Fire }
                    in
                    Expect.equal actual expected
            , test "最初と2つ目の元素が火のとき、2つ目に風を入れられたら、最初が火で2つ目が風になる。" <|
                \_ ->
                    let
                        actual =
                            updateElement Second Wind { firstElement = Fire, secondElement = Wind }

                        expected =
                            { firstElement = Fire, secondElement = Wind }
                    in
                    Expect.equal actual expected
            ]
        ]
