defmodule OfficeServerWeb.BoxRegistrationController do
  @moduledoc """
  Called by the box to register against the controller
  """
  use OfficeServerWeb, :controller

  alias OfficeServer.Boxes

  def register(conn, %{
        "email" => email,
        "password" => password,
        "board_id" => board_id,
        "name" => name
      }) do
    case Boxes.register(email, password, board_id, name) do
      {:ok, token} ->
        conn
        |> put_status(201)
        |> json(%{token: token})

      {:error, :authentication} ->
        conn
        |> put_status(:unauthorized)
        |> json("nope")

      {:error, _} ->
        conn
        |> put_status(:bad_request)
        |> json("¯\(°_o)/¯☕️")
    end
  end

  def register(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json("¯\(°_o)/¯")
  end
end
