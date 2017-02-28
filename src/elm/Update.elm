module Update exposing (..)

import Model exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    NoOp ->
      model
        ! []
