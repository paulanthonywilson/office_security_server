defmodule OfficeServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OfficeServer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: OfficeServer.PubSub}
      # Start a worker by calling: OfficeServer.Worker.start_link(arg)
      # {OfficeServer.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: OfficeServer.Supervisor)
  end
end
