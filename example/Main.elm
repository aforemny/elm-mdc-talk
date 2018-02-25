module Main exposing (..)

import Html.Attributes as Html
import Html exposing (Html, text)
import Material
import Material.Button as Button
import Material.Options as Options

main : Program Never Model Msg
main =
    Html.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }


type alias Model =
    { mdl : Material.Model
    , count : Int
    }


defaultModel : Model
defaultModel =
    { mdl = Material.defaultModel
    , count = 0
    }


type Msg
    = Mdl (Material.Msg Msg)
    | Increment
    | Decrement


init : ( Model, Cmd Msg )
init =
    ( defaultModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions =
    Material.subscriptions Mdl


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div
        [ Html.style
              [ ( "display", "flex" )
              , ( "padding", "48px" )
              ]
        ]
        [
          Button.render Mdl [0] model.mdl
              [ Button.ripple
              , Button.stroked
              , Options.onClick Decrement
              ]
              [ text "Decrement"
              ]
        ,
          Html.span
              [ Html.style
                    [ ( "font-size", "1.75rem" )
                    , ( "margin", "0 2rem" )
                    ]
              ]
              [ text (toString model.count)
              ]
        ,
          Button.render Mdl [1] model.mdl
              [ Button.ripple
              , Button.stroked
              , Options.onClick Increment
              ]
              [ text "Increment"
              ]
        ]
        |> Material.top
