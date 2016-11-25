defmodule MetricsStatsDTest do
  use ExUnit.Case, async: false
  import Mock

  doctest MetricsStatsD

  test_with_mock "IOList sanitization", MetricsStatsD.Statix, [increment: &(&1)] do
    Enum.each(["hello world",
               ["hello", 32, "world"],
               ["hello ", :world],
               ["hello ", [:w, :o, :r], "ld"]], fn(input) ->
      assert "hello world" == :erlang.iolist_to_binary(MetricsStatsD.increment_counter(input))
    end)

    # Hackney special case
    assert "hello.hackney.foo.bar" == :erlang.iolist_to_binary(MetricsStatsD.increment_counter(["hello.", [:hackney, :foo, :bar]]))
  end
end
