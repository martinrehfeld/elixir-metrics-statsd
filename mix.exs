defmodule Metrics.Mixfile do
  use Mix.Project

  def project do
    [app: :metrics_statsd,
     version: "1.0.2",
     elixir: "~> 1.3",
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:statix, :logger]]
  end

  defp deps do
    [{:statix, "~> 1.0.0"},
     {:metrics, "~> 1.0.1"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
    """
`metrics_statsd` provides an Elixir wrapper around the [Erlang metrics app
from Hackney](https://github.com/benoitc/erlang-metrics) and adds a reporting
module for Statsd.
    """
  end

  defp package do
    [name: :metrics_statsd,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Martin Rehfeld"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/martinrehfeld/elixir-metrics-statsd",
              "Docs" => "https://hexdocs.pm/metrics_statsd/1.0.2"}]
  end
end
