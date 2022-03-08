defmodule Day11Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day11", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day11Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day11", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day11Part2.solve(input) == output
    end)
  end
end
