module OS.Header.Models exposing (..)


type OpenMenu
    = NothingOpen
    | GatewayOpen
    | BounceOpen
    | EndpointOpen
    | ChatOpen
    | ServersOpen
    | AccountOpen
    | NetworkOpen


type alias Model =
    { openMenu : OpenMenu
    , mouseSomewhereInside : Bool
    }


initialModel : Model
initialModel =
    { openMenu = NothingOpen
    , mouseSomewhereInside = False
    }
