module Main exposing
    ( Compatibility(..)
    , Element(..)
    , OrdinalNum(..)
    , SelectedElementViewModel
    , element2SelectedElementViewModel
    , twoElements2Compatibility
    , updateElement
    )

import Browser
import Html exposing (Html, a, div, h1, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)



---- MODEL ----


type Element
    = Fire
    | Water
    | Wind
    | Ground


type Compatibility
    = Activity
    | Harmony
    | Freedom
    | Trust
    | Rival
    | Stimulation
    | Inclusion
    | Benefit
    | Symbiosis
    | Release


compatibility2Word : Compatibility -> String
compatibility2Word compatibility =
    case compatibility of
        Activity ->
            "活性"

        Harmony ->
            "調和"

        Freedom ->
            "自由"

        Trust ->
            "信頼"

        Rival ->
            "強敵"

        Stimulation ->
            "刺激"

        Inclusion ->
            "包容"

        Benefit ->
            "恩恵"

        Symbiosis ->
            "共生"

        Release ->
            "解放"


type alias Model =
    { firstElement : Element, secondElement : Element }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { firstElement = Fire, secondElement = Fire }, Cmd.none )



---- UPDATE ----


type OrdinalNum
    = First
    | Second


type Msg
    = SelectElement OrdinalNum Element


updateElement : OrdinalNum -> Element -> Model -> Model
updateElement ordinalNum element model =
    case ordinalNum of
        First ->
            { model | firstElement = element }

        Second ->
            { model | secondElement = element }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectElement ordinalNum element ->
            ( model |> updateElement ordinalNum element, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view { firstElement, secondElement } =
    div [ class "container" ]
        [ div [ class "elements-container" ]
            [ firstElement
                |> element2SelectedElementViewModel
                |> selectedElementViewModel2View First
            , secondElement
                |> element2SelectedElementViewModel
                |> selectedElementViewModel2View Second
            ]
        , h1 [] [ text <| (twoElements2Compatibility firstElement secondElement |> compatibility2Word) ]
        ]


type alias SelectedElementViewModel =
    { fire : String, water : String, wind : String, ground : String }


element2SelectedElementViewModel : Element -> SelectedElementViewModel
element2SelectedElementViewModel element =
    case element of
        Fire ->
            SelectedElementViewModel " selected" "" "" ""

        Water ->
            SelectedElementViewModel "" " selected" "" ""

        Wind ->
            SelectedElementViewModel "" "" " selected" ""

        Ground ->
            SelectedElementViewModel "" "" "" " selected"


selectedElementViewModel2View : OrdinalNum -> SelectedElementViewModel -> Html Msg
selectedElementViewModel2View ordinalNum { fire, water, wind, ground } =
    div [ class "elements" ]
        [ a [ class <| "element fire" ++ fire, onClick <| SelectElement ordinalNum Fire ] [ text "火" ]
        , a [ class <| "element water" ++ water, onClick <| SelectElement ordinalNum Water ] [ text "水" ]
        , a [ class <| "element wind" ++ wind, onClick <| SelectElement ordinalNum Wind ] [ text "風" ]
        , a [ class <| "element ground" ++ ground, onClick <| SelectElement ordinalNum Ground ] [ text "地" ]
        ]


twoElements2Compatibility : Element -> Element -> Compatibility
twoElements2Compatibility element element2 =
    case ( element, element2 ) of
        ( Fire, Fire ) ->
            Activity

        ( Water, Water ) ->
            Harmony

        ( Wind, Wind ) ->
            Freedom

        ( Ground, Ground ) ->
            Trust

        ( Fire, Water ) ->
            Rival

        ( Fire, Wind ) ->
            Stimulation

        ( Fire, Ground ) ->
            Inclusion

        ( Water, Wind ) ->
            Benefit

        ( Water, Ground ) ->
            Symbiosis

        ( Ground, Wind ) ->
            Release

        ( _, _ ) ->
            twoElements2Compatibility element2 element


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
