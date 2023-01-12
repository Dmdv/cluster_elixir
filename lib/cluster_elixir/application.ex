defmodule ClusterElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      default: [
        strategy: Cluster.Strategy.Kubernetes.DNS,
        config: [
          service: "my-elixir-app-svc-headless",
          application_name: "my_app"
        ]
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: ClusterElixir.ClusterSupervisor]]},
      # Starts a worker by calling: ClusterElixir.Worker.start_link(arg)
      # {ClusterElixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClusterElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
