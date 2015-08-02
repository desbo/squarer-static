module Main where

import Preview
import Html exposing (..)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import String exposing (toLower)


type alias Model = {
  rotation: Int,
  preview: Preview.Model
}

type Action
  = TurnLeft
  | TurnRight
  | Upload (Maybe String)
  | None


port imageUpload : Signal String


init : Int -> Model
init x = { rotation = x
         , preview = Preview.init }

initialModel = init 0

update : Action -> Model -> Model
update action model =
  case action of
    TurnLeft  ->  { model | rotation <- model.rotation - 90 }
    TurnRight ->  { model | rotation <- model.rotation + 90 }
    Upload s  ->  { model | preview <- s }
    None      ->    model


view : Signal.Address Action -> Model -> Html
view address model =
  let imageStyle =
    style [("transform", "rotate(" ++ toString model.rotation ++ "deg)")]
  in
    div []
    [
      div [ class "rotator" ]
        [ button [ onClick address TurnLeft ] [ text "<-" ]
        , div [ class "image", imageStyle ] [ Preview.view model.preview ]
        , button [ onClick address TurnRight ] [ text "->" ]
        ]
    ]

main : Signal Html
main =
  let
    actions = Signal.mailbox None

    signals = Signal.merge
      (actions.signal)
      (Signal.map (\s -> Upload (Just s)) imageUpload)

    model = Signal.foldp update initialModel signals

  in
    Signal.map (view actions.address) model
