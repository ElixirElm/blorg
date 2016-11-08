module Type.Blorg.Event exposing(..)

withEvent (model, cmd) =
  (model, cmd, Nothing)

withoutEvent update msg model =
  let
    (model, cmd, _) = update msg model
  in
    (model, cmd)

discardAndLogEvent update msg model =
  let
    (model, cmd, event) = update msg model
    _ = Debug.log "event" event
  in
    (model, cmd)
