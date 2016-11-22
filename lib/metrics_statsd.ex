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
    __MODULE__.Statix.increment(name)
  end

  def increment_counter(name, value) do
    __MODULE__.Statix.increment(name, value)
  end

  def decrement_counter(name) do
    __MODULE__.Statix.decrement(name)
  end

  def decrement_counter(name, value) do
    __MODULE__.Statix.decrement(name, value)
  end

  def update_histogram(name, fun) when is_function(fun, 0) do
    __MODULE__.Statix.measure(name, [], fun)
  end

  def update_histogram(name, value) do
    __MODULE__.Statix.timing(name, value)
  end

  def update_gauge(name, value) do
    __MODULE__.Statix.gauge(name, value)
  end

  def update_meter(_name, _value) do
    throw :not_implemented
  end

  def delete(_name) do
    :ok
  end
end
