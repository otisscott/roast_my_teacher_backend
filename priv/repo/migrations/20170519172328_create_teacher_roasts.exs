defmodule RMT.Repo.Migrations.CreateRMT.Models.Roasts do
  use Ecto.Migration

  def change do
    create table(:roasts) do
      add :rating, :integer
      add :comment, :string

      add :teacher_id, references(:teachers), on_delete: :delete_all

      timestamps()
    end

  end
end
