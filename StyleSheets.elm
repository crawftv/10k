module StyleSheets exposing (..)

import Style exposing (..)
import Style.Color as Color
import Style.Font as Font
import Style.Border as Border
import Color exposing (..)
import Style.Background exposing (gradient, step)


type MyStyles
    = NoStyle
    | HelpView
    | ButtonView
    | CTAView
    | NavView
    | BorderView
    | Error


loadRoboto : Font
loadRoboto =
    Font.importUrl
        { url = "https://fonts.googleapis.com/css?family=Roboto"
        , name = "Roboto"
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
            , Font.typeface
                [ Font.font "Roboto" ]
            ]
        , Style.style NavView
            [ Font.size 20
            , Font.typeface
                [ Font.font "Roboto" ]
            ]
        , Style.style BorderView
            [ Border.all 1
            ]
        , Style.style ButtonView
            [ Color.background red
            , Color.text white
            , Font.size 24
            , Font.typeface
                [ Font.font "Roboto" ]
            ]
        , Style.style CTAView
            [ Color.background red
            , Color.text white
            , Font.size 24
            , Font.typeface
                [ Font.font "Roboto" ]
            ]
        , Style.style Error
            [ Color.text Color.red
            ]
        ]
