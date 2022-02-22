defmodule Day4Part1 do
  @moduledoc """
  Day4 - Part1
  """

  defmodule Board do
    defstruct rows: [], cols: []

    def new(lines) do
      rows =
        lines
        |> Enum.map(fn line ->
          line |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
        end)

      cols =
        rows
        |> Enum.zip()
        |> Enum.map(&Tuple.to_list/1)

      %Board{rows: rows, cols: cols}
    end

    def win?(%Board{rows: rows, cols: cols}, numbers) do
      all_in? = fn array ->
        Enum.all?(array, &Enum.member?(numbers, &1))
      end

      Enum.any?(rows, all_in?) or Enum.any?(cols, all_in?)
    end

    def score(%Board{rows: rows}, numbers) do
      sum =
        rows
        |> List.flatten()
        |> Enum.reduce(0, fn n, acc ->
          case Enum.member?(numbers, n) do
            false -> acc + n
            true -> acc
          end
        end)

      sum * List.last(numbers)
    end
  end

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> parse_input()
    |> play()
  end

  defp parse_input([numbers | boards]) do
    {
      numbers |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1),
      boards |> Enum.chunk_every(5) |> Enum.map(&Board.new/1)
    }
  end

  defp play({numbers, boards}) do
    play({numbers, boards}, 5)
  end

  defp play({numbers, boards}, drawn) do
    drawn_numbers = numbers |> Enum.slice(0, drawn)

    case Enum.find(boards, &Board.win?(&1, drawn_numbers)) do
      nil ->
        play({numbers, boards}, drawn + 1)

      board ->
        Board.score(board, drawn_numbers)
    end
  end
end
