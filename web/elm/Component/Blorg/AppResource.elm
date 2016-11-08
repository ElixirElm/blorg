--
--
module Component.Blorg.AppResource
  exposing
    ( Model, init, toRoute
    , Msg(GoTo), Event, update
    , view)

import Component.Blorg.NotFoundPage as NotFoundPage

import Component.Blorg.ArticlePage as ArticlePage
import Component.Blorg.ArticleListPage as ArticleListPage

import Type.Blorg.Article as Article

import Type.Blorg.AppRoute as AppRoute
  exposing
    ( AppRoute(NotInitialized, NotFound, Home, ArticleList,Article)
    )

import Type.Blorg.Event exposing(..)
import Type.Blorg.Config as Config
import Type.Blorg.Page as Page

-- Import Html
import Html exposing (Html, text, p)
import Html.App
-- Import Material
import Material
import Material.Button as Button
import Material.Grid exposing (grid, cell, size, Device(..), noSpacing)
import Material.Icon as Icon
import Material.List as Lists
import Material.Options as Options exposing (css, styled, div, span, img)
import Material.Table as Table
import Material.Textfield as Textfield
import Material.Typography as Typo
-- 
-- Sub Components


-- Auto generated get/set_NotFoundPage
get_NotFoundPage : Model -> Maybe NotFoundPage.Model
get_NotFoundPage model =
  case model.onDemand of
    NotFoundPageModel mdl -> Just mdl
    _ -> Nothing
set_NotFoundPage : NotFoundPage.Model -> Model -> Model
set_NotFoundPage value model =
  case model.onDemand of
    NotFoundPageModel mdl ->
      { model | onDemand = NotFoundPageModel value }
    _ -> model



-- Auto generated get/set_ArticlePage
get_ArticlePage : Model -> Maybe ArticlePage.Model
get_ArticlePage model =
  case model.onDemand of
    ArticlePageModel mdl -> Just mdl
    _ -> Nothing
set_ArticlePage : ArticlePage.Model -> Model -> Model
set_ArticlePage value model =
  case model.onDemand of
    ArticlePageModel mdl ->
      { model | onDemand = ArticlePageModel value }
    _ -> model



-- Auto generated get/set_ArticleListPage
get_ArticleListPage : Model -> Maybe ArticleListPage.Model
get_ArticleListPage model =
  case model.onDemand of
    ArticleListPageModel mdl -> Just mdl
    _ -> Nothing
set_ArticleListPage : ArticleListPage.Model -> Model -> Model
set_ArticleListPage value model =
  case model.onDemand of
    ArticleListPageModel mdl ->
      { model | onDemand = ArticleListPageModel value }
    _ -> model


-- MODEL

type alias Model
  = { route : AppRoute
    , onDemand: OnDemand
    , mdl : Material.Model
      -- Boilerplate: model store for any and all Mdl components you use.
    }

type OnDemand
  = NoPage
  | NotFoundPageModel NotFoundPage.Model
  | ArticlePageModel ArticlePage.Model
  | ArticleListPageModel ArticleListPage.Model

init : (Model, Cmd Msg)
init =
  let
    (notFoundPage, notFoundCmd) = NotFoundPage.init
  in
    ( { route = AppRoute.NotInitialized
      , onDemand = NoPage
      , mdl = Material.model
      }
    , Cmd.none
    )

toRoute : Model -> AppRoute
toRoute model =
  model.route
-- ACTION, UPDATE

type Msg
  = Mdl (Material.Msg Msg)
  -- Boilerplate: Msg clause for internal Mdl messages.
  | GoTo AppRoute
  | NotFoundPage NotFoundPage.Msg
  | ArticlePage ArticlePage.Msg
  | ArticleListPage ArticleListPage.Msg

type alias Event
  = ()

update : Msg -> Model -> (Model, Cmd Msg, Maybe Event)
update msg model =
  case msg of
    Mdl act ->
      withEvent <| Material.update act model
    
    NotFoundPage act ->
      update_NotFoundPage act model
    --
    
    ArticlePage act ->
      update_ArticlePage act model
    --
    
    ArticleListPage act ->
      update_ArticleListPage act model
    --
    GoTo route ->
      gotoRoute route model

gotoRoute : AppRoute -> Model -> (Model, Cmd Msg, Maybe Event)
gotoRoute route model =
  let
    _ = Debug.log "gotoRoute " <| toString route
  in
    case route of
      AppRoute.NotInitialized -> (model, Cmd.none, Nothing)
      AppRoute.Home -> (model, Cmd.none, Nothing) -- Redirected. Never comes
      AppRoute.NotFound ->
        
          let
            (subModel, subCmd) = NotFoundPage.init 
          in
            ( {model
              | onDemand = NotFoundPageModel subModel
              , route = route
              }
            , Cmd.map NotFoundPage subCmd
            , Nothing
            )

      AppRoute.Article id ->
        
          let
            (subModel, subCmd) = ArticlePage.init id
          in
            ( {model
              | onDemand = ArticlePageModel subModel
              , route = route
              }
            , Cmd.map ArticlePage subCmd
            , Nothing
            )

      AppRoute.ArticleList ->
        
          let
            (subModel, subCmd) = ArticleListPage.init 
          in
            ( {model
              | onDemand = ArticleListPageModel subModel
              , route = route
              }
            , Cmd.map ArticleListPage subCmd
            , Nothing
            )

