defmodule RMT.API.RoastController do
  use RMT.Web, :controller

  alias RMT.Teachers.Roasts
  alias RMT.Models.Roast

  action_fallback RMT.Web.FallbackController
  plug RMT.Helpers.Assigner, ["teacher_id"]

  def index(conn, _params) do
    roasts = Roasts.list_roasts(conn.assigns[:teacher_id])
    render(conn, "index.json", roasts: roasts)
  end

  def create(conn, %{"roast" => roast_params}) do
    with {:ok, %Roast{} = roast} <- Roasts.create_roast(conn.assigns[:teacher_id], roast_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", teacher_roast_path(conn, conn.assigns[:teacher_id], :show, roast))
      |> render("show.json", roast: roast)
    end
  end

  def show(conn, %{"id" => id}) do
    roast = Roasts.get_roast!(id)
    render(conn, "show.json", roast: roast)
  end

  def update(conn, %{"id" => id, "roast" => roast_params}) do
    roast = Roasts.get_roast!(id)

    with {:ok, %Roast{} = roast} <- Roasts.update_roast(roast, roast_params) do
      render(conn, "show.json", roast: roast)
    end
  end

  def delete(conn, %{"id" => id}) do
    roast = Roasts.get_roast!(id)
    with {:ok, %Roast{}} <- Roasts.delete_roast(roast) do
      send_resp(conn, :no_content, "")
    end
  end
end
