port module CreateNewGoal exposing (centerCreateGoalView)

import Element exposing (..)
import Element.Attributes as Att
import StyleSheets exposing (MyStyles, stylesheet)
import Model exposing (User)
import Element exposing (..)
import Element.Input as Input
import Element.Attributes as Att
import Element.Events as Ev
import Html exposing (Html)
import Update exposing (loadUser)
import AppNavBar exposing (topBarView)


helpView : MyStyles
helpView =
    StyleSheets.HelpView


noStyle : MyStyles
noStyle =
    StyleSheets.NoStyle


main : Program Never CNGModel Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias CNGModel =
    { currentUser : User
    , newGoalName : Maybe String
    , newEndGoal : Maybe String
    , newGoalProgress : Maybe String
    }


initModel : CNGModel
initModel =
    (CNGModel { uid = "" } Nothing Nothing Nothing)


init : ( CNGModel, Cmd Msg )
init =
    ( initModel, Cmd.none )


view : CNGModel -> Html Msg
view model =
    Element.layout stylesheet <|
        cngPageArea model


cngPageArea : CNGModel -> Element MyStyles variation Msg
cngPageArea model =
    Element.column noStyle [ Att.spacing 10 ] [ AppNavBar.topBarView model.currentUser, centerCreateGoalView model ]


centerCreateGoalView : CNGModel -> Element MyStyles variation Msg
centerCreateGoalView model =
    el noStyle [ Att.center, Att.width (Att.percent 50) ] (createGoalView model)


createGoalView : CNGModel -> Element MyStyles variation Msg
createGoalView model =
    Element.column StyleSheets.IndividualGoalStyle
        [ Att.paddingTop 5, Att.spacing 5 ]
        [ createGoalNameView model.newGoalName
        , createEndGoalView model.newEndGoal
        , createGoalProgressView model.newGoalProgress
        , createGoalSubmit
        ]


createGoalNameView : Maybe String -> Element MyStyles variation Msg
createGoalNameView newGoalName =
    Input.text StyleSheets.IndividualGoalStyle
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
                { label = Input.labelLeft (el noStyle [ Att.width (Att.percent 50) ] (text "Goal Name: "))
                , text = "Placeholder!"
                }
        , options =
            [ Input.allowSpellcheck
            ]
        }


createEndGoalView : Maybe String -> Element MyStyles variation Msg
createEndGoalView newEndGoal =
    Input.text StyleSheets.IndividualGoalStyle
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
                { label = Input.labelLeft (el noStyle [ Att.width (Att.percent 50) ] (text "How many steps is this goal?: "))
                , text = "10,000"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


createGoalProgressView : Maybe String -> Element MyStyles variation Msg
createGoalProgressView newGoalProgress =
    Input.text StyleSheets.IndividualGoalStyle
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
                { label = Input.labelLeft (el noStyle [ Att.width (Att.percent 50) ] (text "How many steps have you taken on this goal?: "))
                , text = "0"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


type Msg
    = LoadUser User
    | NewGoalName String
    | NewEndGoal String
    | NewGoalProgress String
    | SendNewGoal


update : Msg -> CNGModel -> ( CNGModel, Cmd Msg )
update msg model =
    case msg of
        LoadUser user ->
            ( { model | currentUser = user }, Cmd.none )

        NewGoalName goalName ->
            ( { model | newGoalName = Just goalName }, Cmd.none )

        NewEndGoal endGoal ->
            ( { model | newEndGoal = Just endGoal }, Cmd.none )

        NewGoalProgress goalProgress ->
            ( { model | newGoalProgress = Just goalProgress }, Cmd.none )

        SendNewGoal ->
            ( { model | newGoalName = Just "" }, newGoal ( model.newGoalName, model.newEndGoal, model.newGoalProgress ) )


createGoalSubmit : Element MyStyles variation Msg
createGoalSubmit =
    button StyleSheets.ButtonView
        [ Att.height (Att.px 25), (Ev.onClick SendNewGoal) ]
        (text "Create New Goal")


port newGoal : ( Maybe String, Maybe String, Maybe String ) -> Cmd msg


subscriptions : CNGModel -> Sub Msg
subscriptions model =
    Sub.batch
        [ loadUser LoadUser
        ]
