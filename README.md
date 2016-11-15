# MetricsStatsd

`metrics_statsd` provides an Elixir wrapper around the [Erlang metrics app
from Hackney](https://github.com/benoitc/erlang-metrics) and adds a reporting
module for Statsd.

**Please note**: This wrapper is suitable for version `~> 1.0.1` of `metrics`.

## Installation

  1. Add `metrics_statsd` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:metrics_statsd, "~> 1.0.1"}]
    end
    ```

  2. Ensure `metrics_statsd` is initialized before usage:

    ```elixir
    Metrics.init() # uses statsd reporting by default

    # OR specify the repoting module to use (e.g. the original Folsom module)
    Metrics.init(:metrics_folsom)
    ```

  3. Send metrics (examples)

    ```elixir
      Metrics.increment "mycounter"

      Metrics.time "mytimer", fn ->
        # code to time
      end
    ```

## Using the MetricsStatsD reporting module

`MetricsStatsD` uses `Statix` under the hood, so please
make sure to configure it to your liking, e.g.

```elixir
config :statix,
  host: "statsd",
  port: 8125
  prefix: "myapp",
```
