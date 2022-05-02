defmodule OfficeServer.Boxes.Box do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

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
