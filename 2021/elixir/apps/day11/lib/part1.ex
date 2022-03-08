defmodule Day11Part1 do
  @moduledoc """
  Day11 - Part1
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
    Enum.reduce(1..100, {map, 0}, fn _, {map, acc} ->
      map = step(map)
      {map, acc + flashed(map)}
    end)
    |> elem(1)
  end

  defp flashed(map) do
    Enum.count(map, fn {_point, level} -> level == 0 end)
  end

  defp step(map) do
    map
    |> Map.new(fn {point, level} -> {point, level + 1} end)
    |> flash()
  end

  defp flash(map) do
    energy_full = Enum.filter(map, fn {_point, level} -> level > 9 end)

    if Enum.empty?(energy_full) do
      map
    else
      energy_full
      |> Enum.reduce(map, fn {point, _level}, map ->
        flash(Map.put(map, point, 0), point)
      end)
      |> flash()
    end
  end

  defp flash(map, point) do
    Enum.reduce(neighbors(point), map, fn point, map ->
      if map[point] in [nil, 0], do: map, else: Map.update!(map, point, &(&1 + 1))
    end)
  end

  defp neighbors(point = {row, col}) do
    for r <- (row - 1)..(row + 1), c <- (col - 1)..(col + 1), {r, c} != point, do: {r, c}
  end
end
