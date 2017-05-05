module Apps.Explorer.Menu.View
    exposing
        ( menuView
        , menuNav
        , menuContent
        )

import Html exposing (Html)
import Html.Attributes
import ContextMenu exposing (ContextMenu)
import OS.WindowManager.MenuHandler.View
    exposing
        ( menuForCreator
        , menuViewCreator
        )
import Apps.Instances.Models exposing (InstanceID)
import Apps.Explorer.Models exposing (Model)
import Apps.Explorer.Messages as ExplorerMsg
import Apps.Explorer.Menu.Messages exposing (Msg(..), MenuAction(..))
import Apps.Explorer.Menu.Models exposing (Menu(..))


menuView : Model -> InstanceID -> Html ExplorerMsg.Msg
menuView model id =
    menuViewCreator
        ExplorerMsg.MenuMsg
        model
        model.menu
        MenuMsg
        (menu id)


menuFor : Menu -> Html.Attribute ExplorerMsg.Msg
menuFor context =
    menuForCreator ExplorerMsg.MenuMsg MenuMsg context


menu : InstanceID -> Model -> Menu -> List (List ( ContextMenu.Item, Msg ))
menu id model context =
    case context of
        MenuNav ->
            [ [ ( ContextMenu.item "A", MenuClick DoA id )
              , ( ContextMenu.item "B", MenuClick DoB id )
              ]
            ]

        MenuContent ->
            [ [ ( ContextMenu.item "c", MenuClick DoB id )
              , ( ContextMenu.item "d", MenuClick DoA id )
              ]
            ]


menuNav : Html.Attribute ExplorerMsg.Msg
menuNav =
    menuFor MenuNav


menuContent : Html.Attribute ExplorerMsg.Msg
menuContent =
    menuFor MenuContent
