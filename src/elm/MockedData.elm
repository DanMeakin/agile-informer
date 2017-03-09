module MockedData exposing (..)

import Date exposing (Date, fromTime)
import Model exposing (..)
import Time exposing (Time)

{-
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
        
-}

data : Date -> Model
data date = 
  let projects =
        [ project1
        , project2
        , project3 
        ]

  in
      { projects       = projects
      , focusedProject = Nothing
      , currentDate    = date
      }

project1 : Project
project1 =
  let mailbox =
        [ { heading = 
              "Difficulty adopting TDD in team"
          , message = 
              "Hey,\n\nWe are really finding it difficult to do TDD in the \
              \team. Can you help out? Do you know any good ways to get \
              \started?\n\nThanks,\n\nJens"
          , sender = "Jens Jensen"
          , date   = dayOf2017 30
          }
        , { heading = 
              "How much XP should we do?"
          , message = 
              "We don't really know what we should be doing from XP. You said \
              \we could do things like pair programming, TDD, etc. but we \
              \don't know what is best. Can you advise? Thanks!"
          , sender = "Lauren Laird"
          , date   = dayOf2017 33
          }
        , { heading = 
              "PO is useless..."
          , message = 
              "Our PO doesn't know how to do any refinements or grooming, \
              \which is a real problem now. Our backlog is totally chaotic. \
              \Can you help?"
          , sender = "Jemma Smith"
          , date   = dayOf2017 55
          }
        ]

      project =
        { name = 
            "DanFin Transformation"
        , shortDescription = 
            "Transformation process at DanFin. Hybrid Scrum/XP. Commenced \
            \4th April 2016."
        , longDescription = 
            "Longer description of the full details of the transformation \
            \process..."
        , avatar     = { gender = Man, num = 1 }
        , background = NaturalWhite
        , status     = [ Activity Active ]
        , plan       = projectPlan
        , mailbox    = mailbox
        , showView   = Tactics
        }

  in
      project

project2 : Project
project2 =
  let mailbox =
        [ { heading = 
              "Problems with requirements"
          , message = 
              "We keep getting requirements from PMs which they want us to \
              \complete separate from the sprints. I think this is a problem.."
          , sender = "Peter Petersen"
          , date   = dayOf2017 45
          }
        ]

      project =
        { name = 
            "NorDat Scrum Deployment" 
        , shortDescription = 
            "Deployment of Scrum at NorDat. Commenced 12th January 2017."
        , longDescription = 
            "Longer description of the full details of the transformation \
            \process..."
        , avatar     = { gender = Woman, num = 2 }
        , background = Swirls
        , status     = [ Activity Active, PendingReports ]
        , plan       = projectPlan
        , mailbox    = mailbox
        , showView   = Tactics
        }

  in
      project

project3 : Project
project3 =
  let mailbox =
        [ { heading = 
              "How does XP help us??"
          , message = 
              "We don't even make software wtf?!?!?!"
          , sender = "Anna Anorak"
          , date   = dayOf2017 41
          }
        ]

      project =
        { name = 
            "XP Study @ Danske Øl og Vin"
        , shortDescription = 
            "Investigation into usability of XP within a Danish drinks \
            \company. Commenced 10th November 2016; concluded 30th January \
            \2017."
        , longDescription = 
            "Longer description of the full details of the transformation \
            \process..."
        , avatar     = { gender = Man, num = 1 }
        , background = Seigaiha
        , status     = [ Activity Concluded ]
        , plan       = projectPlan
        , mailbox    = mailbox
        , showView   = Tactics
        }

  in
      project

projectPlan : Plan
projectPlan =
  let strategies =
        [ { description = "Emphasise the Product Owner role."
          , tactics     = productOwnerTactics
          }
        , { description = "Address confidence in TDD."
          , tactics     = tddTactics
          }
        ]

      productOwnerTactics =
        [ { title =
              "PO induction & training"
          , description =
              "All POs will be given a full induction and training in their \
              \role within the development. This should be completed ASAP."
          , completionDate = 
              Just <| dayOf2017 30
          , acceptanceCriteria =
              "Full training completed by all POs by completion date."
          , completion = 
              Unsuccessful
          }
        , { title =
              "Discussions with PMs of their roles re requirements"
          , description =
              "Ongoing discussions with PMs to clarify their role in the \
              \requirements process within agile development."
          , completionDate =
              Nothing
          , acceptanceCriteria =
              "PMs not involved in planning product content."
          , completion = 
              Incomplete
          }
        , { title =
              "Promote dev-PO contact"
          , description =
              "Push a common theme in communications to dev team that they \
              \should be contacting the PO regularly about any product issues \
              \or questions."
          , completionDate =
              Nothing
          , acceptanceCriteria =
              "Lack of complaints about product requirements; clarity"
          , completion =
              Incomplete
          }
        , { title =
              "Co-location of POs within teams"
          , description =
              "Some POs can be co-located with development teams. This will \
              \improve the engagement of the team with the PO."
          , completionDate =
              Just <| dayOf2017 35
          , acceptanceCriteria =
              "25% of POs co-located"
          , completion =
              Successful
          }
        , { title =
              "Monitor PO acceptance by teams"
          , description =
              "Obtain metrics of team perception of PO role, their usefulness \
              \over time."
          , completionDate =
              Just <| dayOf2017 160
          , acceptanceCriteria =
              "Positive or very positive perception of PO role within all \
              \Scrum teams"
          , completion =
              Incomplete
          }
        ]

      tddTactics =
        [ { title =
              "Pilot TDD project in Team Α"
          , description =
              "Undertake a pilot TDD project within Team Α. This will involve \
              \the use of TDD for one sprint. (Team Α has the most experienced \
              \agile devs so is the best choice.)"
          , completionDate =
              Just <| dayOf2017 10
          , acceptanceCriteria =
              "Usage of up-front testing within the codebase development; high \
              \levels of test coverage of code developed (90% target)"
          , completion =
              Successful
          }
        , { title =
              "Cascaded introduction of TDD in all teams"
          , description =
              "Introduction of TDD usage within all 10 Scrum teams. This will \
              \be used within one sprint."
          , completionDate =
              Just <| dayOf2017 58
          , acceptanceCriteria =
              "Confident usage of TDD throughout one Sprint (measured in \
              \retrospective); good test coverage of code (80%)"
          , completion =
              Incomplete
          }
        , { title =
              "TDD & tooling training"
          , description =
              "Carry out developer training in TDD practices and supporting \
              \tooling available to them."
          , completionDate =
              Nothing
          , acceptanceCriteria =
              "Will be measured in the rollout of TDD"
          , completion =
              Incomplete
          }
        , { title =
              "Coordinate CI test coverage deployment"
          , description =
              "CI can be used to automatically measure test coverage. Oversee \
              \the rollout of CI test coverage tooling (with rejection on \
              \low coverage code)."
          , completionDate =
              Just <| dayOf2017 100
          , acceptanceCriteria =
              "CI rejects low coverage code (<75%) as if non-compiling"
          , completion =
              Incomplete
          }
        ]

      plan = 
        { goal            = { description = "Complete agile transformation process." }
        , strategies      = strategies
        , focusedStrategy = Nothing
        }

  in
      plan

{-| Return a date value for the nth day of 2017.
-}
dayOf2017 : Int -> Date
dayOf2017 n =
  let oneDay =
        86400000

  in
      start2017 + (toFloat <| n * oneDay)
        |> fromTime

start2017 : Time
start2017 =
  1483228800000
