module View exposing (..)
  
import Html exposing (..)
import Html.Attributes exposing (..)

import Model exposing (..)

view : Model -> Html Msg
view model =
  let cards =
        [ { avatar = (Man, Av1)
          , background = NaturalWhite
          , heading = "DanFin Transformation"
          , description = "Transformation process at DanFin. Hybrid Scrum/XP. \
                          \Commenced 4th April 2016."
          , status = [ Activity Active ]
          }
        , { avatar = (Woman, Av1)
          , background = Swirls
          , heading = "NorDat Scrum Deployment" 
          , description = "Deployment of Scrum at NorDat. Commenced \
                          \12th January 2017."
          , status = [ Activity Active, PendingReports ]
          }
        ]

      mkCard cd =
        div [ class "small-12 medium-6 columns" ]
          [ projectCard cd ]

  in
      div [ class "row" ] 
        <| List.map mkCard cards

type CardBackground
  = Cork
  | NaturalWhite
  | Seigaiha
  | Swirls
  | Symphony

type alias ProjectCard =
  { avatar      : Avatar
  , background  : CardBackground
  , heading     : String
  , description : String
  , status      : List ProjectStatus
  }

type ProjectStatus
  = Activity Activity
  | PendingReports

type Activity 
  = Active
  | Inactive

-- Avatar 

type alias Avatar
  = (Gender, AvNum)

type Gender
  = Man
  | Woman

type AvNum 
  = Av1
  | Av2
  | Av3

avatar : Avatar -> Html Msg
avatar av =
  div [ avatarClass av ] []

avatarClass : Avatar -> Attribute Msg
avatarClass av =
  let avNumber n =
        case n of
          Av1 ->
            "1"

          Av2 ->
            "2"

          Av3 ->
            "3"

  in
      case av of
        (Man, x) ->
          class <| "float-right avatar man-" ++ avNumber x

        (Woman, y) ->
          class <| "float-right avatar woman-" ++ avNumber y

-- Card

projectCard : ProjectCard -> Html Msg
projectCard card =
  div [ class "card" ]
    [ div [ class "card-divider", cardBackgroundClass card.background ]
        [ div [ avatarClass card.avatar ] []
        , h4 [] [ text card.heading ] 
        ] 
    , div [ class "card-section" ]
        [ text card.description ]
    , div [ class "card-divider" ]
        <| List.map statusLabel card.status
    ]

cardBackgroundClass : CardBackground -> Attribute Msg
cardBackgroundClass background =
  case background of
    Cork ->
      class "cork"

    NaturalWhite ->
      class "natural-white"

    Seigaiha ->
      class "seigaiha"

    Swirls ->
      class "swirls"

    Symphony ->
      class "symphony"

statusLabel : ProjectStatus -> Html Msg
statusLabel status =
  case status of
    PendingReports ->
      span [ class "label warning" ] [ text "Pending Reports" ]

    Activity Active ->
      span [ class "label success" ] [ text "Active" ]

    Activity Inactive ->
      span [ class "label secondary" ] [ text "Inactive" ]
