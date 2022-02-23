defmodule Day6Part1 do
  @moduledoc """
  Day6 - Part1
  """

  def solve(input) do
    input
    |> String.split(",")
    |> Enum.map(&descendants(String.to_integer(&1), 80))
    |> Enum.sum()
  end

  defp descendants(_cycle, days) when days == 0 do
    1
  end

  defp descendants(cycle, days) when cycle == 0 do
    descendants(6, days - 1) + descendants(8, days - 1)
  end

  defp descendants(cycle, days) do
    descendants(cycle - 1, days - 1)
  end
end
