defmodule RMT.Web.RoastsControllerTest do
  use RMT.Web.ConnCase

  alias RMT.Teacher
  alias RMT.Teacher.Roasts

  @create_attrs %{comment: "some comment", rating: 42}
  @update_attrs %{comment: "some updated comment", rating: 43}
  @invalid_attrs %{comment: nil, rating: nil}

  def fixture(:roasts) do
    {:ok, roasts} = Teacher.create_roasts(@create_attrs)
    roasts
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, roasts_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates roasts and renders roasts when data is valid", %{conn: conn} do
    conn = post conn, roasts_path(conn, :create), roasts: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, roasts_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "comment" => "some comment",
      "rating" => 42}
  end

  test "does not create roasts and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, roasts_path(conn, :create), roasts: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen roasts and renders roasts when data is valid", %{conn: conn} do
    %Roasts{id: id} = roasts = fixture(:roasts)
    conn = put conn, roasts_path(conn, :update, roasts), roasts: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, roasts_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "comment" => "some updated comment",
      "rating" => 43}
  end

  test "does not update chosen roasts and renders errors when data is invalid", %{conn: conn} do
    roasts = fixture(:roasts)
    conn = put conn, roasts_path(conn, :update, roasts), roasts: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen roasts", %{conn: conn} do
    roasts = fixture(:roasts)
    conn = delete conn, roasts_path(conn, :delete, roasts)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, roasts_path(conn, :show, roasts)
    end
  end
end
