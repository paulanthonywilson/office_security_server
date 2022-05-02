defmodule OfficeServer.Repo.Migrations.CreateBoxes do
  use Ecto.Migration

  def change do
    create table(:boxes) do
      add :board_id, :string
      add :name, :string
      add :owner_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:boxes, [:owner_id, :board_id], unique: true)
  end
end
