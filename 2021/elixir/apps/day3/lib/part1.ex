defmodule Day3Part1 do
  @moduledoc """
  Day3 - Part1
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.zip_reduce([], fn bits, most_common_bits ->
      [
        if(Enum.count(bits, &(&1 == ?1)) > length(bits) / 2, do: 1, else: 0)
        | most_common_bits
      ]
    end)
    # The most common bits are reversed, so we can just use a bit accumulator to multiple and add.
    |> Enum.reduce({0, 0, 1}, fn most_common_bit, {gamma, epsilon, bit_acc} ->
      if most_common_bit == 1 do
        {gamma + bit_acc, epsilon, bit_acc * 2}
      else
        {gamma, epsilon + bit_acc, bit_acc * 2}
      end
    end)
    |> then(fn {gamma, epsilon, _} -> gamma * epsilon end)
  end
end
