module Landing exposing (..)

import DesktopLandingPage


view : Html Msg
view =
    Element.layout stylesheet <|
        landingPageArea


landingPageArea : Html Msg
landingPageArea =
    DesktopLandingPage.view
