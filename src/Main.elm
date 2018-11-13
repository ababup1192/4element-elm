module Main exposing (Element(..), SelectedElementViewModel, element2SelectedElementViewModel)

import Browser
import Html exposing (Html, a, div, h1, text)
import Html.Attributes exposing (class, src)



---- MODEL ----


type Element
    = Fire
    | Water
    | Wind
    | Ground


type alias Model =
    {}


init : () -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "elements-container" ]
            [ selectedElementViewModel2View <|
                SelectedElementViewModel " selected" "" "" ""
            , selectedElementViewModel2View <|
                SelectedElementViewModel " selected" "" "" ""
            ]
        , h1 [] [ text "活性" ]
        ]


type alias SelectedElementViewModel =
    { fire : String, water : String, wind : String, ground : String }


element2SelectedElementViewModel : Element -> SelectedElementViewModel
element2SelectedElementViewModel element =
    SelectedElementViewModel " selected" "" "" ""


selectedElementViewModel2View : SelectedElementViewModel -> Html Msg
selectedElementViewModel2View { fire, water, wind, ground } =
    div [ class "elements" ]
        [ a [ class <| "element fire" ++ fire ] [ text "火" ]
        , a [ class <| "element water" ++ water ] [ text "水" ]
        , a [ class <| "element wind" ++ wind ] [ text "風" ]
        , a [ class <| "element ground" ++ ground ] [ text "土" ]
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
