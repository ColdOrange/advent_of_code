defmodule Day9Part1 do
  @moduledoc """
  Day9 - Part1
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {list, row}, map ->
      list
      |> Enum.with_index()
      |> Enum.reduce(map, fn {number, col}, map ->
        Map.put(map, {row, col}, number - ?0)
      end)
    end)
    |> sum()
  end

  defp sum(map) do
    Enum.reduce(map, 0, fn {point, number}, acc ->
      if check(map, point, number), do: acc + number + 1, else: acc
    end)
  end

  defp check(map, point, number) do
    Enum.all?(neighbors(point), fn point ->
      map[point] == nil or map[point] > number
    end)
  end

  defp neighbors(_point = {row, col}) do
    [
      {row - 1, col},
      {row + 1, col},
      {row, col - 1},
      {row, col + 1}
    ]
  end
end
