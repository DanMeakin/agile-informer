module MockedData exposing (..)

import Date exposing (Date, fromTime)
import Model exposing (..)
import Time exposing (Time)

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
          , tags   = [ "TDD"
                     ]
          }
        , { heading = 
              "How much XP should we do?"
          , message = 
              "We don't really know what we should be doing from XP. You said \
              \we could do things like pair programming, TDD, etc. but we \
              \don't know what is best. Can you advise? Thanks!"
          , sender = "Lauren Laird"
          , date   = dayOf2017 33
          , tags   = [ "XP"
                     , "practice choice"
                     ]
          }
        , { heading = 
              "PO is useless..."
          , message = 
              "Our PO doesn't know how to do any refinements or grooming, \
              \which is a real problem now. Our backlog is totally chaotic. \
              \Can you help?"
          , sender = "Jemma Smith"
          , date   = dayOf2017 55
          , tags   = [ "product owner"
                     , "backlog"
                     , "requirements"
                     ]
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
              \complete separately from the sprints. I think this is a problem.."
          , sender = "Peter Petersen"
          , date   = dayOf2017 45
          , tags   = [ "requirements"
                     , "project manager"
                     , "non-agile"
                     ]
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
          , tags   = [ "XP"
                     , "culture"
                     ]
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
        , avatar     = { gender = Man, num = 3 }
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
          , tags = [ "product owner"
                   , "training"
                   ]
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
          , tags = [ "project manager"
                   , "culture"
                   , "roles"
                   ]
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
          , tags = [ "product owner"
                   , "communication"
                   , "devs"
                   , "roles"
                   ]
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
          , tags = [ "product owner"
                   , "co-location"
                   ]
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
          , tags = [ "product owner"
                   , "teams"
                   , "expectations"
                   ]
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
          , tags = [ "TDD"
                   , "pilot"
                   , "sprint"
                   ]
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
          , tags = [ "TDD"
                   , "sprint"
                   , "rollout"
                   ]
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
          , tags = [ "TDD"
                   , "training"
                   , "tools"
                   ]
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
          , tags = [ "TDD"
                   , "CI"
                   , "tools"
                   , "supervision"
                   ]
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
