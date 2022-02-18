defmodule Day1Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day1", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day1Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day1", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day1Part2.solve(input) == output
    end)
  end
end
