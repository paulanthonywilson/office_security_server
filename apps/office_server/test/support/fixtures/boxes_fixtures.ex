defmodule OfficeServer.BoxesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OfficeServer.Boxes` context.
  """

  alias OfficeServer.Repo
  alias OfficeServer.Boxes.Box

  @doc """
  Generate a box.
  """
  def box_fixture(owner_id, attrs \\ %{}) do
    attrs =
      attrs
      |> Enum.into(%{
        board_id: "some board_id",
        name: "some name"
      })

    %Box{owner_id: owner_id}
    |> Box.changeset(attrs)
    |> Repo.insert!()
  end
end
