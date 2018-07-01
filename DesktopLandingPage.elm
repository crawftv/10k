module LandingPage exposing (..)

import Element exposing (..)
import Element.Attributes as Att
import Element.Events as Ev
import Html exposing (Html)
import Window exposing (..)
import ScreenSize exposing (..)
import NavBar
import StyleSheets exposing (MyStyles, stylesheet)


main : Html msg
main =
    view


helpView =
    StyleSheets.HelpView


landingPageArea : Element MyStyles variation msg
landingPageArea =
    Element.wrappedColumn helpView
        []
        [ NavBar.topBarView
        , Element.mainContent helpView [ Att.height (Att.px 500), Att.width (Att.fill) ] heroView
        , el helpView [ Att.height (Att.px 300) ] ctaView
        , el helpView [ Att.height (Att.px 400) ] featureView
        , el helpView [ Att.height (Att.px 300) ] ctaView
        ]


heroView : Element MyStyles variation msg
heroView =
    Element.column helpView
        [ Att.padding 10, Att.spacing 5, Att.height Att.fill ]
        [ Element.h1 helpView [ Att.alignTop, Att.center ] (text "Tired of Quitting on Your Goals")
        , Element.h2 helpView [ Att.alignTop, Att.center ] (Element.bold "Become Your Best Self with FinishYourGoals.com")
        , Element.row helpView
            [ Att.center, Att.height Att.fill, Att.spacing 5 ]
            [ el helpView [ Att.width Att.fill ] (text "image goes here")
            , Element.column helpView
                [ Att.verticalCenter, Att.width Att.fill ]
                [ el helpView [] (text "text")
                , el helpView [] (text "text")
                , el helpView [] (text "text")
                ]
            ]
        ]


ctaView : Element MyStyles variation msg
ctaView =
    el helpView [ Att.center, Att.verticalCenter ] (text "Get Started Today")


featureView : Element MyStyles variation msg
featureView =
    el helpView [ Att.center, Att.verticalCenter ] (text "Feature")


view : Html msg
view =
    Element.layout stylesheet <|
        landingPageArea
