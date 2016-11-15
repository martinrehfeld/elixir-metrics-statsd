defmodule Metrics do
  @moduledoc """
  Wrapper module for the Erlang `metrics` app.
  """

  @app_name :metrics_statsd
  @default_reporter MetricsStatsD

  @doc """
  Initialize the `Metrics` module and set the reporting module to use;
  defaults to `MetricsStatsD`. This function must be called before using
  any of the other functions of this module.

  If `init` was called before, the reporting module will NOT be re-set
  or updated.

  Returns `:ok`.

  ## Examples

      iex> Metrics.init(:metrics_folsom)
      :ok

  """
  def init(mod_metrics \\ @default_reporter) do
    unless metrics_engine, do: set_reporter_module(mod_metrics)
  end

  @doc """
  Set the reporting module to use. Unlike `init`, this function can
  also be used to change the module after initialization.
  """
  def set_reporter_module(mod_metrics) do
    init_reporter_module(mod_metrics)
    Application.put_env(@app_name, :metrics_engine, :metrics.init(mod_metrics))
  end

  def init_reporter_module(MetricsStatsD), do: :ok = MetricsStatsD.Statix.connect
  def init_reporter_module(_), do: :ok

  @doc """
  Wrapper for `:metrics.update_histogram/3`.
  """
  def timer(name, fun_or_value) do
    :metrics.update_histogram(metrics_engine!, name, fun_or_value)
  end

  @doc """
  Wrapper for `:metrics.increment/2`.
  """
  def increment(name) do
    :metrics.increment_counter(metrics_engine!, name)
  end

  @doc """
  Wrapper for `:metrics.increment/3`.
  """
  def increment(name, value) do
    :metrics.increment_counter(metrics_engine!, name, value)
  end

  @doc """
  Wrapper for `:metrics.decrement/2`.
  """
  def decrement(name) do
    :metrics.decrement_counter(metrics_engine!, name)
  end

  @doc """
  Wrapper for `:metrics.decrement/3`.
  """
  def decrement(name, value) do
    :metrics.decrement_counter(metrics_engine!, name, value)
  end

  defp metrics_engine,  do: Application.get_env(@app_name, :metrics_engine)
  defp metrics_engine!, do: Application.fetch_env!(@app_name, :metrics_engine)
end
