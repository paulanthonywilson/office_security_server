defmodule OfficeServer.Tokens do
  @moduledoc """
  Secure tokens for boxes. Breaking rules by allowing for different token types
  that are not yet needed.
  """

  alias Plug.Crypto

  @four_weeks 60 * 60 * 24 * 7 * 4

  @type token_target :: :box

  defguard valid_token_target(destination)
           when destination in [:box]

  @spec to_token(term(), token_target(), keyword()) :: binary()
  def to_token(term, token_target, opts \\ []) when valid_token_target(token_target) do
    Crypto.encrypt(secret(token_target), salt(token_target), term, opts)
  end

  @spec from_token(binary(), token_target()) ::
          {:ok, term()} | {:error, :expired | :invalid | :missing}
  def from_token(token, token_target) when valid_token_target(token_target) do
    Crypto.decrypt(secret(token_target), salt(token_target), token, max_age: max_age(token_target))
  end

  defp secret(token_target), do: token_config(token_target, :secret)
  defp salt(token_target), do: token_config(token_target, :salt)

  defp token_config(token_target, key) do
    token_target
    |> token_env()
    |> Keyword.fetch!(key)
  end

  defp token_env(target) do
    :office_server
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(target)
  end

  @doc """
  The maximum agen in seconds for the token type
  """
  @spec max_age(token_target()) :: pos_integer()
  def max_age(:box), do: @four_weeks
end
