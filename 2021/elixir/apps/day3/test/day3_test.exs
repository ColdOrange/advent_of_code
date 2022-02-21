defmodule Day3Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day3", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day3Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day3", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day3Part2.solve(input) == output
    end)
  end
end
