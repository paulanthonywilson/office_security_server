defmodule OfficeServer.Boxes do
  @moduledoc """
  The Boxes context.
  """

  import Ecto.Query, warn: false
  alias OfficeServer.Repo

  alias OfficeServer.{Accounts, Tokens}
  alias OfficeServer.Boxes.Box

  @type id :: pos_integer()

  def register(owner_email, owner_password, board_id, name) do
    with {:ok, owner_id} <- get_authenticated_user_id(owner_email, owner_password),
         {:ok, %Box{id: box_id}} <- create_box(owner_id, board_id, name) do
      {:ok, Tokens.to_token(box_id, :box)}
    end
  end

  defp get_authenticated_user_id(email, password) do
    case Accounts.get_user_by_email_and_password(email, password) do
      %{id: id} -> {:ok, id}
      _ -> {:error, :authentication}
    end
  end

  defp create_box(owner_id, board_id, name) do
    %Box{owner_id: owner_id}
    |> Box.changeset(%{name: name, board_id: board_id})
    |> Repo.insert()
    |> maybe_update_instead()
  end

  defp maybe_update_instead({:ok, _} = res), do: res

  defp maybe_update_instead({:error, %{errors: errors, changes: changes}} = res) do
    case Keyword.get(errors, :board_id) do
      {_, [constraint: :unique, constraint_name: "boxes_owner_id_board_id_index"]} ->
        changes
        |> update_from_attributes()

      _ ->
        res
    end
  end

  defp update_from_attributes(%{owner_id: owner_id, board_id: board_id} = attrs) do
    from(b in Box, where: b.owner_id == ^owner_id and b.board_id == ^board_id)
    |> Repo.one!()
    |> Box.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  All the boxes registered to this owner
  """
  @spec boxes_owned_by(id()) :: list(Box.t())
  def boxes_owned_by(user_id) do
    Repo.all(from b in Box, where: b.owner_id == ^user_id)
  end

  @doc """
  Get the box (if owned by this owner)
  """
  @spec get(owner_id :: id(), box_id :: id()) ::
          {:ok, Box.t()} | {:error, :authentication | :not_found}
  def get(owner_id, box_id) do
    case Repo.get(Box, box_id) do
      %{owner_id: ^owner_id} = box -> {:ok, box}
      _ -> {:error, :not_found}
    end
  end

  def from_token(token) do
    with {:ok, box_id} <- Tokens.from_token(token, :box) do
      get_box(box_id)
    end
  end

  def refresh_token(token) do
    with {:ok, box_id} <- Tokens.from_token(token, :box) do
      {:ok, Tokens.to_token(box_id, :box)}
    end
  end

  defp get_box(box_id) do
    case Repo.get(Box, box_id) do
      nil -> {:error, :not_found}
      box -> {:ok, box}
    end
  end
end
