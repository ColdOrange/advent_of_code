defmodule Day10Part1 do
  @moduledoc """
  Day10 - Part1
  """

  @points %{
    ?) => 3,
    ?] => 57,
    ?} => 1197,
    ?> => 25137
  }

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn chunk, acc ->
      case corrupted?(chunk) do
        {true, illegal} -> acc + @points[illegal]
        _ -> acc
      end
    end)
  end

  defp corrupted?(chunk) do
    corrupted?(chunk, [])
  end

  defp corrupted?(<<head, rest::binary>>, stack) when head in [?[, ?{, ?(, ?<] do
    corrupted?(rest, [head | stack])
  end

  defp corrupted?(<<?], rest::binary>>, [?[ | stack]), do: corrupted?(rest, stack)
  defp corrupted?(<<?}, rest::binary>>, [?{ | stack]), do: corrupted?(rest, stack)
  defp corrupted?(<<?), rest::binary>>, [?( | stack]), do: corrupted?(rest, stack)
  defp corrupted?(<<?>, rest::binary>>, [?< | stack]), do: corrupted?(rest, stack)

  defp corrupted?(<<head, _rest::binary>>, _stack), do: {true, head}
  defp corrupted?(<<>>, _stack), do: {false, nil}
end
