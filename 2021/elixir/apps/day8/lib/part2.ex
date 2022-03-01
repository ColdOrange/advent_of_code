defmodule Day8Part2 do
  @moduledoc """
  Day8 - Part2
  """

  def solve(input) do
    fingerprints_map = fingerprints_map()

    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("|")
      |> Enum.map(fn part -> part |> String.split() |> Enum.map(&String.to_charlist/1) end)
      |> then(fn [patterns, numbers] -> calc(fingerprints_map, patterns, numbers) end)
    end)
    |> Enum.sum()
  end

  defp calc(fingerprints_map, patterns, numbers) do
    pattern_fingerprints = pattern_fingerprints(patterns)

    numbers
    |> Enum.map(fn number ->
      number
      |> Enum.sort()
      |> then(&Map.get(pattern_fingerprints, &1))
      |> then(&Map.get(fingerprints_map, &1))
    end)
    |> Integer.undigits()
  end

  @numbers %{
    'abcefg' => 0,
    'cf' => 1,
    'acdeg' => 2,
    'acdfg' => 3,
    'bcdf' => 4,
    'abdfg' => 5,
    'abdefg' => 6,
    'acf' => 7,
    'abcdefg' => 8,
    'abcdfg' => 9
  }

  defp fingerprints_map() do
    @numbers
    |> Map.keys()
    |> pattern_fingerprints()
    |> Map.new(fn {k, v} -> {v, Map.get(@numbers, k)} end)
  end

  defp pattern_fingerprints(patterns) do
    char_frequencies = char_frequencies(patterns)

    for pattern <- patterns,
        into: %{},
        do: {
          pattern |> Enum.sort(),
          pattern |> Enum.map(&Map.get(char_frequencies, &1)) |> Enum.sum()
        }
  end

  defp char_frequencies(patterns) do
    Enum.reduce(patterns, %{}, fn pattern, map ->
      Enum.reduce(pattern, map, fn char, map -> Map.update(map, char, 1, &(&1 + 1)) end)
    end)
  end
end
