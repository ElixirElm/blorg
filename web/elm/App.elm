--
--
import Type.Blorg.Event exposing(..)

import Type.Blorg.AppRoute as AppRoute
  exposing
    ( AppRoute(NotInitialized, NotFound, Home)
    )

import Component.Blorg.AppResource as AppResource
  exposing (Msg(GoTo))

-- Import Html
import Html exposing (Html, text, p)
import Html.App
import Navigation
import RouteUrl as Routing
import String

-- Sub Components


-- Auto generated get/set_AppResource
get_AppResource : Model -> Maybe AppResource.Model
get_AppResource model = Just model.appResource

set_AppResource : AppResource.Model -> Model -> Model
set_AppResource value model = { model | appResource = value }


-- MODEL

type alias Model =
  { appResource : AppResource.Model }

init : (Model, Cmd Msg)
init =
  let
    (res, resCmd) = AppResource.init
  in
    ( Model res, Cmd.map AppResource resCmd  )

-- ACTION, UPDATE

type Msg
  = AppResource AppResource.Msg

type alias Event
  = ()

update : Msg -> Model -> (Model, Cmd Msg, Maybe Event)
update msg model =
  case msg of
    
    AppResource act ->
      update_AppResource act model
    --

-- Auto generated update_AppResource
--   Expects: updateOnEventFrom_AppResource newEvent myModel
update_AppResource : AppResource.Msg -> Model -> ( Model, Cmd Msg, Maybe Event )
update_AppResource act model =
  let
    maybeOldValue = (get_AppResource model)
    (myModel, myCmd, maybeNewEvent) = case maybeOldValue of
      Nothing ->
        (model, Cmd.none, Nothing)
      Just oldValue ->
        let
          (newValue, newCmd, wantedEvent)
            = AppResource.update act oldValue
        in
          ( model |> set_AppResource newValue, Cmd.map AppResource newCmd, wantedEvent)
  in
    case maybeNewEvent of
      Nothing ->
        (myModel, myCmd, Nothing)
      Just newEvent ->
        let
          (afterModel, afterCmd, afterEvent)
            = updateOnEventFrom_AppResource newEvent myModel
        in
          (afterModel, Cmd.batch [myCmd, afterCmd], afterEvent)
updateOnEventFrom_AppResource
  : AppResource.Event -> Model -> ( Model, Cmd Msg, Maybe Event )
updateOnEventFrom_AppResource event model =
  (model, Cmd.none, Nothing)

-- VIEW

view : Model -> Html Msg
view model =
  
            ( let maybeSub = get_AppResource model
              in
                              case maybeSub of
                                Nothing -> text ""
                                Just sub ->
                                  Html.App.map AppResource (AppResource.view sub)
            )


-- ROUTING

delta2url : Model -> Model -> Maybe Routing.UrlChange
delta2url model1 model2 =
  if AppResource.toRoute(model1.appResource) /= AppResource.toRoute(model2.appResource) then
    { entry = Routing.NewEntry
    , url = "#" ++ (AppRoute.toPath <| AppResource.toRoute model2.appResource)
    } |> Just
  else
    Nothing

location2messages : Navigation.Location -> List Msg
location2messages location =
  let
    maybeRoute = AppRoute.toRoute <| String.dropLeft 1 location.hash
--     _ = Debug.log "maybeRoute " maybeRoute
  in
    case maybeRoute of
      Nothing -> [ AppResource <| GoTo NotFound]
      Just route -> [ AppResource <| GoTo <| AppRoute.doRedirects route ]

-- APP

main : Program Never
main =
  Routing.program
  { delta2url = delta2url
  , location2messages = location2messages
  , init = init
  , view = view
  , subscriptions = always Sub.none
  , update = withoutEvent update
  }