--       _ ->
--         let
--             _ = Debug.log "AppResource unknown route " route
--         in
--           (model, Cmd.none, Nothing)

-- Auto generated update_NotFoundPage
--   Expects: updateOnEventFrom_NotFoundPage newEvent myModel
update_NotFoundPage : NotFoundPage.Msg -> Model -> ( Model, Cmd Msg, Maybe Event )
update_NotFoundPage act model =
  let
    maybeOldValue = (get_NotFoundPage model)
    (myModel, myCmd, maybeNewEvent) = case maybeOldValue of
      Nothing ->
        (model, Cmd.none, Nothing)
      Just oldValue ->
        let
          (newValue, newCmd, wantedEvent)
            = NotFoundPage.update act oldValue
        in
          ( model |> set_NotFoundPage newValue, Cmd.map NotFoundPage newCmd, wantedEvent)
  in
    case maybeNewEvent of
      Nothing ->
        (myModel, myCmd, Nothing)
      Just newEvent ->
        let
          (afterModel, afterCmd, afterEvent)
            = updateOnEventFrom_NotFoundPage newEvent myModel
        in
          (afterModel, Cmd.batch [myCmd, afterCmd], afterEvent)
updateOnEventFrom_NotFoundPage :
  NotFoundPage.Event -> Model -> ( Model, Cmd Msg, Maybe Event )
updateOnEventFrom_NotFoundPage event model =
  (model, Cmd.none, Nothing)

-- Auto generated update_ArticlePage
--   Expects: updateOnEventFrom_ArticlePage newEvent myModel
update_ArticlePage : ArticlePage.Msg -> Model -> ( Model, Cmd Msg, Maybe Event )
update_ArticlePage act model =
  let
    maybeOldValue = (get_ArticlePage model)
    (myModel, myCmd, maybeNewEvent) = case maybeOldValue of
      Nothing ->
        (model, Cmd.none, Nothing)
      Just oldValue ->
        let
          (newValue, newCmd, wantedEvent)
            = ArticlePage.update act oldValue
        in
          ( model |> set_ArticlePage newValue, Cmd.map ArticlePage newCmd, wantedEvent)
  in
    case maybeNewEvent of
      Nothing ->
        (myModel, myCmd, Nothing)
      Just newEvent ->
        let
          (afterModel, afterCmd, afterEvent)
            = updateOnEventFrom_ArticlePage newEvent myModel
        in
          (afterModel, Cmd.batch [myCmd, afterCmd], afterEvent)
updateOnEventFrom_ArticlePage :
  ArticlePage.Event -> Model -> ( Model, Cmd Msg, Maybe Event )
updateOnEventFrom_ArticlePage event model =
  (model, Cmd.none, Nothing)
-- Auto generated update_ArticleListPage
--   Expects: updateOnEventFrom_ArticleListPage newEvent myModel
update_ArticleListPage : ArticleListPage.Msg -> Model -> ( Model, Cmd Msg, Maybe Event )
update_ArticleListPage act model =
  let
    maybeOldValue = (get_ArticleListPage model)
    (myModel, myCmd, maybeNewEvent) = case maybeOldValue of
      Nothing ->
        (model, Cmd.none, Nothing)
      Just oldValue ->
        let
          (newValue, newCmd, wantedEvent)
            = ArticleListPage.update act oldValue
        in
          ( model |> set_ArticleListPage newValue, Cmd.map ArticleListPage newCmd, wantedEvent)
  in
    case maybeNewEvent of
      Nothing ->
        (myModel, myCmd, Nothing)
      Just newEvent ->
        let
          (afterModel, afterCmd, afterEvent)
            = updateOnEventFrom_ArticleListPage newEvent myModel
        in
          (afterModel, Cmd.batch [myCmd, afterCmd], afterEvent)
updateOnEventFrom_ArticleListPage :
  ArticleListPage.Event -> Model -> ( Model, Cmd Msg, Maybe Event )
updateOnEventFrom_ArticleListPage event model =
  case event of
    ArticleListPage.GoToArticle article ->
      gotoRoute (Article.toRoute article) model

-- VIEW

view : Model -> Html Msg
view model =
  Page.layout Mdl model.mdl [ viewRoute model ]

viewRoute : Model -> Html Msg
viewRoute model =
  case model.route of
    AppRoute.NotInitialized ->
      text "NotInitialized"
    AppRoute.Home ->
      text "Why Home?"
    AppRoute.NotFound ->
      
            ( let maybeSub = get_NotFoundPage model
              in
                              case maybeSub of
                                Nothing -> text ""
                                Just sub ->
                                  Html.App.map NotFoundPage (NotFoundPage.view sub)
            )

    (AppRoute.Article _) ->
      
            ( let maybeSub = get_ArticlePage model
              in
                              case maybeSub of
                                Nothing -> text ""
                                Just sub ->
                                  Html.App.map ArticlePage (ArticlePage.view sub)
            )

    AppRoute.ArticleList ->
      
            ( let maybeSub = get_ArticleListPage model
              in
                              case maybeSub of
                                Nothing -> text ""
                                Just sub ->
                                  Html.App.map ArticleListPage (ArticleListPage.view sub)
            )


--     _ ->
--       text <| "Unhandled Route" ++ toString model.route
