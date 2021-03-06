module Apps.Browser.Pages.Webserver.View exposing (view)

import Html exposing (..)
import Html.CssHelpers
import Game.Data as Game
import Game.Servers.Shared as Servers
import Game.Meta.Types.Network exposing (NIP)
import Apps.Apps as Apps
import Apps.Browser.Resources exposing (Classes(..), prefix)
import Apps.Browser.Pages.Webserver.Config exposing (Config)
import Apps.Browser.Pages.Webserver.Messages exposing (Msg(..))
import Apps.Browser.Pages.Webserver.Models exposing (Model)
import Apps.Browser.Widgets.HackingToolkit.View as HackingToolkit exposing (hackingToolkit)
import Apps.Browser.Widgets.HackingPanel.View as HackingPanel exposing (hackingPanel)
import Apps.Browser.Widgets.PublicFiles.View as PublicFiles exposing (publicFiles)


{ id, class, classList } =
    Html.CssHelpers.withNamespace prefix


hackingToolkitConfig : Config msg -> Bool -> HackingToolkit.Config msg
hackingToolkitConfig { toMsg, onLogin, onCrack, onAnyMap } showPassword =
    { onInput = UpdatePasswordField >> toMsg
    , onLogin = onLogin
    , onCrack = onCrack
    , onAnyMap = onAnyMap
    , onEnterPanel = toMsg <| SetShowingPanel True
    , showPassword = showPassword
    }


publicFilesConfig : Config msg -> NIP -> PublicFiles.Config msg
publicFilesConfig { onPublicDownload } source =
    { onPublicDownload = onPublicDownload source
    }


hackingPanelConfig : Config msg -> HackingPanel.Config msg
hackingPanelConfig { toMsg, onLogout, onSelectEndpoint, onAnyMap, onOpenApp } =
    { onLogout = onLogout
    , onSelectEndpoint = onSelectEndpoint
    , onAnyMap = onAnyMap
    , onOpenApp = onOpenApp
    , onSetShowingPanel = SetShowingPanel >> toMsg
    , apps =
        [ Apps.TaskManagerApp
        , Apps.ConnManagerApp
        , Apps.LogViewerApp
        , Apps.ExplorerApp
        ]
    , allowAnyMap = True
    , allowSelectEndpoint = True
    }


view : Config msg -> Game.Data -> Model -> Html msg
view config data model =
    let
        -- this is cheating:
        cid =
            Servers.EndpointCId model.toolkit.target

        endpointMember =
            List.member cid (Game.getEndpoints data)
    in
        if (model.showingPanel && endpointMember) then
            hackingPanel (hackingPanelConfig config) model.toolkit.target
        else
            viewPre config data (not endpointMember) model


viewPre : Config msg -> Game.Data -> Bool -> Model -> Html msg
viewPre config data showPassword model =
    div [ class [ AutoHeight ] ]
        [ (if model.custom == "" then
            "No Webserver running"
           else
            model.custom
          )
            |> text
            |> List.singleton
            |> div [ class [ DummyTitle ] ]
        , publicFiles
            (publicFilesConfig config model.toolkit.target)
            model.publicFiles
        , hackingToolkit
            (hackingToolkitConfig config showPassword)
            model.toolkit
        ]
