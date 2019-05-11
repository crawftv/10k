module AppNavBar exposing (topBarView)

import Element exposing (..)
import Element.Attributes as Att
import StyleSheets exposing (MyStyles, stylesheet)


helpView =
    StyleSheets.HelpView


navView =
    StyleSheets.NavView


navBar : Element MyStyles variation msg
navBar =
    navigation StyleSheets.NoStyle
        [ Att.alignRight, Att.spacing 16 ]
        { name = "Main Navigation"
        , options =
            [ link "createNewGoal.html" (button StyleSheets.ButtonView [] (text "Create New Goal"))
            ]
        }


topBarView : Element MyStyles variation msg
topBarView =
    Element.row StyleSheets.TopBarStyle
        [ Att.spacing 20 ]
        [ el navView [] (text "Small Logo Goes here")
        , el navView [ Att.width Att.fill ] (text "FinishYourGoals.com")
        , navBar
        ]
