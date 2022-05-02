defmodule OfficeServer.BoxesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OfficeServer.Boxes` context.
  """

  @doc """
  Generate a box.
  """
  def box_fixture(attrs \\ %{}) do
    {:ok, box} =
      attrs
      |> Enum.into(%{
        board_id: "some board_id",
        name: "some name"
      })
      |> OfficeServer.Boxes.create_box()

    box
  end
end
