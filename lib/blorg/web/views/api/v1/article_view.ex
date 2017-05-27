defmodule Blorg.Web.API.V1.ArticleView do
  use Blorg.Web, :view

  def render("index.json", %{articles: articles}) do
    %{data: render_many(articles, Blorg.Web.API.V1.ArticleView, "article.json")}
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, Blorg.Web.API.V1.ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{id: article.id,
      title: article.title,
      body: article.body}
  end
end
