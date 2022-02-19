defmodule Day2Part2 do
  @moduledoc """
  Day2 - Part2
  """

  defmodule SubmarineState do
    defstruct horizontal: 0, depth: 0, aim: 0
  end

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%SubmarineState{}, &dive/2)
    |> then(fn %SubmarineState{horizontal: h, depth: d} -> h * d end)
  end

  defp dive("forward " <> value, %SubmarineState{horizontal: h, depth: d, aim: a}) do
    v = String.to_integer(value)
    %SubmarineState{horizontal: h + v, depth: d + v * a, aim: a}
  end

  defp dive("up " <> value, %SubmarineState{horizontal: h, depth: d, aim: a}) do
    %SubmarineState{horizontal: h, depth: d, aim: a - String.to_integer(value)}
  end

  defp dive("down " <> value, %SubmarineState{horizontal: h, depth: d, aim: a}) do
    %SubmarineState{horizontal: h, depth: d, aim: a + String.to_integer(value)}
  end
end
