defmodule RMT.API.RoastControllerTest do
  use RMT.Web.ConnCase
  require IO

  alias RMT.Teachers.Roasts
  alias RMT.Models.Roast

  @create_attrs %{comment: "some comment", rating: 4}
  @update_attrs %{comment: "some updated comment", rating: 5}
  @invalid_attrs %{comment: nil, rating: nil}

  def fixture(:roast, teacher) do
    {:ok, roast} = Roasts.create_roast(@create_attrs, teacher)
    roast
  end

  setup %{conn: conn} do
    teacher = mock_teacher
    {:ok, teacher: teacher, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn, teacher: teacher} do
    conn = get conn, teacher_roast_path(conn, :index, teacher)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates roast and renders roast when data is valid", %{conn: conn, teacher: teacher} do
    conn = post conn, teacher_roast_path(conn, :create, teacher), roast: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, teacher_roast_path(conn, :show, teacher, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "comment" => @create_attrs.comment,
      "rating" => @create_attrs.rating}
  end

  test "does not create roast and renders errors when data is invalid", %{conn: conn, teacher: teacher} do
    conn = post conn, teacher_roast_path(conn, :create, teacher), roast: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen roast and renders roast when data is valid", %{conn: conn, teacher: teacher} do
    %Roast{id: id} = roast = fixture(:roast, teacher)
    conn = put conn, teacher_roast_path(conn, :update, teacher, roast), roast: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, teacher_roast_path(conn, :show, teacher, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "comment" => @update_attrs.comment,
      "rating" => @update_attrs.rating}
  end

  test "does not update chosen roast and renders errors when data is invalid", %{conn: conn, teacher: teacher} do
    roast = fixture(:roast, teacher)
    conn = put conn, teacher_roast_path(conn, :update, teacher, roast), roast: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen roast", %{conn: conn, teacher: teacher} do
    roast = fixture(:roast, teacher)
    conn = delete conn, teacher_roast_path(conn, :delete, teacher, roast)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, teacher_roast_path(conn, :show, teacher, roast)
    end
  end
end
