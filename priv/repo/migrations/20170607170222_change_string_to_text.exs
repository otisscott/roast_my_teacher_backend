defmodule RMT.Repo.Migrations.ChangeRoastText do
  use Ecto.Migration

  def change do
    alter table(:roasts) do
      modify :comment, :text
    end
    alter table(:teachers) do
      modify :name, :text
      modify :subject, :text
    end
  end
end
