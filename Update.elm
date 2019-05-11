port module Update exposing (..)

import Model exposing (User, Goal, Model)


type Msg
    = LoadUser User
    | LoadGoals (List Goal)
    | SelectGoal String
    | AddProgress String
    | SendProgress ( String, Float )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadUser user ->
            ( { model | currentUser = user }, Cmd.none )

        LoadGoals userGoals ->
            ( { model | userGoals = Just userGoals }, Cmd.none )

        SelectGoal selectedGoalId ->
            ( { model | selectedGoalId = selectedGoalId }, Cmd.none )

        AddProgress addProgress ->
            ( { model | addProgress = addProgress }, Cmd.none )

        SendProgress ( selectedGoalId, progress ) ->
            case (Result.withDefault 0 (String.toFloat model.addProgress)) of
                0 ->
                    ( model, Cmd.none )

                _ ->
                    ( { model | selectedGoalId = "", addProgress = "", userGoals = Nothing }, sendProgress ( model.addProgress, progress, selectedGoalId ) )


port loadUser : (User -> msg) -> Sub msg


port loadGoals : (List Goal -> msg) -> Sub msg


port sendProgress : ( String, Float, String ) -> Cmd msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loadUser LoadUser
        , loadGoals LoadGoals
        ]
