module LandingNavBar exposing (topBarView)

import Element exposing (..)
import Element.Attributes as Att
import StyleSheets exposing (MyStyles, stylesheet)


helpView =
    StyleSheets.HelpView


navBar =
    navigation helpView
        []
        { name = "Main Navigation"
        , options =
            [ link
                "login.html"
                (el StyleSheets.ButtonView [] (text "Sign in to Get Started"))
              -- , link "/logout" (el helpView [] (text "logout"))
            ]
        }


topBarView : Element MyStyles variation msg
topBarView =
    Element.row helpView
        [ Att.spacing 10 ]
        [ el helpView [] (text "Small Logo Goes here")
        , el helpView [ Att.width Att.fill ] (text "FinishYourGoals.com")
        , navBar
        ]
