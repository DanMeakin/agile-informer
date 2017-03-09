module View exposing (..)
  
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)

view : Model -> Html Msg
view model =
  let (header, viewComponent) =
        case model.focusedProject of
          Just prj ->
            (smallHeader prj, projectBody model.currentDate prj)

          Nothing ->
            (largeHeader, landingBody model)

  in
      body [] 
        [ header
        , viewComponent
        ]

landingBody : Model -> Html Msg
landingBody model =
  div [ class "row columns" ]
    [ allCards model ]

projectBody : Date -> Project -> Html Msg
projectBody today project =
  div [ id "body-container", class "expanded row" ]
    [ div [ id "sidebar", class "small-12 medium-2 columns" ]
        [ sidebar project ]
    , div [ id "project-inner", class "small-12 medium-10 columns" ]
        [ projectInner today project
        ]
    ]

--------------------------------------------------------------------------------

smallHeader : Project -> Html Msg
smallHeader prj =
  let projectTitle project =
        h1 [] [ text project.name ]

  in
      div [ id "header-container", class "expanded row columns logo-container align-right align-middle clearfix" ]
        [ div [ class "float-left" ]
            [ button [ type_ "button", class "hollow button yellow", onClick UnfocusProject ] 
                [ text "« Back to Projects" ]
            ]
        , div [ class "float-center project-title" ]
            [ projectTitle prj ]
        , div [ class "float-right" ]
            [ div [ id "small-logo", class "logo align-right" ]
              [ div [ class "logo-the float-left" ]  [ text "The" ]
              , div [ class "logo-agile-informer float-right" ] [ text "Agile Informer" ]
              ]
            ]
        ]

largeHeader : Html Msg
largeHeader =
  div [ id "header-container", class "expanded row align-center align-middle" ]
    [ div [ class "logo-container medium-8 columns clearfix" ]
        [ div [ id "main-logo", class "logo align-center" ]
          [ div [ class "logo-the float-left" ]  [ text "The" ]
          , div [ class "logo-agile-informer float-right" ] [ text "Agile Informer" ]
          ]
        ]
    ]
  
--------------------------------------------------------------------------------

sidebar : Project -> Html Msg
sidebar project =
  let stratAttrs strategy =
        if isFocussed project strategy
          then [ class "strategy focused-strategy", onClick UnfocusStrategy ]
          else [ class "strategy", onClick <| FocusStrategy strategy ]

      mkStrategy strategy =
        li (stratAttrs strategy)
          [ h5 [] [ text "Strategy" ]
          , ul [ class "nested vertical menu" ]
              [ li [ class "strategy-text" ] [ text strategy.description ] 
              ]
          ]

      navLink =
        case project.showView of
          Mailbox ->
            button [ type_ "button", class "hollow button yellow", onClick CloseMailbox ] 
                [ text "Close Mailbox" 
                ]

          Tactics ->
            button [ type_ "button", class "hollow button yellow", onClick ShowMailbox ] 
                [ span [ class "badge yellow" ] 
                    [ text << toString <| List.length project.mailbox
                    ] 
                , text " Mailbox" 
                ]
  in
      div []
        [ navLink
        , br [ class "spacer" ] []
        , ul [ class "vertical menu" ]
            <| [ li [ class "goal" ] 
                  [ h4 [] [ text "Goal" ]
                  , ul [ class "nested vertical menu" ]
                      [ li [ class "goal-text" ] [ text project.plan.goal.description ]
                      ]
                  ]
               ] ++ List.map mkStrategy project.plan.strategies
        ]

--------------------------------------------------------------------------------

projectInner : Date -> Project -> Html Msg
projectInner today project =
  case project.showView of
    Tactics ->
      tacticsView today project

    Mailbox ->
      mailboxView today project

tacticsView : Date -> Project -> Html Msg
tacticsView today project =
  let allTactics =
        case project.plan.focusedStrategy of
          Just strat ->
            strat.tactics
            
          Nothing ->
            tactics project

      noCompletionDate t =
        t.completionDate == Nothing && t.completion == Incomplete

      futureCompletionDate t =
        case t.completionDate of
          Nothing ->
            False

          Just d ->
            toTime d > toTime today

      awaitingAssessment t =
        case t.completionDate of
          Nothing ->
            False

          Just d ->
            toTime d <= toTime today && t.completion == Incomplete

      complete t =
        t.completion /= Incomplete

      tacticsNoDate =
        List.filter noCompletionDate allTactics

      tacticsOngoing =
        List.filter futureCompletionDate allTactics

      tacticsAwaitingAssessment =
        List.filter awaitingAssessment allTactics

      tacticsComplete =
        List.filter complete allTactics

      label t =
        case t.completion of
          Successful ->
            div [ class "label success" ] [ text "Successful" ]

          Unsuccessful ->
            div [ class "label warning" ] [ text "Unsuccessful" ]

          Incomplete ->
            case t.completionDate of
              Just d ->
                let dateString =
                  String.join " " [ toString <| dayOfWeek d
                                  , " "
                                  , toString <| day d
                                  , " " 
                                  , toString <| month d
                                  , " "
                                  , toString <| year d
                                  ]
                in
                    if toTime d < toTime today
                      then div [ class "label alert" ] [ text <| "Overdue: " ++ dateString ]
                      else div [ class "label primary" ] [ text <| "Due: " ++ dateString ]

              Nothing ->
                div [ class "label secondary" ] [ text "On hold" ]

      tacticCard t =
        div [ class "card tactic" ]
          [ div [ class "card-divider heading", cardBackgroundClass project.background ]
              [ text t.title ]
          , div [ class "card-section" ]
              [ text t.description 
              ]
          , div [ class "card-section" ]
              [ small []
                  [ strong [] [ text "Acceptance: " ]
                  , text t.acceptanceCriteria
                  ]
              ]
          , div [ class "card-section" ]
              <| List.map tag t.tags
          , div [ class "card-divider", cardBackgroundClass project.background ]
              [ label t ]
          ]

      tacticColumn heading tactics =
        div [ class "tactic-column" ]
          <| (h3 [ class "tactic-header" ]
              [ text heading ])
              :: List.map tacticCard tactics

  in
      div [ class "row tactics-columns" ] 
        [ div [ class "small-3 columns" ]
            [ tacticColumn "Todo" tacticsNoDate ]
        , div [ class "small-3 columns" ]
            [ tacticColumn "Ongoing" tacticsOngoing ]
        , div [ class "small-3 columns" ]
            [ tacticColumn "Overdue" tacticsAwaitingAssessment ]
        , div [ class "small-3 columns" ]
            [ tacticColumn "Complete" tacticsComplete ]
        ]

