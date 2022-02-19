defmodule Day2Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day2", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day2Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day2", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day2Part2.solve(input) == output
    end)
  end
end
