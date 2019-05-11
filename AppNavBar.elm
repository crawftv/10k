module AppNavBar exposing (topBarView)

import Element exposing (..)
import Element.Attributes as Att
<<<<<<< HEAD
=======
import Model exposing (Model, User)
>>>>>>> 041f09abd96ee30d72a6711d9f20e9579f0d7824
import StyleSheets exposing (MyStyles, stylesheet)


helpView =
    StyleSheets.HelpView


navView =
    StyleSheets.NavView


<<<<<<< HEAD
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
=======
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
>>>>>>> 041f09abd96ee30d72a6711d9f20e9579f0d7824
        [ Att.spacing 20 ]
        [ el navView [] (text "Small Logo Goes here")
        , el navView [ Att.width Att.fill ] (text "FinishYourGoals.com")
        , navBar
        ]
