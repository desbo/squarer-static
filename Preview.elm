module Preview (Model, Action, init, update) where

import Html exposing (..)
import Html.Events exposing (onClick)

type alias Model = String
type Action = Upload

init = "Hello"

update : Action -> Model -> Model
update action model = "tba"
