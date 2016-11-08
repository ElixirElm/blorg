--
--
module Component.Blorg.NotFoundPage
  exposing(Model, init, initialModel, Msg, Event, update, view)

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
import Type.Blorg.Page as Page

-- MODEL

type alias Model = ()

init : (Model, Cmd Msg)
init = (initialModel, Cmd.none)

initialModel : Model
initialModel = ()

-- ACTION, UPDATE

type alias Msg = ()

type alias Event = ()

update : Msg -> Model -> (Model, Cmd Msg, Maybe Event)
update msg model =
  (model, Cmd.none, Nothing)

-- VIEW
view : Model -> Html Msg
view model =
  Page.body "Not Found" []
