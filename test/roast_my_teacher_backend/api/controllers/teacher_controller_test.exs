defmodule RMT.API.TeacherControllerTest do
  use RMT.Web.ConnCase

  alias RMT.Teachers
  alias RMT.Models.Teacher

  @create_attrs %{name: "some name", subject: "some subject"}
  @update_attrs %{name: "some updated name", subject: "some updated subject"}
  @invalid_attrs %{name: nil, subject: nil}

  def fixture(:teacher) do
    {:ok, teacher} = Teachers.create_teacher(@create_attrs)
    teacher
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, teacher_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates teacher and renders teacher when data is valid", %{conn: conn} do
    conn = post conn, teacher_path(conn, :create), teacher: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, teacher_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name",
      "subject" => "some subject"}
  end

  test "does not create teacher and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, teacher_path(conn, :create), teacher: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen teacher and renders teacher when data is valid", %{conn: conn} do
    %Teacher{id: id} = teacher = fixture(:teacher)
    conn = put conn, teacher_path(conn, :update, teacher), teacher: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, teacher_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name",
      "subject" => "some updated subject"}
  end

  test "does not update chosen teacher and renders errors when data is invalid", %{conn: conn} do
    teacher = fixture(:teacher)
    conn = put conn, teacher_path(conn, :update, teacher), teacher: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen teacher", %{conn: conn} do
    teacher = fixture(:teacher)
    conn = delete conn, teacher_path(conn, :delete, teacher)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, teacher_path(conn, :show, teacher)
    end
  end
end
