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
-- MAIN


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- SUBSCRIPTIONS


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
            case (decodeString resumeDecoder jsonString) of
                Ok user ->
                    ( { model | user = Just user, errorMsg = Nothing }, Cmd.none )

                Err errmsg ->
                    ( { model | errorMsg = Just errmsg }, Cmd.none )



-- MODEL


type alias Model =
    { user : Maybe Resume
    , errorMsg : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { user = Nothing, errorMsg = Nothing }, Cmd.none )


type alias Resume =
    { basics : Basics
    , work : List Work
    , volunteer : List Volunteer
    , education : List Education
    , awards : List Award
    , publications : List Publication
    , languages : List Language
    , interests : List Interest
    , references : List Reference
    }


resumeDecoder : Decoder Resume
resumeDecoder =
    decode Resume
        |> required "basics" basicsDecoder
        |> required "work" (list workDecoder)
        |> required "volunteer" (list volunteerDecoder)
        |> required "education" (list educationDecoder)
        |> required "awards" (list awardDecoder)
        |> required "publications" (list publicationDecoder)
        |> required "languages" (list languageDecoder)
        |> required "interests" (list interestDecoder)
        |> required "references" (list referenceDecoder)


type alias Basics =
    { name : String
    , label : Maybe String
    , picture : Maybe String
    , email : Maybe String
    , phone : Maybe String
    , website : Maybe String
    , summary : Maybe String
    , location : Maybe Location
    , profiles : List Profile
    }


basicsDecoder : Decoder Basics
basicsDecoder =
    decode Basics
        |> required "name" string
        |> required "label" (nullable string)
        |> required "picture" (nullable string)
        |> required "email" (nullable string)
        |> required "phone" (nullable string)
        |> required "website" (nullable string)
        |> required "summary" (nullable string)
        |> required "location" (nullable locationDecoder)
        |> required "profiles" (list profilesDecoder)


type alias Location =
    { address : Maybe String
    , postalCode : Maybe String
    , city : Maybe String
    , countryCode : Maybe String
    , region : Maybe String
    }


locationDecoder : Decoder Location
locationDecoder =
    decode Location
        |> required "address" (nullable string)
        |> required "postalCode" (nullable string)
        |> required "city" (nullable string)
        |> required "countryCode" (nullable string)
        |> required "region" (nullable string)


type alias Profile =
    { network : Maybe String
    , username : Maybe String
    , url : Maybe String
    }


profilesDecoder : Decoder Profile
profilesDecoder =
    decode Profile
        |> required "network" (nullable string)
        |> required "username" (nullable string)
        |> required "url" (nullable string)


type alias Work =
    { company : String
    , position : String
    , website : Maybe String
    , startDate : Maybe String
    , endDate : Maybe String
    , summary : Maybe String
    , highlights : List String
    }


workDecoder : Decoder Work
workDecoder =
    decode Work
        |> required "company" string
        |> required "position" string
        |> required "website" (nullable string)
        |> required "startDate" (nullable string)
        |> required "endDate" (nullable string)
        |> required "summary" (nullable string)
        |> required "highlights" (list string)


type alias Volunteer =
    { organization : String
    , position : String
    , website : Maybe String
    , startDate : Maybe String
    , endDate : Maybe String
    , summary : Maybe String
    , highlights : List String
    }


volunteerDecoder : Decoder Volunteer
volunteerDecoder =
    decode Volunteer
        |> required "organization" string
        |> required "position" string
        |> required "website" (nullable string)
        |> required "startDate" (nullable string)
        |> required "endDate" (nullable string)
        |> required "summary" (nullable string)
        |> required "highlights" (list string)


type alias Education =
    { institution : String
    , area : Maybe String
    , studyType : Maybe String
    , startDate : Maybe String
    , endDate : Maybe String
    , gpa : Maybe String
    , courses : List String
    }


educationDecoder : Decoder Education
educationDecoder =
    decode Education
        |> required "institution" string
        |> required "area" (nullable string)
        |> required "studyType" (nullable string)
        |> required "startDate" (nullable string)
        |> required "endDate" (nullable string)
        |> required "gpa" (nullable string)
        |> required "courses" (list string)


