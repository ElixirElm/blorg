-- TODO Show errors on a Shackbar.toast

--
--
module Component.Blorg.ArticlePage
  exposing(Model, init, initialModel, Msg, Event, update, view)


import Type.Blorg.Article exposing(..)
import Component.Blorg.ArticleView as ArticleView

import Type.Blorg.Config as Config
import Type.Blorg.Page as Page

-- Import Html
import Html exposing (Html, text, p)

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
import RemoteData exposing(..)

import Material.Spinner as Loading
import Material.Progress as Loading

import Type.Blorg.Exts exposing(..)
import Type.Blorg.Event exposing(..)

-- Sub Components


-- Auto generated get/set_ArticleView
get_ArticleView : Model -> Maybe ArticleView.Model
get_ArticleView model =
  case model.onDemand of
    ArticleViewModel mdl -> Just mdl
    _ -> Nothing
set_ArticleView : ArticleView.Model -> Model -> Model
set_ArticleView value model =
  case model.onDemand of
    ArticleViewModel mdl ->
      { model | onDemand = ArticleViewModel value }
    _ -> model


-- MODEL

type alias Model =
  { responseForArticle : WebData Article
  , onDemand: OnDemand
  , mdl : Material.Model
  }

init : Int -> (Model, Cmd Msg)
init id = (initialModel, loadArticle id)

initialModel : Model
initialModel = Model NotAsked NoData Material.model

type OnDemand
  = NoData
  | ArticleViewModel ArticleView.Model

-- ACTION, UPDATE

type Msg
  = ResponseForArticle (WebData Article)
  | ArticleView ArticleView.Msg
  | Mdl (Material.Msg Msg)

type alias Event = ()

update : Msg -> Model -> (Model, Cmd Msg, Maybe Event)
update msg model =
  case msg of
    ResponseForArticle responseForArticle ->
      case responseForArticle of
        Success article ->
          ( { model
            | onDemand = ArticleViewModel <| ArticleView.initialModel article
            , responseForArticle = responseForArticle
            }
          , Cmd.none, Nothing )
        _ -> (model, Cmd.none, Nothing)
    
    ArticleView act ->
      update_ArticleView act model
    --
    Mdl msg_ ->
      withEvent <| Material.update Mdl msg_ model

-- Auto generated update_ArticleView
--   Expects: updateOnEventFrom_ArticleView newEvent myModel
update_ArticleView : ArticleView.Msg -> Model -> ( Model, Cmd Msg, Maybe Event )
update_ArticleView act model =
  let
    maybeOldValue = (get_ArticleView model)
    (myModel, myCmd, maybeNewEvent) = case maybeOldValue of
      Nothing ->
        (model, Cmd.none, Nothing)
      Just oldValue ->
        let
          (newValue, newCmd, wantedEvent)
            = ArticleView.update act oldValue
        in
          ( model |> set_ArticleView newValue, Cmd.map ArticleView newCmd, wantedEvent)
  in
    case maybeNewEvent of
      Nothing ->
        (myModel, myCmd, Nothing)
      Just newEvent ->
        let
          (afterModel, afterCmd, afterEvent)
            = updateOnEventFrom_ArticleView newEvent myModel
        in
          (afterModel, Cmd.batch [myCmd, afterCmd], afterEvent)
updateOnEventFrom_ArticleView :
  ArticleView.Event -> Model -> ( Model, Cmd Msg, Maybe Event )
updateOnEventFrom_ArticleView event model =
  (model, Cmd.none, Nothing)

-- VIEW

view : Model -> Html Msg
view model =
  Page.body ""
    [ case model.responseForArticle of
        NotAsked -> viewSpinner
        Loading -> viewSpinner
        Failure err -> Page.body "Error" [text <| toString err]
        Success article ->
          
            ( let maybeSub = get_ArticleView model
              in
                              case maybeSub of
                                Nothing -> text ""
                                Just sub ->
                                  Html.map ArticleView (ArticleView.view sub)
            )

    ]

viewSpinner = Loading.spinner [ Loading.active True ]

-- HTTP

loadArticle : Int -> Cmd Msg
loadArticle id =
  let
    url
      = Debug.log "Loading"
      <| Config.apiHost ++ "/api/v1/articles/" ++ (toString id)
  in
    (Http.get url decodeArticleData)
      |> RemoteData.sendRequest
      |> Cmd.map ResponseForArticle
