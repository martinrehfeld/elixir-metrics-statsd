defmodule MetricsStatsD do
  @moduledoc """
  Metrics reporting module for Statsd.
  """

  def new(_type, _name) do
    :ok
  end

  def increment_counter(name) do
    ExStatsD.increment(name)
  end

  def increment_counter(name, value) do
    ExStatsD.counter(value, name)
  end

  def decrement_counter(name) do
    ExStatsD.decrement(name)
  end

  def decrement_counter(name, value) do
    ExStatsD.counter(name, value)
  end

  def update_histogram(name, fun) when is_function(fun, 0) do
    before_time = System.system_time(:micro_seconds)
    result = fun.()
    after_time = System.system_time(:micro_seconds)
    diff_ms = (after_time - before_time) / 1_000
    update_histogram(name, diff_ms)
    result
  end

  def update_histogram(name, value) do
    ExStatsD.timer(value, name)
  end

  def update_gauge(name, value) do
    ExStatsD.gauge(value, name)
  end

  def update_meter(_name, _value) do
    throw :not_implemented
  end

  def delete(_name) do
    :ok
  end
end
