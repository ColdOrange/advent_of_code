defmodule Day6Part2 do
  @moduledoc """
  Day6 - Part2
  """

  def solve(input) do
    input
    |> String.split(",")
    |> Enum.map(&descendants(String.to_integer(&1), 256))
    |> Enum.sum()
  end

  defp descendants(cycle, days) do
    # dp: f(n) = f(n-7) + f(n-9)
    state =
      Enum.reduce(1..days, %{}, fn day, state ->
        Map.put(state, day, Map.get(state, day - 7, 1) + Map.get(state, day - 9, 1))
      end)

    Map.get(state, days - cycle)
  end
end
