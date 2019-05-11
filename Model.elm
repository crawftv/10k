module Model exposing (..)


type alias Model =
    { currentUser : User
    , userGoals : Maybe (List Goal)
    , selectedGoalId : String
    , addProgress : String
    }


type alias User =
    { uid : String
    }


type alias Goal =
    { goalName : String
    , endGoal : Float
    , progress : Float
    , fireStoreValue : String
    , addProgress : String
    , dateCreated : String
    , lastUpdate : String
    , unixLastUpdate : Float
    , unixDateCreated : Float
    }


type alias CNGModel =
    { currentUser : Maybe User
    , newGoalName : Maybe String
    , newEndGoal : Maybe String
    , newGoalProgress : Maybe String
    }
