defmodule Day1Part1 do
  @moduledoc """
  Day1 - Part1
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> increases
  end

  defp increases([head | rest]), do: increases(rest, head)
  defp increases([head | rest], last) when head > last, do: increases(rest, head) + 1
  defp increases([head | rest], _last), do: increases(rest, head)
  defp increases([], _), do: 0
end
