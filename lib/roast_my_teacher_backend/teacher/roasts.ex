defmodule RMT.Teacher.Roasts do
  use Ecto.Schema
  import Ecto.Changeset
  alias RMT.Teacher.Roasts


  schema "teacher_roasts" do
    field :comment, :string
    field :rating, :integer

    timestamps()
  end

  @doc false
  def changeset(%Roasts{} = roasts, attrs) do
    roasts
    |> cast(attrs, [:rating, :comment])
    |> validate_required([:rating, :comment])
  end
end
