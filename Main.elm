port module Main exposing (..)

import AppNavBar
import DesktopLandingPage
import Element exposing (..)
import Element.Attributes as Att
import Element.Events as Ev
import Element.Input as Input
import Html exposing (Html)
import Model exposing (Goal, Model, User)
import StyleSheets exposing (MyStyles, stylesheet)
<<<<<<< HEAD
import AppNavBar
import Model exposing (User, Goal, Model)
=======
>>>>>>> 041f09abd96ee30d72a6711d9f20e9579f0d7824
import Update exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


initModel : Model
initModel =
<<<<<<< HEAD
    (Model { uid = "" } Nothing "" "")
=======
    Model Nothing Nothing "" ""
>>>>>>> 041f09abd96ee30d72a6711d9f20e9579f0d7824


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


helpView =
    StyleSheets.HelpView


noStyle =
    StyleSheets.NoStyle


shortDate : String -> String
shortDate dateString =
    dateString
        |> String.split " "
        |> List.drop 1
        |> List.take 3
        |> String.join " "


goalIndividualView : Goal -> Element MyStyles variation Msg
goalIndividualView goal =
    Element.wrappedColumn StyleSheets.IndividualGoalStyle
        [ Att.paddingTop 10, Att.spacing 10, Att.width (Att.px 300) ]
        [ Element.wrappedRow noStyle
            []
            [ el noStyle [ Att.width (Att.percent 50) ] (text "Goal Name: ")
            , el noStyle [ Att.width (Att.percent 50) ] (text goal.goalName)
            ]
        , Element.wrappedRow noStyle
            []
            [ el noStyle [ Att.width (Att.percent 50) ] (text "Date Created ")
            , el noStyle [ Att.width (Att.percent 50) ] (text (shortDate goal.dateCreated))
            ]
        , Element.wrappedRow noStyle
            []
            [ el noStyle [ Att.width (Att.percent 50) ] (text "Last Updated: ")
            , el noStyle [ Att.width (Att.percent 50) ] (text (shortDate goal.lastUpdate))
            ]
        , Element.wrappedRow noStyle
            []
            [ el noStyle [ Att.width (Att.percent 50) ] (text "Goal Progress: ")
            , el noStyle [ Att.width (Att.percent 50) ] (text (toString goal.progress))
            ]
        , Element.wrappedRow noStyle
            []
            [ el noStyle [ Att.width (Att.percent 50) ] (text "End Goal: ")
            , el noStyle [ Att.width (Att.percent 50) ] (text (toString goal.endGoal))
            ]
        , Element.row noStyle
            []
            [ el noStyle [ Att.width (Att.percent 50) ] (text "Pace: ")
            , el noStyle [ Att.width (Att.percent 50) ] (text ((toString (ceiling (getPace goal.unixLastUpdate goal.unixDateCreated goal.progress))) ++ " steps per day"))
            ]
        , Element.row noStyle
            []
            [ el noStyle [ Att.width (Att.percent 50) ] (text "Projected number of days until finishing: ")
            , el noStyle [ Att.width (Att.percent 50) ] (text ((toString (ceiling ((goal.endGoal - goal.progress) / (getPace goal.unixLastUpdate goal.unixDateCreated goal.progress)))) ++ " steps per day"))
            ]
        , Input.text StyleSheets.IndividualGoalStyle
            [ Att.width (Att.percent 100), Att.paddingBottom 5 ]
            { onChange = AddProgress
            , value = goal.addProgress
            , label =
                Input.placeholder
                    { label = Input.labelAbove (el noStyle [ Att.width (Att.percent 50) ] (text "Update this goal?: "))
                    , text = ""
                    }
            , options =
                [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
                ]
            }
        , selectGoalButton goal
        ]


getPace : Float -> Float -> Float -> Float
getPace unixLastUpdate unixDateCreated progress =
    (progress / ((unixLastUpdate - unixDateCreated) / 86400))


selectGoalButton : Goal -> Element MyStyles variation Msg
selectGoalButton currentGoal =
    button StyleSheets.ButtonView
        [ Att.height (Att.px 40), Ev.onClick (SendProgress ( currentGoal.fireStoreValue, currentGoal.progress )) ]
        (text "update this goal")


goalListView : Maybe (List Goal) -> Element MyStyles variation Msg
goalListView userGoals =
    case userGoals of
        Nothing ->
            el noStyle [] (text "Loading Goals")

        Just userGoals ->
            case userGoals of
                [] ->
                    createNewGoalView

                _ ->
                    userGoals
                        |> List.map goalIndividualView
                        |> Element.wrappedRow noStyle [ Att.width (Att.percent 75), Att.spacing 20, Att.center ]


goalView : Model -> Element MyStyles variation Msg
goalView model =
    Element.column noStyle [ Att.center, Att.height (Att.percent 100) ] [ createNewGoalView, goalListView model.userGoals ]


createNewGoalView : Element MyStyles variation Msg
createNewGoalView =
    link
        "createNewGoal.html"
        (button StyleSheets.ButtonView [ Att.spacingXY 0 10, Att.center, Att.width (Att.px 309) ] (text "Create New Goal"))


pageArea : Model -> Element MyStyles variation Msg
pageArea model =
    Element.column StyleSheets.PageStyle [ Att.spacing 10 ] [ AppNavBar.topBarView, goalView model ]


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        pageArea model
