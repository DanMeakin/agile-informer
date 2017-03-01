module Update exposing (..)

import Date exposing (fromTime)
import Model exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    FocusProject prj ->
      { model | focusedProject = Just prj }
        ! []

    UnfocusProject ->
      { model | focusedProject = Nothing }
        ! []

    UpdateDate date ->
      { model | currentDate = fromTime date }
        ! []

    FocusStrategy strategy ->
      let project =
            model.focusedProject

      in  
          case project of
            Nothing ->
              model
                ! []

            Just proj ->
              let plan =
                    proj.plan

                  plan_ =
                    { plan | focusedStrategy = Just strategy }

              in
                  { model | focusedProject = Just { proj | plan = plan_ } }
                    ! []

    UnfocusStrategy ->
      let project =
            model.focusedProject 

      in
          case project of
            Nothing ->
              model
                ! []

            Just proj ->
              let plan =
                    proj.plan

                  plan_ =
                    { plan | focusedStrategy = Nothing }

              in
                  { model | focusedProject = Just { proj | plan = plan_ } }
                    ! []

    ShowMailbox ->
      let project =
            model.focusedProject

      in
          case project of
            Nothing ->
              model
                ! []

            Just proj ->
              { model | focusedProject = Just { proj | showView = Mailbox } }
                ! []

    CloseMailbox ->
      let project =
            model.focusedProject

      in
          case project of
            Nothing ->
              model
                ! []

            Just proj ->
              { model | focusedProject = Just { proj | showView = Tactics } }
                ! []
