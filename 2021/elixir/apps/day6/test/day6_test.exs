defmodule Day6Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day6", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day6Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day6", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day6Part2.solve(input) == output
    end)
  end
end
