defmodule Metrics.Mixfile do
  use Mix.Project

  def project do
    [app: :metrics_statsd,
     version: "1.0.1",
     elixir: "~> 1.3",
     deps: deps(),
     description: description(),
     package: package()]
  end

  def application do
    [applications: [:statix, :logger]]
  end

  defp deps do
    [{:statix, git: "https://github.com/lexmag/statix.git"},
     {:metrics, "~> 1.0.1"}]
  end

  defp description do
    """
`metrics_statsd` provides an Elixir wrapper around the [Erlang metrics app
from Hackney](https://github.com/benoitc/erlang-metrics) and adds a reporting
module for Statsd.
    ```
    """
  end

  defp package do
    [name: :metrics_statsd,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Martin Rehfeld"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/martinrehfeld/elixir-metrics-statsd",
              "Docs" => "https://github.com/martinrehfeld/elixir-metrics-statsd"}]
  end
end
