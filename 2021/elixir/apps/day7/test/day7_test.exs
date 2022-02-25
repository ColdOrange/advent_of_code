defmodule Day7Test do
  use ExUnit.Case

  test "part1" do
    TestData.get("day7", "part1")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day7Part1.solve(input) == output
    end)
  end

  test "part2" do
    TestData.get("day7", "part2")
    |> Enum.each(fn %{"input" => input, "output" => output} ->
      assert Day7Part2.solve(input) == output
    end)
  end
end
