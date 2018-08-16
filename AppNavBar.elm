module AppNavBar exposing (topBarView)

import Element exposing (..)
import Element.Attributes as Att
import Model exposing (Model, User)
import StyleSheets exposing (MyStyles, stylesheet)


helpView =
    StyleSheets.HelpView


navView =
    StyleSheets.NavView


navBar : Maybe User -> Element MyStyles variation msg
navBar user =
    case user of
        Nothing ->
            navigation helpView
                []
                { name = "Main Navigation"
                , options =
                    [ link
                        "Login.html"
                        (button StyleSheets.ButtonView [] (text "Login"))

                    -- , link "/logout" (el helpView [] (text "logout"))
                    ]
                }

        Just user ->
            navigation StyleSheets.NoStyle
                [ Att.alignRight, Att.spacing 16 ]
                { name = "Main Navigation"
                , options =
                    [ link
                        "Logout.html"
                        (button StyleSheets.ButtonView [] (text "Logout"))
                    ]
                }


topBarView : Maybe User -> Element MyStyles variation msg
topBarView user =
    Element.wrappedRow StyleSheets.TopBarStyle
        [ Att.spacing 20 ]
        [ el navView [] (text "Small Logo Goes here")
        , el navView [ Att.width Att.fill ] (text "FinishYourGoals.com")
        , navBar user
        ]
