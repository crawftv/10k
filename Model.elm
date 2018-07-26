module Model exposing (..)


type alias Model =
    { currentUser : Maybe User
    , userGoals : Maybe (List Goal)
    , selectedGoalId : String
    , addProgress : String
    }


type alias User =
    { email : String
    , uid : String
    }


type alias Goal =
    { goalName : String
    , endGoal : Float
    , progress : Float
    , fireStoreValue : String
    , addProgress : String
    }


type alias CNGModel =
    { currentUser : Maybe User
    , newGoalName : Maybe String
    , newEndGoal : Maybe String
    , newGoalProgress : Maybe String
    }
