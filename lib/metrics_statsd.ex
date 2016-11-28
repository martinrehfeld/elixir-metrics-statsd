defmodule MetricsStatsD.Statix do
  use Statix, runtime_config: true
end

defmodule MetricsStatsD do
  @moduledoc """
  Metrics reporting module for Statsd.
  """

  def new(_type, _name) do
    :ok
  end

  def increment_counter(name) do
    __MODULE__.Statix.increment(sanitize(name))
  end

  def increment_counter(name, value) do
    __MODULE__.Statix.increment(sanitize(name), value)
  end

  def decrement_counter(name) do
    __MODULE__.Statix.decrement(sanitize(name))
  end

  def decrement_counter(name, value) do
    __MODULE__.Statix.decrement(sanitize(name), value)
  end

  def update_histogram(name, fun) when is_function(fun, 0) do
    {elapsed, result} = :timer.tc(fun)
    update_histogram(name, elapsed / 1_000)

    result
  end

  def update_histogram(name, value) do
    __MODULE__.Statix.timing(sanitize(name), value)
  end

  def update_gauge(name, value) do
    __MODULE__.Statix.gauge(sanitize(name), value)
  end

  def update_meter(_name, _value) do
    :not_implemented
  end

  def delete(_name) do
    :ok
  end

  defp sanitize([h|_] = name) when h in [:hackney,:hackney_pool], do: name |> Enum.map(&sanitize/1) |> Enum.join(".")
  defp sanitize(name) when is_list(name), do: Enum.map(name, &sanitize/1)
  defp sanitize(name) when is_atom(name), do: Atom.to_string(name)
  defp sanitize(name), do: name

end
