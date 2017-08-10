module Update
    exposing
        ( Msg(..)
        , update
        )

import Model exposing (Model)
import Constants exposing (inputId)
import Dom
import Task


type Msg
    = NoOp
    | FocusInput
    | FocusInputResult (Result Dom.Error ())
    | SetInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FocusInput ->
            ( model
            , Dom.focus inputId
                |> Task.attempt FocusInputResult
            )

        FocusInputResult result ->
            update NoOp model

        SetInput text ->
            ( { model
                | input = text
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )