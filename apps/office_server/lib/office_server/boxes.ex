defmodule OfficeServer.Boxes do
  @moduledoc """
  The Boxes context.
  """

  import Ecto.Query, warn: false
  alias OfficeServer.Repo

  alias OfficeServer.Accounts
  alias OfficeServer.Boxes.Box

  def register(owner_email, owner_password, board_id, name) do
    with {:ok, owner_id} <- get_authenticated_user_id(owner_email, owner_password),
         {:ok, %Box{}} <- create_box(owner_id, board_id, name) do
      {:ok, "a token"}
    end
  end


  defp get_authenticated_user_id(email, password) do
    case  Accounts.get_user_by_email_and_password(email, password) do
      %{id: id} -> {:ok, id}
      _ -> {:error, :authentication}
    end
  end

  defp create_box(owner_id, board_id, name) do
    %Box{owner_id: owner_id}
    |> Box.changeset(%{name: name, board_id: board_id})
    |> Repo.insert()
  end

  def boxes_owned_by(user_id) do
    Repo.all(from b in Box, where: b.owner_id == ^user_id)
  end
end
