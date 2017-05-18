defmodule RMT.Repo.Migrations.CreateRMT.Auth.Key do
  use Ecto.Migration

  def change do
    create table(:auth_key) do
      add :hash, :string

      timestamps()
    end

  end
end
