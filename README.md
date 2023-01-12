# Automatic Cluster Formation and Healing

libcluster is a library that provides a mechanism for automatically forming clusters of Erlang nodes, with either static or dynamic node membership.
It provides a pluggable “strategy” system, with a variety of strategies provided out of the box. The one we care about is the Kubernetes DNS strategy.
Using this strategy, libcluster will perform a DNS query against a headless Kubernetes Service, getting the IP address of all 
Pods running our Erlang cluster:

```docker
---
apiVersion: v1
kind: Service
metadata:
  name: my-elixir-app-svc-headless
  namespace: default
  labels:
    app.kubernetes.io/name: my-elixir-app
    app.kubernetes.io/instance: myapp-svc-headless
spec:
  type: ClusterIP
  clusterIP: None
  ports:
    - port: 4369
      targetPort: epmd
      protocol: TCP
      name: epmd
  selector:
    app.kubernetes.io/name: my-elixir-app
    app.kubernetes.io/instance: myapp-node
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cluster_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cluster_elixir, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/cluster_elixir>.

