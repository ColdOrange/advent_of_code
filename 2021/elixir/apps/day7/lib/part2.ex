defmodule Day7Part2 do
  @moduledoc """
  Day7 - Part2
  """

  require Integer

  def solve(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> settle()
  end

  # There is in fact a math proof that the answer is either floor(mean) or ceil(mean), though I didn't come up with.
  # see: https://www.reddit.com/r/adventofcode/comments/rawxad/2021_day_7_part_2_i_wrote_a_paper_on_todays
  # or proof_of_part2.pdf
  defp settle(points) do
    all =
      for k <- Enum.min(points)..Enum.max(points),
          do: Enum.reduce(points, 0, fn p, acc -> acc + div(abs(k - p) * (abs(k - p) + 1), 2) end)

    Enum.min(all)
  end
end
