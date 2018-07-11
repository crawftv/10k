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
    | Error


stylesheet : StyleSheet MyStyles variation
stylesheet =
    Style.styleSheet
        [ Style.style NoStyle
            []
          -- , Style.style X
          --     [ Border.all 1
          --     , Border.solid
          --     , Color.border black
          --     , Border.rounded 3
          --     ]
        , Style.style HelpView [ Border.all 1, Color.border gray ]
        , Style.style Error
            [ Color.text Color.red
            ]
        ]
