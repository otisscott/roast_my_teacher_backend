defmodule RMT.API.RoastsController do
  use RMT.Web, :controller

  alias RMT.Teacher.Roasts

  action_fallback RMT.Web.FallbackController
  plug RMT.Helpers.Assigner, ["teacher_id"]

  def index(conn, _params) do
    roasts = Teacher.list_roasts(conn.assigns[:teacher_id])
    render(conn, "index.json", roasts: roasts)
  end

  def create(conn, %{"roasts" => roasts_params}) do
    with {:ok, %Roasts{} = roasts} <- Roasts.create_roasts(conn.assigns[:teacher_id], roasts_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", teacher_roasts_path(conn, conn.assigns[:teacher_id], :show, roasts))
      |> render("show.json", roasts: roasts)
    end
  end

  def show(conn, %{"id" => id}) do
    roasts = Roasts.get_roasts!(id)
    render(conn, "show.json", roasts: roasts)
  end

  def update(conn, %{"id" => id, "roasts" => roasts_params}) do
    roasts = Roasts.get_roasts!(id)

    with {:ok, %Roasts{} = roasts} <- Teacher.update_roasts(roasts, roasts_params) do
      render(conn, "show.json", roasts: roasts)
    end
  end

  def delete(conn, %{"id" => id}) do
    roasts = Roasts.get_roasts!(id)
    with {:ok, %Roasts{}} <- Roasts.delete_roasts(roasts) do
      send_resp(conn, :no_content, "")
    end
  end
end
