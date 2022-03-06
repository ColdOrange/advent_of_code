defmodule Day9Part2 do
  @moduledoc """
  Day9 - Part2
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
    |> calc()
  end

  defp calc(map) do
    Enum.reduce(map, {[], MapSet.new()}, fn {point, _number}, {sizes, visited} ->
      {size, visited} = visit(map, visited, point)
      {[size | sizes], visited}
    end)
    |> elem(0)
    |> Enum.filter(fn size -> size != 0 end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  defp visit(map, visited, point) do
    if map[point] == nil or map[point] == 9 or point in visited do
      {0, visited}
    else
      for neighbor <- neighbors(point), reduce: {1, MapSet.put(visited, point)} do
        {size, visited} ->
          {s, v} = visit(map, visited, neighbor)
          {size + s, MapSet.union(visited, v)}
      end
    end
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
