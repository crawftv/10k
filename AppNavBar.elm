module AppNavBar exposing (topBarView)

import Element exposing (..)
import Element.Attributes as Att
import StyleSheets exposing (MyStyles, stylesheet)
import Model exposing (Model, User)


helpView =
    StyleSheets.HelpView


navBar : Maybe User -> Element MyStyles variation msg
navBar user =
    case user of
        Nothing ->
            navigation helpView
                []
                { name = "Main Navigation"
                , options =
                    [ link
                        "login.html"
                        (el helpView [] (text "Login"))
                      -- , link "/logout" (el helpView [] (text "logout"))
                    ]
                }

        Just user ->
            el helpView [ Att.alignRight ] (text user.email)


topBarView : Model -> Element MyStyles variation msg
topBarView model =
    Element.row helpView
        []
        [ el helpView [] (text "Small Logo Goes here")
        , el helpView [ Att.width Att.fill ] (text "FinishYourGoals.com")
        , navBar model.currentUser
        ]
