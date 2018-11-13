module Main exposing (Element(..), SelectedElementViewModel, element2SelectedElementViewModel)

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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectElement ordinalNum element ->
            case ordinalNum of
                First ->
                    ( { model | firstElement = element }, Cmd.none )

                Second ->
                    ( { model | secondElement = element }, Cmd.none )



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
        , h1 [] [ text "活性" ]
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
        , a [ class <| "element ground" ++ ground, onClick <| SelectElement ordinalNum Ground ] [ text "土" ]
        ]


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
