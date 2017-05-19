defmodule RMT.API.TeacherController do
  use RMT.Web, :controller

  alias RMT.Models
  alias RMT.Models.Teacher

  action_fallback RMT.Web.FallbackController

  def index(conn, _params) do
    teachers = Models.list_teachers()
    render(conn, "index.json", teachers: teachers)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    with {:ok, %Teacher{} = teacher} <- Models.create_teacher(teacher_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", teacher_path(conn, :show, teacher))
      |> render("show.json", teacher: teacher)
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = Models.get_teacher!(id)
    render(conn, "show.json", teacher: teacher)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Models.get_teacher!(id)

    with {:ok, %Teacher{} = teacher} <- Models.update_teacher(teacher, teacher_params) do
      render(conn, "show.json", teacher: teacher)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = Models.get_teacher!(id)
    with {:ok, %Teacher{}} <- Models.delete_teacher(teacher) do
      send_resp(conn, :no_content, "")
    end
  end
end