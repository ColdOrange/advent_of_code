defmodule Day9Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day9", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day9Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day9", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day9Part2.solve(input) == output
    end)
  end
end
