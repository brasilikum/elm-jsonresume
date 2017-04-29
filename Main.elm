module Main exposing (..)

import Html exposing (..)
import Json.Decode exposing (nullable, int, string, float, Decoder, decodeString, list)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Html.Events exposing (onClick)


--import Date
--import Html.Attributes exposing (..)
--import Navigation
--import Task exposing (perform)
--import Time exposing (Time, second)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Model =
    { user : Maybe User
    , errorMsg : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { user = Nothing, errorMsg = Nothing }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE


type Msg
    = Decode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Decode ->
            case (decodeString userDecoder jsonString) of
                Ok user ->
                    ( { model | user = Just user, errorMsg = Nothing }, Cmd.none )

                Err errmsg ->
                    ( { model | errorMsg = Just errmsg }, Cmd.none )


jsonString : String
jsonString =
    """
      {"id": 1, "email": "sam@example.com", "child": {"name":"georg"}}
    """



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decode ] [ text "decode" ]
        , text (toString model)
        ]


type alias User =
    { id : Int
    , email : Maybe String
    , name : String
    , percentExcited : Float
    , child : Child
    }


type alias Child =
    { name : String }


userDecoder : Decoder User
userDecoder =
    decode User
        |> required "id" int
        |> required "email" (nullable string)
        |> optional "name" string "fallback if name is not present"
        |> hardcoded 1.0
        |> required "child" childDecoder


childDecoder : Decoder Child
childDecoder =
    decode Child
        |> required "name" string
