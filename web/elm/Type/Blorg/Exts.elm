--
--
module Type.Blorg.Exts exposing(..)
-- Probably reusable extentions out side the project

import Date exposing(..)
-- Import Json Decode
import Json.Decode as Decode exposing(Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

decodeDate =
  Decode.customDecoder Decode.string Date.fromString

decodeNullOr decoder =
  Decode.oneOf
    [ Decode.null Nothing
    , Decode.map Just decoder
    ]
