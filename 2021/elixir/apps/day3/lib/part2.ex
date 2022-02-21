defmodule Day3Part2 do
  @moduledoc """
  Day3 - Part2
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> then(fn list -> rating(list, :oxygen) * rating(list, :co2) end)
  end

  defp rating(list, type) do
    rating(list, type, 0)
  end

  defp rating(list, type, bit) when length(list) > 1 do
    bit_1 = Enum.filter(list, fn v -> String.at(v, bit) == "1" end)
    bit_0 = Enum.filter(list, fn v -> String.at(v, bit) == "0" end)

    {most_common, least_common} =
      if length(bit_1) >= length(bit_0) do
        {bit_1, bit_0}
      else
        {bit_0, bit_1}
      end

    case type do
      :oxygen -> rating(most_common, type, bit + 1)
      :co2 -> rating(least_common, type, bit + 1)
    end
  end

  defp rating([last], _type, _bit) do
    String.to_integer(last, 2)
  end
end
