module Main exposing (..)

import Html.Attributes as Html
import Html.Events as Html
import Html exposing (Html, text)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { msgs : List Msg
    }


defaultModel : Model
defaultModel =
    { msgs = []
    }


type Msg
    = Foo
    | Bar


init : ( Model, Cmd Msg )
init =
    ( defaultModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( { model | msgs = msg :: model.msgs }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div
        [ Html.style
            [ ( "font-size", "2rem" )
            , ( "padding", "48px" )
            ]
        ]
        [
          Html.button
              [ Html.onClick Foo
              , Html.onClick Bar
              ]
              [ text "Send"
              ]
        ,
          Html.div
              [ Html.style
                   [ ( "display", "flex" )
                   , ( "flex-flow", "column" )
                   ]
              ]
              [ text "Messages:"
              ]
        ,
          Html.div
              [ Html.style
                    [ ( "overflow-y", "auto" )
                    , ( "max-height", "600px" )
                    ]
              ]
              ( List.map (\ msg ->
                        Html.div [] [ text (toString msg) ]
                    )
                    model.msgs
              )
        ]
