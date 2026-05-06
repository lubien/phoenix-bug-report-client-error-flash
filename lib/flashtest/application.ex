defmodule Flashtest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FlashtestWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:flashtest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Flashtest.PubSub},
      # Start a worker by calling: Flashtest.Worker.start_link(arg)
      # {Flashtest.Worker, arg},
      # Start to serve requests, typically the last entry
      FlashtestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Flashtest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FlashtestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