type alias Award =
    { title : String
    , date : Maybe String
    , awarder : Maybe String
    , summary : Maybe String
    }


awardDecoder : Decoder Award
awardDecoder =
    decode Award
        |> required "title" string
        |> required "date" (nullable string)
        |> required "awarder" (nullable string)
        |> required "summary" (nullable string)


type alias Publication =
    { name : String
    , publisher : String
    , releaseDate : Maybe String
    , website : Maybe String
    , summary : Maybe String
    }


publicationDecoder : Decoder Publication
publicationDecoder =
    decode Publication
        |> required "name" string
        |> required "publisher" string
        |> required "releaseDate" (nullable string)
        |> required "website" (nullable string)
        |> required "summary" (nullable string)


type alias Skill =
    { name : String
    , level : Maybe String
    , keywords : List String
    }


skillDecoder : Decoder Skill
skillDecoder =
    decode Skill
        |> required "name" string
        |> required "level" (nullable string)
        |> required "keywords" (list string)


type alias Language =
    { name : String
    , level : Maybe String
    }


languageDecoder : Decoder Language
languageDecoder =
    decode Language
        |> required "name" string
        |> required "level" (nullable string)


type alias Interest =
    { name : String
    , keywords : List String
    }


interestDecoder : Decoder Interest
interestDecoder =
    decode Interest
        |> required "name" string
        |> required "keywords" (list string)


type alias Reference =
    { name : String
    , reference : String
    }


referenceDecoder : Decoder Reference
referenceDecoder =
    decode Reference
        |> required "name" string
        |> required "reference" string



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decode ] [ text "decode" ]
        , text (toString model)
        ]


jsonString : String
jsonString =
    """
{
  "basics": {
    "name": "John Doe",
    "label": "Programmer",
    "picture": "",
    "email": "john@gmail.com",
    "phone": "(912) 555-4321",
    "website": "http://johndoe.com",
    "summary": "A summary of John Doe...",
    "location": {
      "address": "2712 Broadway St",
      "postalCode": "CA 94115",
      "city": "San Francisco",
      "countryCode": "US",
      "region": "California"
    },
    "profiles": [{
      "network": "Twitter",
      "username": "john",
      "url": "http://twitter.com/john"
    }]
  },
  "work": [{
    "company": "Company",
    "position": "President",
    "website": "http://company.com",
    "startDate": "2013-01-01",
    "endDate": "2014-01-01",
    "summary": "Description...",
    "highlights": [
      "Started the company"
    ]
  }],
  "volunteer": [{
    "organization": "Organization",
    "position": "Volunteer",
    "website": "http://organization.com/",
    "startDate": "2012-01-01",
    "endDate": "2013-01-01",
    "summary": "Description...",
    "highlights": [
      "Awarded 'Volunteer of the Month'"
    ]
  }],
  "education": [{
    "institution": "University",
    "area": "Software Development",
    "studyType": "Bachelor",
    "startDate": "2011-01-01",
    "endDate": "2013-01-01",
    "gpa": "4.0",
    "courses": [
      "DB1101 - Basic SQL"
    ]
  }],
  "awards": [{
    "title": "Award",
    "date": "2014-11-01",
    "awarder": "Company",
    "summary": "There is no spoon."
  }],
  "publications": [{
    "name": "Publication",
    "publisher": "Company",
    "releaseDate": "2014-10-01",
    "website": "http://publication.com",
    "summary": "Description..."
  }],
  "skills": [{
    "name": "Web Development",
    "level": "Master",
    "keywords": [
      "HTML",
      "CSS",
      "Javascript"
    ]
  }],
  "languages": [{
    "name": "English",
    "level": "Native speaker"
  }],
  "interests": [{
    "name": "Wildlife",
    "keywords": [
      "Ferrets",
      "Unicorns"
    ]
  }],
  "references": [{
    "name": "Jane Doe",
    "reference": "Reference..."
  }]
}
"""
