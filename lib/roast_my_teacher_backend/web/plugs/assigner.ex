defmodule RMT.Helpers.Assigner do
  import Plug.Conn

  def init(opts), do: opts

  def call(%{assigns: _assigns} = conn, names) do
    Enum.reduce(names, conn, fn(name, conn) ->
      assign(conn, String.to_atom(name), conn.params[name])
     end)
  end

end