module Main exposing (..)

import Date exposing (fromTime)
import Html
import Time

import MockedData
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
  MockedData.data (fromTime 1)
    ! []

subscriptions : Model -> Sub Msg
subscriptions model = 
  Time.every Time.second UpdateDate
