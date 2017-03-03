module Type.Blorg.Event exposing(..)

withEvent (model, cmd) =
  (model, cmd, Nothing)

withoutEvent update msg model =
  let
    (model1, cmd1, _) = update msg model
  in
    (model1, cmd1)

discardAndLogEvent update msg model =
  let
    (model1, cmd1, event1) = update msg model
    _ = Debug.log "event" event1
  in
    (model1, cmd1)
