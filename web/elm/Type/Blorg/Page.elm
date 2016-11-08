--
--
module Type.Blorg.Page exposing(..)

import Type.Blorg.Config as Config

import Material.Color as Color
import Material.Layout as Layout
import Material.Scheme as Scheme

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

body t content =
  div boxed <| (title t) :: content

boxed : List (Options.Property a b)
boxed =
  [ css "margin" "auto"
  , css "padding-left" "8%"
  , css "padding-right" "8%"
  ]

layout mdlMsg mdl main  =
  let
    header =
      [ Layout.row [ Color.text Color.white]
        [ Layout.title [] [ text "Blorg" ]
        ]
      ]
  in
    scheme <|
      Layout.render mdlMsg mdl
        [ Layout.fixedHeader
        , Layout.waterfall True
        ]
        { header = header
        , drawer = []
        , tabs = ([],[])
        , main = main
        }


scheme main =
  case Config.forReactor of
       True -> Scheme.topWithScheme Color.LightBlue Color.Red main
       False -> main

title : String -> Html a
title t =
  Options.styled Html.h1
    [ Color.text Color.primary ]
    [ text t ]

