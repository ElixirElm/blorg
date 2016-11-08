--
--
module Type.Blorg.Article exposing(..)

import Type.Blorg.AppRoute as AppRoute exposing(AppRoute)

import Type.Blorg.Exts as BlorgExts
-- Import Json Decode
import Json.Decode as Decode exposing(Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

type alias Article =
  { id: Int
  , title : String
  , body : String
  }

type alias ArticleList = List Article

toRoute : Article -> AppRoute
toRoute article = (AppRoute.Article article.id)

-- Decoding

decodeArticle : Decoder Article
decodeArticle =
  decode Article
    |> required "id" Decode.int
    |> required "title" Decode.string
    |> required "body" Decode.string

decodeArticleData : Decoder Article
decodeArticleData =
  Decode.at ["data"] decodeArticle

decodeArticleList : Decoder (List Article)
decodeArticleList =
  Decode.list decodeArticle

decodeArticleListData : Decoder (List Article)
decodeArticleListData =
  Decode.at ["data"] decodeArticleList
