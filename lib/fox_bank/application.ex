defmodule FoxBank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FoxBank.Repo,
      # Start the Telemetry supervisor
      FoxBankWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FoxBank.PubSub},
      # Start the Endpoint (http/https)
      FoxBankWeb.Endpoint,
      # Start a worker by calling: FoxBank.Worker.start_link(arg)
      # {FoxBank.Worker, arg}
      # Commanded
      FoxBank.CommandedApplication,

      # Projectors
      FoxBank.Core.Accounts.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoxBank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoxBankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
