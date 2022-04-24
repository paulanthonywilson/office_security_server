defmodule OfficeServer.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OfficeServer.Accounts` context.
  """
  alias Ecto.Changeset
  alias OfficeServer.Accounts.User
  alias OfficeServer.Repo
  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    attrs
    |> unconfirmed_user_fixture()
    |> confirm()
  end

  def unconfirmed_user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> OfficeServer.Accounts.register_user()

    user
  end

  def confirm(user) do
    user
    |> User.confirm_changeset()
    |> Repo.update!()
  end

  def confirm_user_at(user, confirm_at) do
    user
    |> Changeset.change(confirmed_at: confirm_at)
    |> Repo.update!()
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
