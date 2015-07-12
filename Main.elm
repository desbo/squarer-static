module Main where

import Preview
import Html exposing (..)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import String exposing (toLower)
import StartApp


type alias Model = {
  rotation: Int,
  preview: Preview.Model
}

type Action
  = TurnLeft
  | TurnRight
  | Upload String


port imageUpload : Signal String


init : Int -> Model
init x = { rotation = x
         , preview = Preview.init }


update : Action -> Model -> Model
update action model =
  case action of
    TurnLeft ->  { model | rotation <- model.rotation - 90 }
    TurnRight -> { model | rotation <- model.rotation + 90 }
    Upload string -> { model | preview <- string }


view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [
    div [ class "rotator" ]
      [ button [ onClick address TurnLeft ] [ text "<-" ]
      , div [ class "image", getStyle model ] [ text "hello" ]
      , button [ onClick address TurnRight ] [ text "->" ]
      ]
  ]


getStyle : Model -> Attribute
getStyle model =
  style [("transform", "rotate(" ++ toString model.rotation ++ "deg)")]

main = StartApp.start
    { model = init 0
    , update = update
    , view = view
    }
