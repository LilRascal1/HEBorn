module Core.Models exposing (Model, Flags
                            , initialModel)


import Requests.Models
import Router.Router exposing (Route)
import Game.Models
import OS.Models
import Apps.Explorer.Models
import Apps.Login.Models
import Apps.SignUp.Models


type alias Model =
    { appLogin : Apps.Login.Models.Model
    , appSignUp : Apps.SignUp.Models.Model
    , appExplorer : Apps.Explorer.Models.Model
    , route : Route
    , requests : Requests.Models.Model
    , game : Game.Models.GameModel
    , os : OS.Models.Model
    }


type alias Flags =
    { seed : Int
    }


initialModel : Router.Router.Route -> Int -> Model
initialModel route seedInt =
    { appLogin = Apps.Login.Models.initialModel
    , appSignUp = Apps.SignUp.Models.initialModel
    , appExplorer = Apps.Explorer.Models.initialModel
    , route = route
    , requests = Requests.Models.initialModel seedInt
    , game = Game.Models.initialModel
    , os = OS.Models.initialModel
    }

