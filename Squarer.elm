module Squarer where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import StartApp


type Model = Up | Right | Down | Left
type Action = TurnLeft | TurnRight

update : Action -> Model -> Model
update action model =
  case action of
    TurnLeft -> case model of
      Up -> Left
      Right -> Up
      Down -> Right
      Left -> Down
    TurnRight -> case model of
      Up -> Right
      Right -> Down
      Down -> Left
      Left -> Up


view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ div [ getStyle model ] [ text (toString model) ]
    , button [ onClick address TurnLeft ] [ text "<-" ]
    , button [ onClick address TurnRight ] [ text "->" ]
    ]


getStyle : Model -> Attribute
getStyle model =
  let deg = case model of
    Up -> "0"
    Right -> "90"
    Down -> "180"
    Left -> "270"
  in style [("transform", "rotate(" ++ deg ++ "deg)")]

main =
  StartApp.start
    { model = Up
    , update = update
    , view = view
    }
