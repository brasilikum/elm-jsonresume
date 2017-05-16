module Jsonresume exposing (..)

import Json.Decode exposing (nullable, int, string, float, Decoder, decodeString, list, maybe)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)


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
        |> optional "work" (list workDecoder) []
        |> optional "volunteer" (list volunteerDecoder) []
        |> optional "education" (list educationDecoder) []
        |> optional "awards" (list awardDecoder) []
        |> optional "publications" (list publicationDecoder) []
        |> optional "languages" (list languageDecoder) []
        |> optional "interests" (list interestDecoder) []
        |> optional "references" (list referenceDecoder) []


type alias Basics =
    { name : String
    , label : String
    , picture : String
    , email : String
    , phone : String
    , website : String
    , summary : String
    , location : Maybe Location
    , profiles : List Profile
    }


basicsDecoder : Decoder Basics
basicsDecoder =
    decode Basics
        |> required "name" string
        |> optional "label" string ""
        |> optional "picture" string ""
        |> optional "email" string ""
        |> optional "phone" string ""
        |> optional "website" string ""
        |> optional "summary" string ""
        |> optional "location" (nullable locationDecoder) Nothing
        |> optional "profiles" (list profilesDecoder) []


type alias Location =
    { address : String
    , postalCode : String
    , city : String
    , countryCode : String
    , region : String
    }


locationDecoder : Decoder Location
locationDecoder =
    decode Location
        |> optional "address" string ""
        |> optional "postalCode" string ""
        |> optional "city" string ""
        |> optional "countryCode" string ""
        |> optional "region" string ""


type alias Profile =
    { network : String
    , username : String
    , url : String
    }


profilesDecoder : Decoder Profile
profilesDecoder =
    decode Profile
        |> optional "network" string ""
        |> optional "username" string ""
        |> optional "url" string ""


type alias Work =
    { company : String
    , position : String
    , website : String
    , startDate : String
    , endDate : String
    , summary : String
    , highlights : List String
    }


workDecoder : Decoder Work
workDecoder =
    decode Work
        |> required "company" string
        |> required "position" string
        |> optional "website" string ""
        |> optional "startDate" string ""
        |> optional "endDate" string ""
        |> optional "summary" string ""
        |> optional "highlights" (list string) []


type alias Volunteer =
    { organization : String
    , position : String
    , website : String
    , startDate : String
    , endDate : String
    , summary : String
    , highlights : List String
    }


volunteerDecoder : Decoder Volunteer
volunteerDecoder =
    decode Volunteer
        |> required "organization" string
        |> required "position" string
        |> optional "website" string ""
        |> optional "startDate" string ""
        |> optional "endDate" string ""
        |> optional "summary" string ""
        |> optional "highlights" (list string) []


type alias Education =
    { institution : String
    , area : String
    , studyType : String
    , startDate : String
    , endDate : String
    , gpa : String
    , courses : List String
    }


educationDecoder : Decoder Education
educationDecoder =
    decode Education
        |> required "institution" string
        |> required "area" string
        |> optional "studyType" string ""
        |> optional "startDate" string ""
        |> optional "endDate" string ""
        |> optional "gpa" string ""
        |> optional "courses" (list string) []


type alias Award =
    { title : String
    , date : String
    , awarder : String
    , summary : String
    }


awardDecoder : Decoder Award
awardDecoder =
    decode Award
        |> required "title" string
        |> optional "date" string ""
        |> required "awarder" string
        |> optional "summary" string ""


type alias Publication =
    { name : String
    , publisher : String
    , releaseDate : String
    , website : String
    , summary : String
    }


publicationDecoder : Decoder Publication
publicationDecoder =
    decode Publication
        |> required "name" string
        |> required "publisher" string
        |> optional "releaseDate" string ""
        |> optional "website" string ""
        |> optional "summary" string ""


type alias Skill =
    { name : String
    , level : String
    , keywords : List String
    }


skillDecoder : Decoder Skill
skillDecoder =
    decode Skill
        |> required "name" string
        |> optional "level" string ""
        |> optional "keywords" (list string) []


type alias Language =
    { name : String
    , level : String
    }


languageDecoder : Decoder Language
languageDecoder =
    decode Language
        |> required "name" string
        |> optional "level" string ""


type alias Interest =
    { name : String
    , keywords : List String
    }


interestDecoder : Decoder Interest
interestDecoder =
    decode Interest
        |> required "name" string
        |> optional "keywords" (list string) []


type alias Reference =
    { name : String
    , reference : String
    }


referenceDecoder : Decoder Reference
referenceDecoder =
    decode Reference
        |> required "name" string
        |> required "reference" string
