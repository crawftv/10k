port module Main exposing (..)

import Element exposing (..)
import Element.Input as Input
import Element.Attributes as Att
import Element.Events as Ev
import Html exposing (Html)
import StyleSheets exposing (MyStyles, stylesheet)
import AppNavBar
import DesktopLandingPage
import Model exposing (User, Goal, Model)
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
    (Model Nothing Nothing "" "")


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


helpView =
    StyleSheets.HelpView


noStyle =
    StyleSheets.NoStyle


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
            el noStyle [] (text "Loading Goals")

        Just userGoals ->
            case userGoals of
                [] ->
                    el noStyle [] (text "No Goals")

                _ ->
                    userGoals
                        |> List.map goalIndividualView
                        |> Element.wrappedRow noStyle [ Att.width (Att.percent 50), Att.spacing 20, Att.center ]


goalView : Model -> Element MyStyles variation Msg
goalView model =
    Element.column noStyle [ Att.center ] [ goalListView model.userGoals ]


pageArea : Model -> Element MyStyles variation Msg
pageArea model =
    Element.column noStyle [ Att.spacing 10 ] [ AppNavBar.topBarView model.currentUser, goalView model ]


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
