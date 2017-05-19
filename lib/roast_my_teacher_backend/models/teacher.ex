defmodule RMT.Models.Teacher do
  use Ecto.Schema
  import Ecto.Changeset
  alias RMT.Models.Teacher


  schema "models_teachers" do
    field :name, :string
    field :subject, :string

    timestamps()
  end

  def changeset(%Teacher{} = teacher, attrs) do
    teacher
    |> cast(attrs, [:name, :subject])
    |> validate_required([:name, :subject])
  end
end
