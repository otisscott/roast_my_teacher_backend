defmodule RMT.Repo.Migrations.CreateRMT.Models.Roasts do
  use Ecto.Migration

  def change do
    create table(:roasts) do
      add :rating, :integer
      add :comment, :string

      timestamps()
    end

  end
end
