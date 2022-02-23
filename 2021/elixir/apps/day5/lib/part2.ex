defmodule Day5Part2 do
  @moduledoc """
  Day5 - Part2
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, points -> add_points(points, line) end)
    |> Enum.count(fn {_point, count} -> count >= 2 end)
  end

  defp add_points(points, line) do
    line
    |> parse_line()
    |> points_on_line()
    |> Enum.reduce(points, fn point, points ->
      Map.update(points, point, 1, fn count -> count + 1 end)
    end)
  end

  defp parse_line(line) do
    line
    |> String.split(" -> ")
    |> Enum.map(fn part ->
      part |> String.split(",") |> Enum.map(&String.to_integer/1)
    end)
  end

  defp points_on_line([[x1, y1], [x2, y2]]) when x1 == x2 or y1 == y2 do
    for x <- min(x1, x2)..max(x1, x2),
        y <- min(y1, y2)..max(y1, y2),
        do: {x, y}
  end

  defp points_on_line([[x1, y1], [x2, y2]]) when x1 + y1 == x2 + y2 do
    for x <- min(x1, x2)..max(x1, x2),
        do: {x, x1 + y1 - x}
  end

  defp points_on_line([[x1, y1], [x2, y2]]) when x1 - y1 == x2 - y2 do
    for x <- min(x1, x2)..max(x1, x2),
        do: {x, x + y1 - x1}
  end

  defp points_on_line(_), do: []
end
