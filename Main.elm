port module Main exposing (..)

import Element exposing (..)
import Style exposing (..)
import Style.Color as Color
import Style.Font as Font
import Element.Input as Input
import Element.Attributes as Att
import Element.Events as Ev
import Color exposing (..)
import Html exposing (Html)


type alias Model =
    { currentUser : Maybe User
    , newGoalName : Maybe String
    , newEndGoal : Maybe String
    , newGoalProgress : Maybe String
    , userGoals : Maybe (List Goal)
    }


type alias User =
    { email : String
    , uid : String
    }


type alias Goal =
    { goalName : String
    , endGoal : Int
    , progress : Int
    }


type Msg
    = LoadUser User
    | NewGoalName String
    | NewEndGoal String
    | NewGoalProgress String
    | SendNewGoal


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadUser user ->
            ( { model | currentUser = Just user }, Cmd.none )

        NewGoalName goalName ->
            ( { model | newGoalName = Just goalName }, Cmd.none )

        NewEndGoal endGoal ->
            ( { model | newEndGoal = Just endGoal }, Cmd.none )

        NewGoalProgress goalProgress ->
            ( { model | newGoalProgress = Just goalProgress }, Cmd.none )

        SendNewGoal ->
            ( model, newGoal ( model.newGoalName, model.newEndGoal, model.newGoalProgress ) )


main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( Model Nothing Nothing Nothing Nothing Nothing, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    loadUser LoadUser


port loadUser : (User -> msg) -> Sub msg


port newGoal : ( Maybe String, Maybe String, Maybe String ) -> Cmd msg


type MyStyles
    = TitleBar
    | CreateGoalStyle
    | NoStyle
    | Error


stylesheet =
    Style.styleSheet
        [ Style.style TitleBar
            [ Color.text white
            , Color.background blue
            , Font.size 24
            ]
        , Style.style CreateGoalStyle
            [ Color.text blue
            , Color.background grey
            , Font.size 16
            ]
        , Style.style NoStyle
            []
        , Style.style Error
            [ Color.text Color.red
            ]
        ]


userView : Maybe User -> Element MyStyles variation msg
userView user =
    case user of
        Nothing ->
            el TitleBar [] (text "Please Sign in")

        Just user ->
            el TitleBar [] (text user.email)


titleView : Model -> Element MyStyles variation msg
titleView model =
    userView model.currentUser


createGoalView : Model -> Element MyStyles variation Msg
createGoalView model =
    Element.column NoStyle
        []
        [ createGoalNameView model.newGoalName
        , createEndGoalView model.newEndGoal
        , createGoalProgressView model.newGoalProgress
        , createGoalSubmit
        ]


createGoalSubmit : Element MyStyles variation Msg
createGoalSubmit =
    button CreateGoalStyle
        [ Att.width (Att.px 800), Att.height (Att.px 25), (Ev.onClick SendNewGoal) ]
        (text "Create New Goal")


createGoalNameView : Maybe String -> Element MyStyles variation Msg
createGoalNameView newGoalName =
    Input.text CreateGoalStyle
        [ Att.width (Att.px 400) ]
        { onChange = NewGoalName
        , value =
            case newGoalName of
                Nothing ->
                    ""

                Just newGoalName ->
                    newGoalName
        , label =
            Input.placeholder
                { label = Input.labelLeft (el NoStyle [ Att.width (Att.px 400) ] (text "Goal Name: "))
                , text = "Placeholder!"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


createEndGoalView : Maybe String -> Element MyStyles variation Msg
createEndGoalView newEndGoal =
    Input.text CreateGoalStyle
        [ Att.width (Att.px 400) ]
        { onChange = NewEndGoal
        , value =
            case newEndGoal of
                Nothing ->
                    ""

                Just newEndGoal ->
                    newEndGoal
        , label =
            Input.placeholder
                { label = Input.labelLeft (el NoStyle [ Att.width (Att.px 400) ] (text "How many steps is this goal?: "))
                , text = "10,000"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


createGoalProgressView : Maybe String -> Element MyStyles variation Msg
createGoalProgressView newGoalProgress =
    Input.text CreateGoalStyle
        [ Att.width (Att.px 400) ]
        { onChange = NewGoalProgress
        , value =
            case newGoalProgress of
                Nothing ->
                    ""

                Just newGoalProgess ->
                    newGoalProgess
        , label =
            Input.placeholder
                { label = Input.labelLeft (el NoStyle [ Att.width (Att.px 400) ] (text "How many steps have you taken on this goal?: "))
                , text = "0"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        pageArea model


pageArea model =
    Element.column NoStyle [] [ titleView model, createGoalView model ]
