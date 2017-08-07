module Game.Requests.Bootstrap
    exposing
        ( Response(..)
        , RawResponse
        , request
        , receive
        )

import Json.Decode exposing (Decoder, Value, decodeValue, value)
import Json.Decode.Pipeline exposing (decode, required)
import Requests.Requests as Requests
import Requests.Topics exposing (Topic(..))
import Requests.Types exposing (ConfigSource, Code(..), emptyPayload)
import Game.Messages exposing (..)


type Response
    = OkResponse RawResponse
    | NoOp


type alias RawResponse =
    { account : Value
    , meta : Value
    , servers : Value
    }


request : String -> ConfigSource a -> Cmd Msg
request account =
    Requests.request AccountBootstrapTopic
        (BootstrapRequest >> Request)
        (Just account)
        emptyPayload


receive : Code -> Value -> Response
receive code json =
    case code of
        OkCode ->
            json
                |> decoder
                |> Result.map OkResponse
                |> Requests.report

        _ ->
            NoOp



-- internals


decoder : Value -> Result String RawResponse
decoder =
    decodeValue response


response : Decoder RawResponse
response =
    decode RawResponse
        |> required "account" value
        |> required "meta" value
        |> required "servers" value