port module Main exposing (..)

import Element exposing (..)
import Element.Input as Input
import Element.Attributes as Att
import Element.Events as Ev
import Html exposing (Html)
import StyleSheets exposing (MyStyles, stylesheet)
import AppNavBar
import DesktopLandingPage
import Model exposing (..)


type Msg
    = LoadUser User
    | NewGoalName String
    | NewEndGoal String
    | NewGoalProgress String
    | SendNewGoal
    | LoadGoals (List Goal)
    | SelectGoal String
    | AddProgress String
    | SendProgress ( String, Float )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadUser user ->
            ( { model | currentUser = Just user }, Cmd.none )

        LoadGoals userGoals ->
            ( { model | userGoals = Just userGoals }, Cmd.none )

        NewGoalName goalName ->
            ( { model | newGoalName = Just goalName }, Cmd.none )

        NewEndGoal endGoal ->
            ( { model | newEndGoal = Just endGoal }, Cmd.none )

        NewGoalProgress goalProgress ->
            ( { model | newGoalProgress = Just goalProgress }, Cmd.none )

        SendNewGoal ->
            ( model, newGoal ( model.newGoalName, model.newEndGoal, model.newGoalProgress ) )

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


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( Model Nothing Nothing Nothing Nothing Nothing "" "", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loadUser LoadUser
        , loadGoals LoadGoals
        ]


port loadUser : (User -> msg) -> Sub msg


port loadGoals : (List Goal -> msg) -> Sub msg


port sendProgress : ( String, Float, String ) -> Cmd msg


port newGoal : ( Maybe String, Maybe String, Maybe String ) -> Cmd msg


helpView =
    StyleSheets.HelpView


noStyle =
    StyleSheets.NoStyle


userView : Maybe User -> Element MyStyles variation msg
userView user =
    case user of
        Nothing ->
            el helpView [ Att.alignRight ] (text "Please Sign in")

        Just user ->
            el helpView [ Att.alignRight ] (text user.email)


centerCreateGoalView : Model -> Element MyStyles variation Msg
centerCreateGoalView model =
    el helpView [ Att.center, Att.width (Att.percent 50) ] (createGoalView model)


createGoalView : Model -> Element MyStyles variation Msg
createGoalView model =
    Element.column helpView
        []
        [ createGoalNameView model.newGoalName
        , createEndGoalView model.newEndGoal
        , createGoalProgressView model.newGoalProgress
        , createGoalSubmit
        ]


createGoalNameView : Maybe String -> Element MyStyles variation Msg
createGoalNameView newGoalName =
    Input.text helpView
        [ Att.width (Att.percent 50) ]
        { onChange = NewGoalName
        , value =
            case newGoalName of
                Nothing ->
                    ""

                Just newGoalName ->
                    newGoalName
        , label =
            Input.placeholder
                { label = Input.labelLeft (el helpView [ Att.width (Att.percent 50) ] (text "Goal Name: "))
                , text = "Placeholder!"
                }
        , options =
            [ Input.allowSpellcheck
            ]
        }


createEndGoalView : Maybe String -> Element MyStyles variation Msg
createEndGoalView newEndGoal =
    Input.text helpView
        [ Att.width (Att.percent 50) ]
        { onChange = NewEndGoal
        , value =
            case newEndGoal of
                Nothing ->
                    ""

                Just newEndGoal ->
                    newEndGoal
        , label =
            Input.placeholder
                { label = Input.labelLeft (el helpView [ Att.width (Att.percent 50) ] (text "How many steps is this goal?: "))
                , text = "10,000"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


createGoalProgressView : Maybe String -> Element MyStyles variation Msg
createGoalProgressView newGoalProgress =
    Input.text helpView
        [ Att.width (Att.percent 50) ]
        { onChange = NewGoalProgress
        , value =
            case newGoalProgress of
                Nothing ->
                    ""

                Just newGoalProgess ->
                    newGoalProgess
        , label =
            Input.placeholder
                { label = Input.labelLeft (el helpView [ Att.width (Att.percent 50) ] (text "How many steps have you taken on this goal?: "))
                , text = "0"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


createGoalSubmit : Element MyStyles variation Msg
createGoalSubmit =
    button helpView
        [ Att.height (Att.px 25), (Ev.onClick SendNewGoal) ]
        (text "Create New Goal")


goalIndividualView : Goal -> Element MyStyles variation Msg
goalIndividualView goal =
    Element.column helpView
        []
        [ Element.row helpView
            []
            [ el helpView [ Att.width (Att.percent 50) ] (text "Goal Name: ")
            , el helpView [ Att.width (Att.percent 50) ] (text goal.goalName)
            ]
        , Element.row helpView
            []
            [ el helpView [ Att.width (Att.percent 50) ] (text "Goal Progress: ")
            , el helpView [ Att.width (Att.percent 50) ] (text (toString goal.progress))
            ]
        , Element.row helpView
            []
            [ el helpView [ Att.width (Att.percent 50) ] (text "End Goal: ")
            , el helpView [ Att.width (Att.percent 50) ] (text (toString goal.endGoal))
            ]
        , Input.text helpView
            [ Att.width (Att.percent 50) ]
            { onChange = AddProgress
            , value = goal.addProgress
            , label =
                Input.placeholder
                    { label = Input.labelLeft (el helpView [ Att.width (Att.percent 50) ] (text "Update this goal?: "))
                    , text = ""
                    }
            , options =
                [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
                ]
            }
        , selectGoalButton goal
        ]


selectGoalButton : Goal -> Element MyStyles variation Msg
selectGoalButton currentGoal =
    button helpView
        [ Att.height (Att.px 25), (Ev.onClick (SendProgress ( currentGoal.fireStoreValue, currentGoal.progress ))) ]
        (text "update this goal")


goalListView : Maybe (List Goal) -> Element MyStyles variation Msg
goalListView userGoals =
    case userGoals of
        Nothing ->
            el noStyle [] (text "No user goals")

        Just userGoals ->
            userGoals
                |> List.map goalIndividualView
                |> Element.column noStyle [ Att.width (Att.percent 50), Att.spacing 20 ]


goalView : Model -> Element MyStyles variation Msg
goalView model =
    Element.column noStyle [ Att.center ] [ goalListView model.userGoals ]


pageArea : Model -> Element MyStyles variation Msg
pageArea model =
    Element.column noStyle [ Att.spacing 10 ] [ AppNavBar.topBarView model, centerCreateGoalView model, goalView model ]


landingPageArea : Html Msg
landingPageArea =
    DesktopLandingPage.view


view : Model -> Html Msg
view model =
    case model.currentUser of
        Nothing ->
            landingPageArea

        _ ->
            Element.layout stylesheet <|
                pageArea model
