defmodule RMT.Auth.Key do
  use Ecto.Schema
  import Ecto.Changeset
  alias RMT.Auth.Key


  schema "auth_key" do
    field :hash, :string

    timestamps()
  end

  @doc false
  def changeset(%Key{} = key, attrs) do
    key
    |> cast(attrs, [:hash])
    |> validate_required([:hash])
  end
end
