module Preview (Model, init, view) where

import Html exposing (..)
import Html.Attributes exposing (src)

type alias Model = Maybe String

init = Nothing

view : Model -> Html
view model = case model of
  Just base64 -> img [ src base64 ] []
  Nothing -> div [] []
