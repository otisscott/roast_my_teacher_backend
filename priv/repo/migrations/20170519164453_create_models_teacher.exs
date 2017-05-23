defmodule RMT.Repo.Migrations.CreateRMT.Models.Teacher do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :name, :string
      add :subject, :string

      timestamps()
    end

  end
end
