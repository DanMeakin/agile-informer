module Model exposing (..)

import Date exposing (Date, fromTime)
import Time exposing (Time)

-- Model

type alias Model =
  { projects       : List Project
  , focusedProject : Maybe Project
  , currentDate    : Date
  }

mockedModel : Date -> Model
mockedModel date = 
  let feb5th =
        1486252800000

      oneDay =
        86400000

      tacticDescriptions =
        [ "Do this particular thing."
        , "Make this happen."
        , "Work with this individual."
        , "Another tactic."
        , "More specific explanation of what we will do here."
        ]

      tactics =
        List.map (\n -> { title = "Tactic " ++ toString n
                        , description = Maybe.withDefault "" 
                                          <| List.head 
                                          <| List.drop (rem n 5) tacticDescriptions
                        , completionDate = if (rem n 12) > 8
                                             then Nothing
                                             else Just << fromTime << toFloat <| feb5th + oneDay * 7 * (rem n 10)
                        , acceptanceCriteria = "Measure against ..." 
                        , success = case (rem n 10) of
                                      1 ->
                                        Just Successful

                                      2 ->
                                        Just Unsuccessful

                                      _ ->
                                        Nothing
                        })
          <| List.range 1 20
        
      plans =
        List.repeat 3 
          { goal = { description = "Complete agile transformation process." }
          , strategies = [ { description = "Deal with cultural issues."
                           , tactics = List.take 10 tactics 
                           }
                         , { description = "Address confidence in TDD" 
                           , tactics = List.take 10 <| List.drop 10 tactics
                           }
                         ]
          , tactics = tactics
          , focusedStrategy = Nothing
          }
      
      partProjects =
        [ \ps -> { avatar = { gender = Man, num = 1 }
                 , background = NaturalWhite
                 , name = "DanFin Transformation"
                 , shortDescription = "Transformation process at DanFin. Hybrid Scrum/XP. \
                                       \Commenced 4th April 2016."
                 , longDescription = "Longer description of the full details of the \
                                     \transformation process..."
                 , status  = [ Activity Active ]
                 , plan    = ps
                 , mailbox = [ { sender = "Jens Jensen"
                               , heading = "Difficulty adopting TDD in team"
                               , message = "Hey,\n\nWe are really finding it \
                                           \difficult to do TDD in the team. Can \
                                           \you help out? Do you know any good \
                                           \ways to get started?\n\nThanks,\n\nJens"
                               , date = fromTime << toFloat <| feb5th - 5 * oneDay
                               }
                             , { sender = "Lauren Laird"
                               , heading = "How much XP should we do?"
                               , message = "We don't really know what we should \
                                           \be doing from XP. You said we could \
                                           \do things like pair programming, TDD, \
                                           \etc. but we don't know what is best. \
                                           \Can you advise? Thanks!"
                               , date = fromTime << toFloat <| feb5th - 2 * oneDay
                               }
                             , { sender = "Jemma Smith"
                               , heading = "PO is useless..."
                               , message = "Our PO doesn't know how to do any \
                                           \refinements or grooming, which is \
                                           \a realy problem now. Our backlog is \
                                           \totally chaotic. Can you help?"
                               , date = fromTime << toFloat <| feb5th + 17 * oneDay
                               }
                             ]
                 , showView = Tactics
                 }
        , \ps -> { avatar = { gender = Woman, num = 2 }
                 , background = Swirls
                 , name = "NorDat Scrum Deployment" 
                 , shortDescription = "Deployment of Scrum at NorDat. Commenced \
                                      \12th January 2017."
                 , longDescription = "Longer description of the full details of the \
                                     \transformation process..."
                 , status = [ Activity Active, PendingReports ]
                 , plan = ps
                 , mailbox = [ { sender = "Peter Petersen"
                               , heading = "Problems with requirements"
                               , message = "We keep getting requirements from PMs \
                                           \which they want us to complete separate \
                                           \from the sprints."
                               , date = fromTime << toFloat <| feb5th + 10 * oneDay
                               }
                             ]
                 , showView = Tactics
                 }
        , \ps -> { avatar = { gender = Woman, num = 3 }
                 , background = Seigaiha
                 , name = "XP Study @ Danske Øl og Vin"
                 , shortDescription = "Investigation into usability of XP within a \
                                      \Danish drinks company. Commenced 10th November \
                                      \2016; concluded 30th January 2017."
                 , longDescription = "Longer description of the full details of the \
                                     \transformation process..."
                 , status = [ Activity Concluded ]
                 , plan = ps
                 , mailbox = [ { sender = "Anna Anorak"
                               , heading = "How does XP help us??"
                               , message = "We don't even make software wtf?!?!?!"
                               , date = fromTime << toFloat <| feb5th + 13 * oneDay
                               }
                             ]
                 , showView = Tactics
                 }
        ]

      projects =
        List.map2 (\proj plan -> proj plan) partProjects plans

  in
      { projects       = projects
      , focusedProject = Nothing
      , currentDate    = date
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
  = Unsuccessful
  | Successful

type alias Plan =
  { goal            : Goal
  , strategies      : List Strategy
  , tactics         : List Tactic
  , focusedStrategy : Maybe Strategy
  }
  
isFocussed : Project -> Strategy -> Bool
isFocussed project strategy =
  case project.plan.focusedStrategy of
    Nothing ->
      False
      
    Just s ->
      s == strategy

type alias Mail =
  { sender  : String
  , heading : String
  , message : String
  , date    : Date
  }

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
  , success            : Maybe Completion
  }

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
