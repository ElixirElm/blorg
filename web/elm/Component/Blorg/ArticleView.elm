--
--
module Component.Blorg.ArticleView
  exposing
    ( Model, init, initialModel
    , Msg
    , Event
    , update, view)

import Type.Blorg.Article exposing(..)

import Type.Blorg.Exts exposing(..)
import Type.Blorg.Event exposing(..)
import Type.Blorg.Page as Page

-- Import Html
import Html exposing (Html, text, p)

import Exts.Html exposing(..)
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
import Material.Color as Color

-- MODEL

type alias Model =
  { article : Article
  , mdl : Material.Model
      -- Boilerplate: model store for any and all Mdl components you use.
  }

init : Article -> (Model, Cmd Msg)
init article =
  ( initialModel article
  , Cmd.none
  )

initialModel : Article -> Model
initialModel article =
    Model article Material.model


-- ACTION, UPDATE

type Msg
  = Mdl (Material.Msg Msg)
    -- Boilerplate: Msg clause for internal Mdl messages.

type alias Event = ()

update : Msg -> Model -> (Model, Cmd Msg, Maybe Event)
update msg model =
  case msg of
    -- Boilerplate: Mdl action handler.
    Mdl msg_ ->
      withEvent <| Material.update Mdl msg_ model

-- VIEW

type alias Mdl =
  Material.Model

view : Model -> Html Msg
view model =
  div []
  [ Page.title model.article.title
  , styled p [  ]
      [ text <| model.article.body ]
  ]

