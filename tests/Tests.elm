module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import Jsonresume exposing (..)
import Json.Decode exposing (decodeString)


all : Test
all =
    describe "JSONresume Elm Test Suite"
        [ describe "Resume Decoder"
            [ test "Empty" <|
                \() ->
                    Expect.fail (decodeString resumeDecoder)
            , test "String.left" <|
                \() ->
                    Expect.equal "a" (String.left 1 "abcdefg")
            , test "This test should fail - you should remove it" <|
                \() ->
                    Expect.fail "Failed as expected!"
            ]
        ]