mailboxView : Date -> Project -> Html Msg
mailboxView today project =
  let mailMessage msg =
        div [ class "small-12 columns card" ]
          [ div [ class "row" ] 
              [ div [ class "small-4 columns" ]
                  [ div [ class "row columns" ]
                      [ text msg.sender 
                      ]
                  , div [ class "row columns" ]
                      [ text <| showDate msg.date 
                      ]
                  , div [ class "row columns align-left" ]
                      [ tags msg ]
                  ]
              , div [ class "small-8 columns" ]
                  [ div [ class "row columns" ]
                      [ strong [] [ text msg.heading ] 
                      ]
                  , div [ class "row columns" ]
                      [ text msg.message 
                      ]
                  , div [ class "row columns align-right"]
                      [ toolbar ]
                  ]
              ]
          ]

      tags msg =
        div [ class "mail-tags" ]
          <| List.map tag msg.tags

      toolbar =
        div [ class "toolbar" ]
          [ button [ type_ "button", class "button tiny", title "Create Tactic" ] 
              [ i [ class "fi-plus" ] [] 
              ]
          , button [ type_ "button", class "button tiny", title "Attach to Existing" ] 
              [ i [ class "fi-paperclip" ] [] 
              ]
          , button [ type_ "button", class "button tiny warning", title "Note & Archive" ]
              [ i [ class "fi-archive"] []
              ]
          , button [ type_ "button", class "button tiny alert", title "Close Issue" ] 
              [ i [ class "fi-x" ] [] 
              ]
          ]


  in 
      div []
        [ div [ class "row" ]
            <| (div [ class "small-12 columns" ] 
                  [ h3 [ class "mailbox-header" ] [ text "Mailbox" ] ])
                 ::(List.map mailMessage project.mailbox)
        ]

showDate : Date -> String
showDate date =
  String.join " " [ toString <| dayOfWeek date
                  , " "
                  , toString <| day date
                  , " " 
                  , toString <| month date
                  , " "
                  , toString <| year date
                  ]

--------------------------------------------------------------------------------

allCards : Model -> Html Msg
allCards model =
  let mkCard cd =
        div [ class "small-12 medium-6 columns" ]
          [ projectCard cd ]

  in
      div [ id "project-cards", class "row" ] 
        <| List.map mkCard model.projects

projectCard : Project -> Html Msg
projectCard project =
  let bg =
        cardBackgroundClass project.background
        
  in
      div [ class "card" ]
        [ div [ class "card-divider project-card-header", bg ]
            [ div [ avatarClass project.avatar ] []
            , h4 [] [ text project.name ]
            ] 
        , div [ class "card-section" ]
            [ text project.shortDescription ]
        , div [ class "card-divider", bg ]
            [ div [ class "row align-middle" ]
                [ div [ class "small-12 columns" ]
                    [ div [ class "float-left" ]
                        <| List.map statusLabel project.status
                    , button [ class "button small primary float-right no-margin"
                             , type_ "button" 
                             , onClick <| FocusProject project
                             ] 
                        [ text "View" ] 
                    ]
                ]
            ]
        ]

cardBackgroundClass : Background -> Attribute Msg
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

statusLabel : Status -> Html Msg
statusLabel status =
  case status of
    PendingReports ->
      span [ class "label warning" ] [ text "Pending Reports" ]

    Activity Active ->
      span [ class "label success" ] [ text "Active" ]

    Activity Inactive ->
      span [ class "label secondary" ] [ text "Inactive" ]

    Activity Concluded ->
      span [ class "label primary" ] [ text "Concluded" ]

--------------------------------------------------------------------------------

avatar : Avatar -> Html Msg
avatar av =
  div [ avatarClass av ] []

avatarClass : Avatar -> Attribute Msg
avatarClass av =
  let classFromAv =
        genderPrefix ++ toString av.num

      genderPrefix =
        case av.gender of
          Man ->
            "man-"

          Woman ->
            "woman-"

  in
      class <| "float-right avatar " ++ classFromAv


tag : Tag -> Html Msg
tag t =
  div [ class "tag" ] [ text t ]

