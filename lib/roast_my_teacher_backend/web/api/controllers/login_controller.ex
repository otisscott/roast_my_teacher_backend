defmodule RMT.API.LoginController do
  use RMT.Web, :controller
  alias RMT.Auth.Authenticate

  def login(conn, %{"student_id" => student_id}) do
    if not Kernel.is_binary(student_id) do
      conn |> put_status(422) |> text("student_id must be a string")
    else
      case Authenticate.gen_access_token(student_id) do
        {:ok, token} -> json(conn, %{access_token: token})
        _ -> conn |> put_status(500) |> text("Error")
      end
    end
  end

end