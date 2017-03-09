module Model exposing (..)

import Date exposing (Date, fromTime)
import Time exposing (Time)

-- Model

type alias Model =
  { projects       : List Project
  , focusedProject : Maybe Project
  , currentDate    : Date
  }

type Msg
  = FocusProject Project
  | UnfocusProject
  | UpdateDate Time
  | FocusStrategy Strategy
  | UnfocusStrategy
  | ShowMailbox
  | CloseMailbox

type alias Project =
  { avatar           : Avatar
  , background       : Background
  , name             : String
  , shortDescription : String
  , longDescription  : String
  , status           : List Status
  , plan             : Plan
  , mailbox          : List Mail
  , showView         : ProjectView
  }

type ProjectView 
  = Tactics
  | Mailbox

type Background
  = Cork
  | NaturalWhite
  | Seigaiha
  | Swirls
  | Symphony

type Status
  = Activity Activity
  | PendingReports

type Activity 
  = Active
  | Inactive
  | Concluded

type Completion
  = Incomplete
  | Unsuccessful
  | Successful

type alias Plan =
  { goal            : Goal
  , strategies      : List Strategy
  , focusedStrategy : Maybe Strategy
  }

tactics : Project -> List Tactic
tactics project =
  List.concatMap .tactics project.plan.strategies
  
isFocussed : Project -> Strategy -> Bool
isFocussed project strategy =
  case project.plan.focusedStrategy of
    Nothing ->
      False
      
    Just s ->
      s == strategy

type alias Goal =
  { description : String
  }

type alias Strategy =
  { description : String
  , tactics     : List Tactic
  }

type alias Tactic =
  { title              : String
  , description        : String
  , completionDate     : Maybe Date
  , acceptanceCriteria : String
  , completion         : Completion
  , tags               : List Tag
  }

type alias Mail =
  { sender  : String
  , heading : String
  , message : String
  , date    : Date
  , tags    : List Tag
  }

type alias Tag =
  String

-- Avatar 

makeAvatar : Gender -> Int -> Maybe Avatar
makeAvatar gender num =
  if List.member num [ 1, 2, 3 ]
    then Just { gender = gender
              , num    = num
              }
    else Nothing

type alias Avatar =
  { gender : Gender
  , num    : Int
  }

type Gender
  = Man
  | Woman
