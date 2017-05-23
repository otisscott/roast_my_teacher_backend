defmodule RMT.Models.Teacher do
  use Ecto.Schema
  import Ecto.Changeset
  alias RMT.Models.{Roast, Teacher}


  schema "teachers" do
    field :name, :string
    field :subject, :string

    has_many :roasts, Roast

    timestamps()
  end

  def changeset(%Teacher{} = teacher, attrs) do
    teacher
    |> cast(attrs, [:name, :subject])
    |> validate_required([:name, :subject])
  end
end
