defmodule RMT.Models.Roast do
  use Ecto.Schema
  import Ecto.Changeset
  alias RMT.Models.{Teacher, Roast}


  schema "roasts" do
    field :comment, :string
    field :rating, :integer

    belongs_to :teacher, Teacher

    timestamps()
  end

  def changeset(%Roast{} = roasts, attrs) do
    roasts
    |> cast(attrs, [:rating, :comment])
    |> validate_required([:rating, :comment])
    |> cast_assoc(:teacher)
    |> validate_length(:comment, min: 1, max: 1600)
  end
end
