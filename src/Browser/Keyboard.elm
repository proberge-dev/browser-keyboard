module Browser.Keyboard exposing (Event, onKeyUp, onKeyPress, onKeyDown)

{-|
# Description

`browser-keyboard` is intended to help with global keyboard event management.

# Event subscription functions

@docs onKeyUp, onKeyPress, onKeyDown

# Event data definition

@docs Event

-}

import Browser.Events as Events
import Json.Decode as Decode


{-| -}
type alias Event =
  { key : String
  , code : String
  , metaKey : Bool
  , repeat : Bool
  , ctrlKey : Bool
  , shiftKey : Bool
  , altKey : Bool
  }


with : String -> Decode.Decoder a -> Decode.Decoder (a -> b) -> Decode.Decoder b
with target is toProcess =
  toProcess |> Decode.andThen 
    (\v -> Decode.map v (Decode.at [ target ] is))


decodeEvent : Decode.Decoder Event
decodeEvent =
  Decode.succeed Event
    |> with "key" Decode.string
    |> with "code" Decode.string
    |> with "metaKey" Decode.bool
    |> with "repeat" Decode.bool
    |> with "ctrlKey" Decode.bool
    |> with "shiftKey" Decode.bool
    |> with "altKey" Decode.bool


{-| -}
onKeyUp : (Event -> msg) -> Sub msg
onKeyUp mapper =
  Events.onKeyUp (decodeEvent |> Decode.andThen (\event -> Decode.succeed <| mapper event))


{-| -}
onKeyPress : (Event -> msg) -> Sub msg
onKeyPress mapper =
  Events.onKeyPress (decodeEvent |> Decode.andThen (\event -> Decode.succeed <| mapper event))


{-| -}
onKeyDown : (Event -> msg) -> Sub msg
onKeyDown mapper =
  Events.onKeyDown (decodeEvent |> Decode.andThen (\event -> Decode.succeed <| mapper event))
