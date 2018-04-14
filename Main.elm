port module Main exposing (..)

import Element exposing (..)
import Style exposing (..)
import Style.Color as Color
import Style.Font as Font
import Color exposing (..)
import Html exposing (Html)


type alias Model =
    { currentUser : Maybe User
    , currentGoal : Maybe Goal
    }


type alias User =
    { email : String
    , uid : String
    , userGoals : List Goal
    }


type alias Goal =
    { goalName : String
    , endGoal : Int
    , progress : Int
    }


type Msg
    = LoadUser User


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadUser user ->
            ( { model | currentUser = Just user }, Cmd.none )


main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( Model Nothing Nothing, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    loadUser LoadUser


port loadUser : (User -> msg) -> Sub msg


type MyStyles
    = TitleBar
    | CreateGoalView


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
        ]


userView user =
    case user of
        Nothing ->
            el TitleBar [] (text "Please Sign in")

        Just user ->
            el TitleBar [] (text user.email)


createGoalView =
    row CreateGoalView
        []
        [ el CreateGoalView [] (text "Goal Name")
        , el CreateGoalView [] (text "End Goal")
        , el CreateGoalView [] (text "Current Progess")
        ]


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        Element.h1 TitleBar [] <|
            userView model.currentUser
