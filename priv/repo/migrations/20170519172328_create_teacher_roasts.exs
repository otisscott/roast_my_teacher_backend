defmodule RMT.Repo.Migrations.CreateRMT.Teacher.Roasts do
  use Ecto.Migration

  def change do
    create table(:teacher_roasts) do
      add :rating, :integer
      add :comment, :string

      timestamps()
    end

  end
end
