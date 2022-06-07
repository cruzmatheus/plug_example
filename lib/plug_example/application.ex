defmodule PlugExample.Application do
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    port = cowboy_port()
    children = [
      {Plug.Cowboy, scheme: :http, plug: PlugExample.Router, options: [port: port]}
    ]
    opts = [strategy: :one_for_one, name: PlugExample.Supervisor]
    Logger.info "Starting application on port #{port}..."
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:example, :cowboy_port, 8080)
end
