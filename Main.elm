module Main where

import Html exposing (..)
import Html.Attributes exposing (style, class, src)
import Html.Events exposing (onClick)
import String exposing (toLower)


type alias Image = {
  base64: String,
  width: Int,
  height: Int
}

type alias Model = {
  rotation: Int,
  preview: Maybe Image
}

type Action
  = TurnLeft
  | TurnRight
  | Upload Image
  | None


port imageUpload : Signal Image


init : Int -> Model
init x = { rotation = x
         , preview = Nothing }

initialModel = init 0

update : Action -> Model -> Model
update action model =
  case action of
    TurnLeft  ->  { model | rotation <- model.rotation - 90 }
    TurnRight ->  { model | rotation <- model.rotation + 90 }
    Upload i  ->  { model | rotation <- 0, preview <- Just i }
    None      ->    model


view : Signal.Address Action -> Model -> Html
view address model =
  let
    imageStyle =
      style [
        ("transform", "rotate(" ++ toString model.rotation ++ "deg)")
      ]

    image = case model.preview of
      Just i -> img [ src i.base64 ] []
      Nothing -> div [] []

  in
    div []
    [
      div [ class "rotator" ]
        [ button [ class "btn btn-left", onClick address TurnLeft ] [ ]
        , div [ class "image", imageStyle ] [ image ]
        , button [ class "btn btn-right", onClick address TurnRight ] [ ]
        ]
    ]

main : Signal Html
main =
  let
    actions = Signal.mailbox None

    signals = Signal.merge
      (actions.signal)
      (Signal.map Upload imageUpload)

    model = Signal.foldp update initialModel signals

  in
    Signal.map (view actions.address) model
