defmodule Day10Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day10", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day10Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day10", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day10Part2.solve(input) == output
    end)
  end
end
