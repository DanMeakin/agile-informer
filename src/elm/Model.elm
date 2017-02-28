module Model exposing (..)

-- Model

type alias Model =
  Int

newEntry text id =
  { text = text,
    id = id
  }

type Msg
  = NoOp

