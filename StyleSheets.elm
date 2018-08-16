module StyleSheets exposing (..)

import Color exposing (..)
import Style exposing (..)
import Style.Background as Background exposing (gradient, step)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font


type MyStyles
    = NoStyle
    | HelpView
    | ButtonView
    | CTAView
    | NavView
    | BorderView
    | HeroRightStyle
    | PageStyle
    | IndividualGoalStyle
    | HeroHeaderStyle
    | TopBarStyle
    | Error


loadRoboto : Font
loadRoboto =
    Font.importUrl
        { url = "https://fonts.googleapis.com/css?family=Roboto"
        , name = "Roboto"
        }


loadOpenSans : Font
loadOpenSans =
    Font.importUrl
        { url = "https://fonts.googleapis.com/css?family=Open+Sans"
        , name = "Open Sans"
        }


stylesheet : StyleSheet MyStyles variation
stylesheet =
    Style.styleSheet
        [ Style.style NoStyle
            []
        , Style.style HelpView
            [ Border.all 1
            , Color.border gray
            , Font.size 16
            , Font.center
            ]
        , Style.style TopBarStyle
            [ Color.background white
            , Border.bottom 5
            , Color.border (Color.rgb 51 122 183)
            ]
        , Style.style NavView
            [ Font.size 20
            , Font.typeface
                [ loadRoboto ]
            ]
        , Style.style IndividualGoalStyle
            [ Border.all 1
            , Border.rounded 5
            , Color.border (Color.rgb 51 122 183)
            , Color.background white
            , Font.typeface [ loadOpenSans ]
            ]
        , Style.style HeroRightStyle
            [ Border.all 1
            , Border.rounded 5
            , Color.border (Color.rgb 51 122 183)
            , Font.size 20
            , Font.typeface
                [ loadOpenSans ]
            ]
        , Style.style HeroHeaderStyle
            [ Font.size 24
            , Font.typeface
                [ loadRoboto ]
            ]
        , Style.style BorderView
            [ Border.all 1
            ]
        , Style.style ButtonView
            [ Color.background red
            , Color.text white
            , Font.size 24
            , Font.typeface
                [ loadRoboto ]
            , Border.rounded 5
            ]
        , Style.style PageStyle
            []
        , Style.style CTAView
            [ Color.background red
            , Color.text white
            , Font.size 24
            , Font.typeface
                [ loadRoboto ]
            ]
        , Style.style Error
            [ Color.text Color.red
            ]
        ]
