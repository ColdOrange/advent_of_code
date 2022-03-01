defmodule Day8Part1 do
  @moduledoc """
  Day8 - Part1
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("|")
      |> Enum.map(fn part -> part |> String.split() |> Enum.map(&String.to_charlist/1) end)
      |> then(fn [patterns, numbers] -> count(patterns, numbers) end)
    end)
    |> Enum.sum()
  end

  defp count(patterns, numbers) do
    char_mapping = char_mapping(patterns)

    numbers
    |> Enum.map(&parse_number(&1, char_mapping))
    |> Enum.count(&(&1 in [1, 4, 7, 8]))
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

  def parse_number(number, char_mapping) do
    number
    |> Enum.map(&Map.get(char_mapping, &1))
    |> Enum.sort()
    |> then(fn n -> Map.get(@numbers, n) end)
  end

  def char_mapping(patterns) do
    for char <- ?a..?g, into: %{}, do: {char_mapping(patterns, char), char}
  end

  defp char_mapping(patterns, ?e), do: patterns |> char_of_frequency(4)
  defp char_mapping(patterns, ?b), do: patterns |> char_of_frequency(6)
  defp char_mapping(patterns, ?f), do: patterns |> char_of_frequency(9)

  defp char_mapping(patterns, ?c) do
    cf = Enum.find(patterns, &(length(&1) == 2))
    f = char_mapping(patterns, ?f)
    mask(cf, [f])
  end

  defp char_mapping(patterns, ?a) do
    acf = Enum.find(patterns, &(length(&1) == 3))
    cf = Enum.find(patterns, &(length(&1) == 2))
    mask(acf, cf)
  end

  defp char_mapping(patterns, ?d) do
    bcdf = Enum.find(patterns, &(length(&1) == 4))
    bcf = for char <- 'bcf', do: char_mapping(patterns, char)
    mask(bcdf, bcf)
  end

  defp char_mapping(patterns, ?g) do
    abcdefg = Enum.find(patterns, &(length(&1) == 7))
    abcdef = for char <- 'abcdef', do: char_mapping(patterns, char)
    mask(abcdefg, abcdef)
  end

  defp mask(pattern, chars) do
    Enum.find(pattern, &(&1 not in chars))
  end

  defp char_frequencies(patterns) do
    Enum.reduce(patterns, %{}, fn pattern, map ->
      Enum.reduce(pattern, map, fn char, map -> Map.update(map, char, 1, &(&1 + 1)) end)
    end)
  end

  defp char_of_frequency(patterns, frequency) do
    patterns
    |> char_frequencies()
    |> Enum.find(fn {_char, n} -> n == frequency end)
    |> elem(0)
  end
end
