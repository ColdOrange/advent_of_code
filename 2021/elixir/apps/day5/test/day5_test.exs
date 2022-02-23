defmodule Day5Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day5", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day5Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day5", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day5Part2.solve(input) == output
    end)
  end
end
