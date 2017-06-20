module UI.Widgets.ProgressBar exposing (progressBar)

import Html exposing (Html, Attribute, text, node)
import Html.Attributes as Html exposing (style)
import Html.CssHelpers exposing (withNamespace)
import Css exposing (Mixin, asPairs, width, minHeight, fontSize, lineHeight, pct, px, int)
import UI.ToString exposing (pointToSvgAttr)


{ id, class, classList } =
    withNamespace "ui"


styles : List Mixin -> Attribute msg
styles =
    asPairs >> Html.style


progressBar : Float -> String -> Float -> Html msg
progressBar percent floatText height =
    node "progressBar"
        [ styles [ minHeight (px height) ] ]
        [ node "fill"
            [ styles
                [ width
                    (pct
                        (percent * 100)
                    )
                , lineHeight (int 1)
                , fontSize (px height)
                ]
            ]
            []
        , node "label" [] [ text floatText ]
        ]
