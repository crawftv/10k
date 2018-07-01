module StyleSheets exposing (..)

import Style exposing (..)
import Style.Color as Color
import Style.Font as Font
import Style.Border as Border
import Color exposing (..)


type MyStyles
    = TitleBar
    | NoStyle
    | HelpView
    | Error


stylesheet : StyleSheet MyStyles variation
stylesheet =
    Style.styleSheet
        [ Style.style TitleBar
            [ Color.text white
            , Color.background blue
            , Font.size 24
            ]
        , Style.style NoStyle
            []
          -- , Style.style X
          --     [ Border.all 1
          --     , Border.solid
          --     , Color.border black
          --     , Border.rounded 3
          --     ]
        , Style.style HelpView [ Border.all 1, Border.dashed, Color.border red ]
        , Style.style Error
            [ Color.text Color.red
            ]
        ]
