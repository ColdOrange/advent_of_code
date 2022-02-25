defmodule Day7Part1 do
  @moduledoc """
  Day7 - Part1
  """

  require Integer

  def solve(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> settle()
  end

  defp settle(points) do
    median = median(points)
    Enum.reduce(points, 0, fn point, acc -> acc + abs(point - median) end)
  end

  defp median(points) do
    points |> Enum.sort() |> Enum.at(ceil(length(points) / 2))
  end
end
