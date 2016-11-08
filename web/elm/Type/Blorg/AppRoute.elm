module Type.Blorg.AppRoute
  exposing
    ( AppRoute(NotInitialized, NotFound, Home, ArticleList,Article)
    , toRoute
    , toPath
    , doRedirects
    )

import RouteParser exposing (..)

-- Redirections

doRedirects : AppRoute -> AppRoute
doRedirects route =
  case route of
    Home -> ArticleList
    _ -> route

-- GLobal Routes

toRoute location =
  match matchers location

type AppRoute
  = NotInitialized
  | NotFound
  | Home
  | ArticleList
  | Article Int

matchers =
  [ static Home ""
  , static Home "/"
  , static ArticleList "/articles"
  , static ArticleList "/articles/"
  , dyn1 Article "/articles/" int ""
  ] 

toPath : AppRoute -> String
toPath route =
  case route of
    NotInitialized -> "/404"
    NotFound -> "/404"
    Home -> ""
    ArticleList -> "/articles/"
    Article id -> "/article/" ++ (toString id)
