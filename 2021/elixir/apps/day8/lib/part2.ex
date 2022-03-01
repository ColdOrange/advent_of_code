defmodule Day8Part2 do
  @moduledoc """
  Day8 - Part2
  """

  import Day8Part1, only: [parse_number: 2, char_mapping: 1]

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("|")
      |> Enum.map(fn part -> part |> String.split() |> Enum.map(&String.to_charlist/1) end)
      |> then(fn [patterns, numbers] -> calc(patterns, numbers) end)
    end)
    |> Enum.sum()
  end

  defp calc(patterns, numbers) do
    char_mapping = char_mapping(patterns)

    numbers
    |> Enum.map(&parse_number(&1, char_mapping))
    |> Integer.undigits()
  end
end
