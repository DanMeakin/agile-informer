module Main exposing (..)

import Html

import Model  exposing (..)
import View   exposing (..)
import Update exposing (..)

main =
  Html.program
    { init          = init
    , update        = update
    , view          = view
    , subscriptions = subscriptions
    }

init : (Model, Cmd Msg)
init =
  0
    ! []

subscriptions : Model -> Sub Msg
subscriptions _ = 
  Sub.none
