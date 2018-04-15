port module Main exposing (..)

import Element exposing (..)
import Style exposing (..)
import Style.Color as Color
import Style.Font as Font
import Element.Input as Input
import Color exposing (..)
import Html exposing (Html)


type alias Model =
    { currentUser : Maybe User
    , newGoalName : Maybe String
    , newGoalGoal : Maybe String
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
    | NewGoalGoal String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadUser user ->
            ( { model | currentUser = Just user }, Cmd.none )

        NewGoalName goalName ->
            ( { model | newGoalName = Just goalName }, Cmd.none )

        NewGoalGoal goalGoal ->
            ( { model | newGoalGoal = Just goalGoal }, Cmd.none )


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


type MyStyles
    = TitleBar
    | CreateGoalView
    | NoStyle
    | Error


stylesheet =
    Style.styleSheet
        [ Style.style TitleBar
            [ Color.text white
            , Color.background blue
            , Font.size 24
            ]
        , Style.style CreateGoalView
            [ Color.text blue
            , Color.background white
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
        [ createGoalNameView model.newGoalName, createGoalGoalView model.newGoalGoal, createGoalProgressView model.newGoalProgress ]


createGoalNameView : Maybe String -> Element MyStyles variation Msg
createGoalNameView newGoalName =
    Input.text CreateGoalView
        []
        { onChange = NewGoalName
        , value =
            case newGoalName of
                Nothing ->
                    ""

                Just newGoalName ->
                    newGoalName
        , label =
            Input.placeholder
                { label = Input.labelLeft (el NoStyle [] (text "Goal Name: "))
                , text = "Placeholder!"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


createGoalGoalView : Maybe String -> Element MyStyles variation Msg
createGoalGoalView newGoalGoal =
    Input.text CreateGoalView
        []
        { onChange = NewGoalGoal
        , value =
            case newGoalGoal of
                Nothing ->
                    ""

                Just newGoalGoal ->
                    newGoalGoal
        , label =
            Input.placeholder
                { label = Input.labelLeft (el NoStyle [] (text "How many steps is this goal?: "))
                , text = "10,000"
                }
        , options =
            [-- [ Input.errorBelow (el Error [] (text "This is an Error!"))
            ]
        }


createGoalProgressView : Maybe String -> Element MyStyles variation Msg
createGoalProgressView newGoalProgress =
    Input.text CreateGoalView
        []
        { onChange = NewGoalGoal
        , value =
            case newGoalProgress of
                Nothing ->
                    ""

                Just newGoalGoal ->
                    newGoalGoal
        , label =
            Input.placeholder
                { label = Input.labelLeft (el NoStyle [] (text "How many steps have you taken on this goal?: "))
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
