module LandingNavBar exposing (topBarView)

import Element exposing (..)
import Element.Attributes as Att
import StyleSheets exposing (MyStyles, stylesheet)


navView =
    StyleSheets.NavView


noStyle =
    StyleSheets.NoStyle


navBar =
    navigation navView
        []
        { name = "Main Navigation"
        , options =
            [ link
                "Login.html"
                (button StyleSheets.ButtonView [] (text "Sign in to Get Started"))

            -- , link "/logout" (el helpView [] (text "logout"))
            ]
        }


topBarView : Element MyStyles variation msg
topBarView =
    Element.wrappedRow StyleSheets.TopBarStyle
        [ Att.spacing 10 ]
        [ el navView [] (text "Small Logo Goes here")
        , el navView [ Att.width Att.fill ] (text "FinishYourGoals.com")
        , navBar
        ]
