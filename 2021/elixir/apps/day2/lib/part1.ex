defmodule Day2Part1 do
  @moduledoc """
  Day2 - Part1
  """

  defmodule SubmarineState do
    defstruct horizontal: 0, depth: 0
  end

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%SubmarineState{}, &dive/2)
    |> then(fn %SubmarineState{horizontal: h, depth: d} -> h * d end)
  end

  defp dive("forward " <> value, %SubmarineState{horizontal: h, depth: d}) do
    %SubmarineState{horizontal: h + String.to_integer(value), depth: d}
  end

  defp dive("up " <> value, %SubmarineState{horizontal: h, depth: d}) do
    %SubmarineState{horizontal: h, depth: d - String.to_integer(value)}
  end

  defp dive("down " <> value, %SubmarineState{horizontal: h, depth: d}) do
    %SubmarineState{horizontal: h, depth: d + String.to_integer(value)}
  end
end
