defmodule Blorg.Web.API.V1.ArticleControllerTest do
  use Blorg.Web.ConnCase

  alias Blorg.Article
  @valid_attrs %{body: "some content", title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_article_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    article = Repo.insert! %Article{}
    conn = get conn, v1_article_path(conn, :show, article)
    assert json_response(conn, 200)["data"] == %{"id" => article.id,
      "title" => article.title,
      "body" => article.body}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, v1_article_path(conn, :show, -1)
    end
  end

#   test "creates and renders resource when data is valid", %{conn: conn} do
#     conn = post conn, v1_article_path(conn, :create), article: @valid_attrs
#     assert json_response(conn, 201)["data"]["id"]
#     assert Repo.get_by(Article, @valid_attrs)
#   end

#   test "does not create resource and renders errors when data is invalid", %{conn: conn} do
#     conn = post conn, v1_article_path(conn, :create), article: @invalid_attrs
#     assert json_response(conn, 422)["errors"] != %{}
#   end

#   test "updates and renders chosen resource when data is valid", %{conn: conn} do
#     article = Repo.insert! %Article{}
#     conn = put conn, v1_article_path(conn, :update, article), article: @valid_attrs
#     assert json_response(conn, 200)["data"]["id"]
#     assert Repo.get_by(Article, @valid_attrs)
#   end

#   test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
#     article = Repo.insert! %Article{}
#     conn = put conn, v1_article_path(conn, :update, article), article: @invalid_attrs
#     assert json_response(conn, 422)["errors"] != %{}
#   end

#   test "deletes chosen resource", %{conn: conn} do
#     article = Repo.insert! %Article{}
#     conn = delete conn, v1_article_path(conn, :delete, article)
#     assert response(conn, 204)
#     refute Repo.get(Article, article.id)
#   end
end
