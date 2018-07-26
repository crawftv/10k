module DesktopLandingPage exposing (..)

import Element exposing (..)
import Element.Attributes as Att
import Element.Events as Ev
import Html exposing (Html)
import LandingNavBar
import StyleSheets exposing (MyStyles, stylesheet)


main : Html msg
main =
    view


helpView : MyStyles
helpView =
    StyleSheets.HelpView


landingPageArea : Element MyStyles variation msg
landingPageArea =
    Element.wrappedColumn StyleSheets.HelpView
        []
        [ LandingNavBar.topBarView
        , Element.mainContent helpView [ Att.height (Att.px 500), Att.width (Att.fill) ] heroView
        , el StyleSheets.ButtonView [ Att.height (Att.px 300) ] ctaView
        , el helpView [ Att.height (Att.px 400) ] featureView
        , el StyleSheets.ButtonView [ Att.height (Att.px 300) ] ctaView
        ]


heroView : Element MyStyles variation msg
heroView =
    Element.column helpView
        [ Att.padding 10, Att.spacing 5, Att.height Att.fill ]
        [ Element.h1 helpView [ Att.alignTop, Att.center ] (Element.bold "Tired of Quitting on Your Goals")
        , Element.h2 helpView [ Att.alignTop, Att.center ] (text "Become Your Best Self with FinishYourGoals.com")
        , Element.row helpView
            [ Att.center, Att.height Att.fill, Att.spacing 5 ]
            [ el helpView [ Att.width Att.fill ] (text "image goes here")
            , Element.column helpView
                [ Att.verticalCenter, Att.width Att.fill, Att.spacing 20 ]
                [ el helpView [] (text "We hold you accountable with constant check-ups.")
                , el helpView [] (text "Personalized help creating actionable goals")
                , el helpView [] (text "Start becoming an expert in what you've always wanted Today!")
                ]
            ]
        ]


ctaView : Element MyStyles variation msg
ctaView =
    el StyleSheets.CTAView [ Att.center, Att.verticalCenter ] (text "Click to Sign-up with email and get started today!")


featureView : Element MyStyles variation msg
featureView =
    el helpView [ Att.center, Att.verticalCenter ] (text "Feature")


view : Html msg
view =
    Element.layout stylesheet <|
        landingPageArea
