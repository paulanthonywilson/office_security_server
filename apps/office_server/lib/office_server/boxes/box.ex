defmodule OfficeServer.Boxes.Box do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boxes" do
    field :board_id, :string
    field :name, :string
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(box, attrs) do
    box
    |> cast(attrs, [:board_id, :name])
    |> validate_required([:board_id, :name])
  end
end
