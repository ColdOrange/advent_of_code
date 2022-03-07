defmodule Day10Part2 do
  @moduledoc """
  Day10 - Part2
  """

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn chunk, acc ->
      case corrupted?(chunk) do
        {false, stack} -> [points(stack) | acc]
        _ -> acc
      end
    end)
    |> Enum.sort()
    |> then(fn list -> Enum.at(list, div(length(list), 2)) end)
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

  defp corrupted?(<<>>, stack), do: {false, stack}
  defp corrupted?(_, _), do: {true, nil}

  @points %{
    ?( => 1,
    ?[ => 2,
    ?{ => 3,
    ?< => 4
  }
  defp points(stack) do
    Enum.reduce(stack, 0, fn char, acc ->
      acc * 5 + @points[char]
    end)
  end
end
