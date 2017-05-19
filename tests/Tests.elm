module Tests exposing (..)

import Test exposing (..)
import Expect
import Jsonresume exposing (..)
import Json.Decode exposing (decodeString)


all : Test
all =
    describe "JSONresume Elm Test Suite"
        [ describe "basicsDecoder"
            [ test "Empty" <|
                \() ->
                    Expect.equal
                        (decodeString basicsDecoder "{}")
                        (Err "Expecting an object with a field named `name` but instead got: {}")
            , test "only name" <|
                \() ->
                    Expect.equal
                        (decodeString basicsDecoder
                            """
                            {"name":"G"}
                            """
                        )
                        (Basics "G" "" "" "" "" "" "" Nothing [] |> Ok)
            ]
        , describe "locationDecoder"
            [ test "Empty" <|
                \() ->
                    Expect.equal
                        (decodeString locationDecoder "{}")
                        (Location "" "" "" "" "" |> Ok)
            , test "Only one value" <|
                \() ->
                    Expect.equal
                        (decodeString locationDecoder
                            """
                            {"countryCode": "DE"}
                            """
                        )
                        (Location "" "" "" "DE" "" |> Ok)
            ]
        , describe "profileDecoder"
            [ test "Empty" <|
                \() ->
                    Expect.equal
                        (decodeString profileDecoder "{}")
                        (Err "Expecting an object with a field named `username` but instead got: {}")
            , test "Only one value" <|
                \() ->
                    Expect.equal
                        (decodeString profileDecoder
                            """
                            {"username": "brasilikum", "network": "GitHub"}
                            """
                        )
                        (Profile "GitHub" "brasilikum" "" |> Ok)
            ]
        , describe "resumeDecoder"
            [ test "Empty" <|
                \() ->
                    Expect.equal
                        (decodeString resumeDecoder "{}")
                        (Err "Expecting an object with a field named `basics` but instead got: {}")
            , test "Only Basics" <|
                \() ->
                    Expect.equal
                        (decodeString resumeDecoder """
                            {
                            "basics": {
                              "name": "John Doe"
                              }
                            }
                          """)
                        (Resume
                            (Basics "John Doe" "" "" "" "" "" "" Nothing [])
                            []
                            []
                            []
                            []
                            []
                            []
                            []
                            []
                            []
                            |> Ok
                        )
            , test "Example from jsonresume.org" <|
                \() ->
                    Expect.equal
                        (decodeString resumeDecoder """
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
                                        """)
                        (Resume
                            (Basics "John Doe"
                                "Programmer"
                                ""
                                "john@gmail.com"
                                "(912) 555-4321"
                                "http://johndoe.com"
                                "A summary of John Doe..."
                                (Just
                                    (Location "2712 Broadway St"
                                        "CA 94115"
                                        "San Francisco"
                                        "US"
                                        "California"
                                    )
                                )
                                [ (Profile "Twitter" "john" "http://twitter.com/john") ]
                            )
                            [ (Work "Company" "President" "http://company.com" "2013-01-01" "2014-01-01" "Description..." [ ("Started the company") ]) ]
                            [ (Volunteer "Organization" "Volunteer" "http://organization.com/" "2012-01-01" "2013-01-01" "Description..." [ "Awarded 'Volunteer of the Month'" ]) ]
                            [ (Education "University" "Software Development" "Bachelor" "2011-01-01" "2013-01-01" "4.0" [ "DB1101 - Basic SQL" ]) ]
                            [ (Award "Award" "2014-11-01" "Company" "There is no spoon.") ]
                            [ (Publication "Publication" "Company" "2014-10-01" "http://publication.com" "Description...") ]
                            [ (Skill "Web Development" "Master" [ "HTML", "CSS", "Javascript" ]) ]
                            [ (Language "English" "Native speaker") ]
                            [ (Interest "Wildlife" [ "Ferrets", "Unicorns" ]) ]
                            [ (Reference "Jane Doe" "Reference...") ]
                            |> Ok
                        )
            ]
        ]
