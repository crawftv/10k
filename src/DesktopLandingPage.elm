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


noStyle =
    StyleSheets.NoStyle


landingPageArea : Element MyStyles variation msg
landingPageArea =
    Element.wrappedColumn StyleSheets.PageStyle
        []
        [ LandingNavBar.topBarView
        , Element.mainContent noStyle [ Att.height (Att.px 500), Att.width (Att.fill) ] heroView
        , el StyleSheets.ButtonView [ Att.height (Att.px 300) ] (ctaView "Sign-up! and Get Started Today!")
        , el noStyle [ Att.height (Att.px 400) ] featureView
        , el StyleSheets.ButtonView [ Att.height (Att.px 300) ] (ctaView "This offer is limited to 200 motivated people Sign-up to get a spot!")
        ]


heroView : Element MyStyles variation msg
heroView =
    Element.column noStyle
        [ Att.spacing 5, Att.height Att.fill ]
        [ Element.h1 StyleSheets.HeroHeaderStyle [ Att.alignTop, Att.center ] (Element.bold "Tired of Quitting on Your Goals")
        , Element.h2 StyleSheets.HeroHeaderStyle [ Att.alignTop, Att.center ] (text "Become Your Best Self with FinishYourGoals.com")
        , Element.wrappedRow StyleSheets.HeroRightStyle
            [ Att.center, Att.height Att.fill, Att.spacing 5 ]
            [ el noStyle [ Att.width Att.fill ] (text "image goes here")
            , Element.column noStyle
                [ Att.verticalCenter, Att.width Att.fill, Att.spacing 50 ]
                [ el noStyle [] (text "We hold you accountable with constant check-ups.")
                , el noStyle [] (text "Personalized help creating actionable goals")
                , el noStyle [] (text "Start becoming an expert in what you've always wanted Today!")
                ]
            ]
        ]


ctaView : String -> Element MyStyles variation msg
ctaView string =
    el StyleSheets.CTAView [ Att.center, Att.verticalCenter ] (text string)


featureView : Element MyStyles variation msg
featureView =
    el noStyle [ Att.center, Att.verticalCenter ] (text "Feature")


view : Html msg
view =
    Element.layout stylesheet <|
        landingPageArea
