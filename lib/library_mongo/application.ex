defmodule LibraryMongo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # defp get_env(key) do
  #   Application.get_env(:library_mongo, LibraryMongo.Repo)[key]
  # end

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LibraryMongoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LibraryMongo.PubSub},
      # Start the Endpoint (http/https)
      LibraryMongoWeb.Endpoint,
      # Start a worker by calling: LibraryMongo.Worker.start_link(arg)
      # {LibraryMongo.Worker, arg}
      #{Mongo, [name: :mongo, database: get_env(:database), username: get_env(:username), password: get_env(:password), pool_size: get_env(:pool_size)]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LibraryMongo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LibraryMongoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
