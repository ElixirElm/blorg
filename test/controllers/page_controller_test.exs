defmodule Blorg.PageControllerTest do
  use Blorg.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    response = html_response(conn, 200)
    assert  response =~ "Blorg"
  end
end
