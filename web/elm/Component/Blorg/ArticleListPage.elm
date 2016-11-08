-- TODO Show errors on a Shackbar.toast

--
--
module Component.Blorg.ArticleListPage
  exposing(Model, init, initialModel, Msg, Event(GoToArticle), update, view)


import Type.Blorg.Article exposing(..)
import Component.Blorg.ArticleListView as ArticleListView
  exposing (Event(GoToArticle))
  
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
import Http
import Json.Decode as Json
import Exts.RemoteData as RemoteData exposing(..)

import Material.Spinner as Loading
import Material.Progress as Loading

import Type.Blorg.Exts exposing(..)
import Type.Blorg.Event exposing(..)

-- Sub Components


-- Auto generated get/set_ArticleListView
get_ArticleListView : Model -> Maybe ArticleListView.Model
get_ArticleListView model =
  case model.onDemand of
    ArticleListViewModel mdl -> Just mdl
    _ -> Nothing
set_ArticleListView : ArticleListView.Model -> Model -> Model
set_ArticleListView value model =
  case model.onDemand of
    ArticleListViewModel mdl ->
      { model | onDemand = ArticleListViewModel value }
    _ -> model


-- MODEL

type alias Model =
  { responseForArticleList : WebData ArticleList
  , onDemand: OnDemand
  , mdl : Material.Model
  }

init : (Model, Cmd Msg)
init = (initialModel, loadArticleList)

initialModel : Model
initialModel = Model NotAsked NoData Material.model

type OnDemand
  = NoData
  | ArticleListViewModel ArticleListView.Model

-- ACTION, UPDATE

type Msg
  = ResponseForArticleList (WebData ArticleList)
  | ArticleListView ArticleListView.Msg
  | Mdl (Material.Msg Msg)

type Event 
  = GoToArticle Article

update : Msg -> Model -> (Model, Cmd Msg, Maybe Event)
update msg model =
  case msg of
    ResponseForArticleList responseForArticleList ->
      case responseForArticleList of
        Success articleList ->
          ( { model
            | onDemand = ArticleListViewModel <| ArticleListView.initialModel articleList
            , responseForArticleList = responseForArticleList
            }
          , Cmd.none, Nothing )
        _ -> (model, Cmd.none, Nothing)
    
    ArticleListView act ->
      update_ArticleListView act model
    --
    Mdl msg' ->
      withEvent <| Material.update msg' model

-- Auto generated update_ArticleListView
--   Expects: updateOnEventFrom_ArticleListView newEvent myModel
update_ArticleListView : ArticleListView.Msg -> Model -> ( Model, Cmd Msg, Maybe Event )
update_ArticleListView act model =
  let
    maybeOldValue = (get_ArticleListView model)
    (myModel, myCmd, maybeNewEvent) = case maybeOldValue of
      Nothing ->
        (model, Cmd.none, Nothing)
      Just oldValue ->
        let
          (newValue, newCmd, wantedEvent)
            = ArticleListView.update act oldValue
        in
          ( model |> set_ArticleListView newValue, Cmd.map ArticleListView newCmd, wantedEvent)
  in
    case maybeNewEvent of
      Nothing ->
        (myModel, myCmd, Nothing)
      Just newEvent ->
        let
          (afterModel, afterCmd, afterEvent)
            = updateOnEventFrom_ArticleListView newEvent myModel
        in
          (afterModel, Cmd.batch [myCmd, afterCmd], afterEvent)
updateOnEventFrom_ArticleListView :
  ArticleListView.Event -> Model -> ( Model, Cmd Msg, Maybe Event )
updateOnEventFrom_ArticleListView event model =
  case event of
    ArticleListView.GoToArticle article ->
      (model, Cmd.none, Just (GoToArticle article))

-- VIEW

view : Model -> Html Msg
view model =
  Page.body ""
    [ case model.responseForArticleList of
        NotAsked -> viewSpinner
        Loading -> viewSpinner
        Failure err -> Page.body "Error" [text <| toString err]
        Success article ->
          
            ( let maybeSub = get_ArticleListView model
              in
                              case maybeSub of
                                Nothing -> text ""
                                Just sub ->
                                  Html.App.map ArticleListView (ArticleListView.view sub)
            )

    ]

viewSpinner = Loading.spinner [ Loading.active True ]

-- HTTP

loadArticleList : Cmd Msg
loadArticleList =
  let
    url
      = Debug.log "Loading"
      <| Config.apiHost ++ "/api/v1/articles/"
  in
    (Http.get decodeArticleListData url)
      |> RemoteData.asCmd
      |> Cmd.map ResponseForArticleList
